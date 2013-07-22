########################################################################
## Controller that manages all REST methods related with User Friends ##
########################################################################
class FriendshipsController < ApplicationController

  # Token authentication
  before_action :set_user, :authenticate
  before_action :set_friend, only: [:show, :update, :destroy, :lovers, :lover]

  # All querys will be answered in a JSON format
  respond_to :json

  api :GET, '/users/:user_id/friendships.json',  'Show all friends of the current user'
  param :user_id, :number
  def index
    @friendships = @user.friends
    @users = []
    @friendships.each do |friend|
      @users.push(User.find(friend.friend_id))
    end
    return render action:'index'
  end

  # GET /users/:user_id/friendships/:friend_id.json
  #
  # Show all info of a given friend.
  def show
    @friendships = Friendship.find_by(friend_id: params[:friend_id], user_id: params[:user_id])
    @public_lovers = @friend.public_lovers

    # Checking permissions for showing secret lovers.
    @secret_lovers = []
    if secret_friendship
      @secret_lovers = @friend.secret_lovers
    end

    # User messages
    @messages = @friend.messages

    # If this user doesn't have any friends with this friendship_id, then we throw an error.
    if !@friendships.nil?
      return render action:'show'
    else
      return  render json: {exception: "FriendshipError", message: "This friendship doesn't belong to the given user"}, status: 422
    end
  end


  # POST /users/:user_id/friendships.json
  #
  # Send a request to the given user to be his/her friend.
  def create

    # Sender user
    @user_sender= User.find(params[:user_id])

    # Store array values to iterate.
    friends_id  = params[:friends_id]
    emails  = params[:emails]

    # Rending a request for each user.
    if !friends_id.empty?
      friends_id.each do |id|
        begin
          @user_receiver = User.find(id)
          @user_sender.invite_friend!(@user_receiver)
        rescue => e
          return render json: {exception: e.inspect, message: e.message}
        end
      end
    end

    # Sending a request for each email.
    if !emails.empty?
      emails.each do |email|
        begin
          # Sending email request.
          @user_sender.invite_email_friend!(email)
        rescue
          return render json: {exception: e.inspect, message: e.message}
        end
      end
    end

    # Throwing error only if there aren't any user id or email
    return render json: {exception: "FriendshipError", message: "No friends to invite"}, status: 422 unless friends.empty? and emails.empty?
    return render json: {message: "Invitations sent"}, status: 201

  end

  # PUT /users/:user_id/friendships.json
  #
  # Accepts the given user as your friend.
  def accept
    # Friend to accept
    @friend_user = User.find(params[:friendships][:friend_id])

    # Get frienship to check if is pending or not.
    @friendship = @user.friendships.where(friend_id: params[:friendships][:friend_id]).first

    # Get reverse relationship to update.
    @reverse_friendship = @friend_user.friendships.where(friend_id: @user.user_id).first

    #Throwing error if friendship doesn't exist
    if @friendship.nil? or @reverse_friendship.nil?
      return render json: {exception: "FriendshipError", message: "Unexisting friendship"}
    end

    # Only can accept pending friends.
    if @friendship.pending
        # If friendship was pending, then we update pending and accept columns.
        begin
          @user.accept_friend!(@friend_user)
        rescue => e
          return render json: {exception: e.inspect, message: e.message}
        end
    else
      return render json: {exception: "FriendshipError", message: "He/She friend is not a pending friend"}
    end
    return render json: {message: "Invitation accepted"}
  end

  # GET /users/:user_id/pending_friends.json
  #
  # Show all pending friends.
  def pending
    @friendships = @user.pending_friends
    logger.debug @friendships
    return render action: 'show_pending'
  end

  # DELETE /users/:user_id/frienships.json
  #
  # Omit friendship.
  def omit
    begin
      @user2 = User.find(params[:friendships][:friend_id])
      @user.omit_friend!(@user2)
    rescue => e
      return render json: {exception: "UnomittedFriend", message: "Impossible to omit friend with id: #{@user2.user_id}"}
    end
    return render json: {message:"Request omitted"}
  end

  # GET /users/:user_id/friendships_secret.json
  #
  # Show friends that accepts to show his/her secret lovers.
  def secrets
    @friendships = @user.secret_petitions

    return render action:'show_pending'
  end

  # POST /users/:user_id/friendships_secret.json
  #
  # Send an invitation to see his/her friend secret lovers.
  def create_secret
    @user2 = User.find(params[:friendships][:friend_id])
    # Checking that friendship exists to send a request.
    @friendship = @user2.friendships.where(friend_id: @user.user_id).first
    if !@friendship.nil? and @friendship.accepted?
        @user.invite_secret_friend!(@user2)
        return render json: {message: "Sending invitation to see his/her friend"}
    end
    return render json: {exception:"FriendshipError", message: "Not accepted friend"}
  end

  # PUT /users/:user_id/friendships_secret/accept.json
  #
  # Accept to see secret lovers.
  def accept_secret
    @user2 = User.find(params[:friendships][:friend_id])
    begin
      @user.accept_secret_friend!(@user2)
    rescue
      return render json: {exception: "FrienshipError", message:"Now your friend #{@user2.name} can not see your secret lovers"}, status: 422
    end
      return  render json: {message:"Now your friend #{@user2.name} can see your secret lovers"}
  end

  # PUT /users/:user_id/friendships_secret/omit.json
  #
  # Not to show secret lovers
  def omit_secret
    @user2 = User.find(params[:friendships][:friend_id])
    @friendship = @user2.friendships.where(friend_id: @user.user_id).first

    if @friendship.update_attributes(secret_lover_accepted: false)
      return render json: {message: "Omitted secret friend with id #{@user2.user_id}"}
    else
      return render json: {exception: "FriendshipError", message: "Impossible to omit secret friend"}
    end
  end

  # GET /users/:user_id/friendships/:friend_id/lovers.json
  #
  # Method to see your friend lovers.
  def lovers
    @public_lovers = @friend.public_lovers
    @friendship = Friendship.where(user_id: @user.user_id, friend_id: @friend.user_id).first
    @secret_lovers = []
    if secret_friendship
      @secret_lovers = @friend.secret_lovers
    end
      return render action: 'show_lovers'
  end

  # GET /users/:user_id/friendships/:friend_id/lovers/:lover_id.json
  def lover
    @lover = Lover.find_by_lover_id(params[:lover_id])
    @lover_rel = @user.user_lovers.where(lover_id: params[:lover_id]).first

    # Check if it is a secret lover and user doesn't have friend permission to see his/her secret lovers.
    return render json: {error: "FriendshipError", message: "Is not possible to show a secret lover without friend permissions"} if !secret_friendship and @lover_rel.visibility==0

    @experiences = @lover.experiences
    return render action: 'show_lover'
  end

  # GET /users/:user_id/friendships/:friend_id/lovers/:lover_id/experiences/:experience_id.json
  def lover_experience
    begin
      @lover_rel  = @user.user_lovers.where(lover_id: params[:lover_id]).first
      @experience = Experience.find(params[:experience_id]) unless @lover_rel.visibility == 0 and !secret_friendship
    rescue => e
      return render json: {exception: e.inspect, message: e.message}
    end
    return render action: 'show_lover_experience'
  end

  private

    # Set current user.
    def set_user
      begin
        @user = User.find(params[:user_id])
      rescue
        return render json: {errors: "This user doesn't exist"}, status: 422
      end
    end

    # Set current friend.
    def set_friend
      begin
        @friend = User.find(params[:friend_id])
      rescue
        return render json: {errors: "This friend doesn't exist"}, status: 422
      end
    end

    # Checks if a user is allowed to see secret lovers from any friend
    def secret_friendship
      @friendship = Friendship.where(user_id: @user.user_id, friend_id: params[:friend_id]).first
      @friendship.secret_lover_accepted
    end

    def friendships_params
      params.permit(:friend_id, :email, :user_id)
    end

end
