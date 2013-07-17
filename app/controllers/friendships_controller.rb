#######################################################################
## Controller that manages all REST methods related with User Friends ##
#######################################################################
class FriendshipsController < ApplicationController
  
  # Token authentication
  before_action :set_user, :authenticate
  
  before_action :set_friendship, only: [:show_all, :show, :update, :destroy]

  # Verifying user before the given methods with some filters.
  #before_filter :signed_in_user, only: [:index, :create, :pending, :accept, :omit, :secrets]

  # User must not authenticate in the next methods
  protect_from_forgery :except => [:create]


  # GET /users/:user_id/friendships
  # GET /users/:user_id/friendships.json 
  def index   
    @friendships = @user.friends
    respond_to do |format|
      format.html { render 'index' }
      format.json { render action:'index', location: @friends }
    end
  end

  # GET /users/:user_id/friendships/:friendship_id
  # GET /users/:user_id/friendships/:friendship_id.json
  def show    
    @friendships = Friendship.find_by(friend_id: params[:friend_id], user_id: params[:user_id])
    @public_lovers = friend.lovers.where(visibility: 1)
    @secret_lovers = friend.lovers.where(visibility: 0)

    # If this user doesn't have any friends with this friendship_id, then we throw an errror.
    if !@friendships.nil?
      respond_to do |format|
        format.html { render 'show' }
        format.json { render action:'show' }
      end
    else
      respond_to do |format|
        format.html { render 'show' }
        format.json { render :json => {:Error => "This friendship doesn't belong to the given user"}, status: :unprocessable_entity }
      end

    end
  end


  # POST /users/:user_id/friendships.json
  # POST /users/:user_id/friendships
  def create

    #Flag that indicates if any invitations can be sent
    invitation_sent = false

    # Sender user
    @user_sender= User.find(params[:user_id])

    # Parsing JSON and iterating through each friend.
    friendships = JSON.parse(params[:friendships].to_json)
    friendships.each do |friendship|      

      # Checking if friend is an existing user or not.
      if friendship.has_key?("user_id")
        logger.debug "USER INVITATION to user_id: #{friendship['user_id']}"

        # Create a friendship between the user that sends the invitation and receiver with accepted = false (default).
        @user_sender.friendships.create(friend_id: friendship["user_id"])

        # Creating the reverse relationship with pending = true.
        @user_receiver = User.find(friendship["user_id"])        
        @user_receiver.friendships.create(friend_id: @user_sender.user_id, pending: true)

        # Set flag to true because the invitation is sent.
        invitation_sent = true; 

      #If friend is not register in app, then we will be send and invitation through email.
      elsif friendship.has_key?("email")
        logger.debug "EMAIL INVITATION to email: #{friendship['email']}"

        # Creating an invitation.
        @user_sender.external_invitations.create(receiver: friendship["email"], date: Time.now)

        # Set flag to true because the invitation is sent.
        invitation_sent = true;
      else
        invitation_sent = false;    
      end
    end
    #
    if invitation_sent
      return render :json => {"Message" => "Invitations sent"}
    end

    return render :json => {"Message" => "Some invitations cannot be processed"}  

  end

  # PUT /users/:user_id/friendships.json
  # Accepts the given user as your friend.
  def accept
    logger.debug "Incoming params #{params}"

    # Friend to accept
    @friend_user = User.find(params[:friendships][:friend_id])

    # Get frienship to check if is pending or not.
    @friendship = @user.friendships.where(friend_id: params[:friendships][:friend_id]).first

    # Get reverse relationship to update.
    @reverse_friendship = @friend_user.friendships.where(friend_id: @user.user_id).first

    logger.debug " Friend_user : #{@friend_user.user_id}, User: #{@user.user_id}, Reverse friendship: #{@reverse_friendship.pending}, Friendship: #{@friendship.pending}"
    if @friendship.pending
      respond_to do |format|
        logger.debug "PARAMS"
        logger.debug friendships_pending_params.class
        logger.debug @friendship.class

        # If friendship was pending, then we update pending and accept columns.
        if @friendship.update_attributes(accepted: true,pending: false) and @reverse_friendship.update_attributes(accepted: true,pending: false)
          format.html { render 'show' }
          format.json { render json: true}
        else
          format.html { render action: 'new' }
          format.json { render :json => {"error" => "Is not possible to update friendship table"}}
        end
      end
    else
      respond_to do |format|
        format.html { render action: 'new' }
        format.json { render :json => {"error" => "He/She friend is not a pending friend"}}
      end
    end
  end

  # GET /users/:user_id/pending_friends.json
  # Show all pending friends.
  def pending
    @friendships = @user.pending_friends
    logger.debug @friendships
    respond_to do |format|
      #format.html { render 'index' }
      format.json { render action: 'show_pending' }
    end
  end

  # 
  def omit
    current_user.friendships.where(friend_id: params[:friendships][:friend_id]).first.destroy
    User.find(params[:friendships][:friend_id]).destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { render json: true}
    end

  end

  # GET /users/:user_id/secret
  def secrets
    @friends = @user.secret_petitions
    respond_to do |format|
      format.html { render 'index' }
      format.json { render action:'index', location: @friends }
    end
  end

  def create_secret
    @user2 = User.find(params[:friendships][:friend_id])
    @friendship = @user2.friendships.where(friend_id: current_user.user_id).first
    respond_to do |format|
      if @friendship.update_columns(friendships_secret_params)
        format.html { render 'show' }
        format.json { render json: true}
      else
        format.html { render action: 'new' }
        format.json { render json: false}
      end
    end
  end

  def accept_secret
    @user2 = User.find(params[:friendships][:friend_id])
    @friendship = current_user.friendships.where(friend_id: params[:friendships][:friend_id]).first
    @friendship2 = @user2.friendships.where(friend_id: current_user.user_id).first

    respond_to do |format|
      if @friendship.update_columns(friendships_reset_secret_params) and @friendship2.update_columns(friendships_accept_secret_params)
        format.html { render 'show' }
        format.json { render json: true}
      else
        format.html { render action: 'new' }
        format.json { render json: false}
      end
    end

  end

  def omit_secret
    @friendship = current_user.friendships.where(friend_id: params[:friendships][:friend_id]).first
    respond_to do |format|
      if @friendship.update_columns(friendships_reset_secret_params)
        format.html { render 'show' }
        format.json { render json: true}
      else
        format.html { render action: 'new' }
        format.json { render json: false}
      end
    end
  end

  def show_lovers
    @user = User.find(params[:user_id])
    @friendship = Friendship.find(params[:friendship_id])
    @lovers = Lover.where(user_id: params[:friendship_id])
    respond_to do |format|
      format.html {render action: 'show_lovers'}
      format.json {render action: 'show_lovers'}
    end
  end

  def show_lover
    @user = User.find(params[:user_id])
    @friendship = Friendship.find(params[:friendship_id])
    @lover = Lover.find_by_lover_id(params[:lover_id])
    respond_to do |format|
      format.html {render action: 'show_lover'}
      format.json {render action: 'show_lover'}
    end
  end

  private

    # Set current user.
    def set_user
      @user = User.find(params[:user_id])
    end

    # Set current friend.
    def set_friend
      @friend = User.find(params[:friend_id])
    end

    def friendships_params
      params.require("friendships").permit(:friend_id, :email, :user_id)
    end

    def reverse_friendships_params
      @temp_id = params[:friend][:friend_id]
      params[:friendships].delete :friend_id
      params[:friendships].merge(friend_id: current_user.user_id)
      params.require("friendships").permit(:friend_id)
    end

    def friendships_pending_params
      params.require("friendships").permit(:friend_id,:accepted)
    end

    def reverse_friendships_pending_params
      params[:friendships][:friend_id] = @user.user_id
      params[:friendships].delete :pending
      params[:friendships].merge(pending: true)
      params.require("friendships").permit(:friend_id, :accepted, :pending)
    end

    def friendships_secret_params
      params[:friendships][:friend_id] = current_user.user_id
      params.require("friendships").permit(:friend_id,:secret_lover_ask)
    end

    def friendships_accept_secret_params
      params[:friendships][:friend_id] = current_user.user_id
      params.require("friendships").permit(:friend_id,:secret_lover_accepted)
    end

    def friendships_reset_secret_params
      params.require("friendships").permit(:friend_id,:secret_lover_ask)
    end

end
