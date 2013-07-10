class FriendshipsController < ApplicationController
   skip_before_filter  :verify_authenticity_token
   before_filter :signed_in_user, only: [:index, :create, :pending, :accept, :omit, :secrets]

  # GET /users/:user_id/friendships
  # GET /users/:user_id/friendships.json 
  def index   
    @user = User.find(params[:user_id])
    @friendships = Friendship.find_all_by_user_id(params[:user_id])
    respond_to do |format|
      format.html { render 'index' }
      format.json { render action:'index', location: @friends }
    end
  end

  # GET /users/:user_id/friendships/:friendship_id
  # GET /users/:user_id/friendships/:friendship_id.json
  def show    
    @friendships = Friendship.find_by(friend_id: params[:friendship_id], user_id: params[:user_id])        

    # If this user doesn't have any friends with this friendship_id, then we throw an errror.
    if !@friendships.nil?
      respond_to do |format|
        format.html { render 'show' }
        format.json { render action:'show', location: @friendships }
      end
    else
      respond_to do |format|
        format.html { render 'show' }
        format.json { render :json => {:Error => "This friendship doesn't belong to the given user"}, status: :unprocessable_entity }
      end

    end
  end

  def create
    @user = current_user
    @user2 = User.find(params[:friendships][:friend_id])
    @friendship1 = @user.friendships.build(friend_id: @user2.id)
    @friendship2 = @user2.friendships.build(friend_id: @user.id, pending: true)
    respond_to do |format|
      if @friendship1.save and @friendship2.save
        format.html { redirect_to @friendship1, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @friendship1 }
      else
        format.html { render action: 'new' }
        format.json { render json: @friendship1.errors.full_messages, status: :unprocessable_entity }
      end
    end
  else

  end

  # POST /users/:user_id/friendships
  # POST /users/:user_id/friendships.json

  # We receive a JSON with all users that the given user wants to invite to be his/her friends.
  # This method creates two friends in friendships table, with the accepted column to false. 
  # Also, we will set the pending flag to all requested friends to true. When, friends accept the 
  # invitation, then accepted flag of the given user will set to true.
  def invite
    logger.debug "PARAMETERS"
    logger.debug params
    @invitation_sender_user= User.find(params[:user_id])

    JSON.parse(params[:friendships]).each do |friendship|
      Rails.logger.info friendship['friendship_id']
    end  
    #@invited_users  = 

  end

  def accept
    @user = User.find(params[:friendships][:friend_id])
    @friendship = current_user.friendships.where(friend_id: params[:friendships][:friend_id]).first
    @reverse_friendship = @user.friendships.where(friend_id: current_user.id).first
    if @friendship.pending
      respond_to do |format|
        if @friendship.update_columns(friendships_pending_params) and @reverse_friendship.update_columns(reverse_friendships_pending_params)
          format.html { render 'show' }
          format.json { render json: true}
        else
          format.html { render action: 'new' }
          format.json { render json: false}
        end
      end
    else
      respond_to do |format|
        format.html { render action: 'new' }
        format.json { render json: false}
      end
    end
  end

  def pending
    @friends = current_user.pending_friends
    respond_to do |format|
      format.html { render 'index' }
      format.json { render action:'index', location: @friends }
    end
  end

  def omit
    current_user.friendships.where(friend_id: params[:friendships][:friend_id]).first.destroy
    User.find(params[:friendships][:friend_id]).destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { render json: true}
    end

  end

  def secrets
    @friends = current_user.secret_petitions
    respond_to do |format|
      format.html { render 'index' }
      format.json { render action:'index', location: @friends }
    end
  end

  def create_secret
    @user2 = User.find(params[:friendships][:friend_id])
    @friendship = @user2.friendships.where(friend_id: current_user.id).first
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
    @friendship2 = @user2.friendships.where(friend_id: current_user.id).first

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

  private

    def friendships_params
      params.require("friendships").permit(:friend_id)
    end

    def reverse_friendships_params
      @temp_id = params[:friend][:friend_id]
      params[:friendships].delete :friend_id
      params[:friendships].merge(friend_id: current_user.id)
      params.require("friendships").permit(:friend_id)
    end

    def friendships_pending_params
      params.require("friendships").permit(:friend_id,:accepted)
    end

    def reverse_friendships_pending_params
      params[:friendships][:friend_id] = current_user.id
      params[:friendships].delete :pending
      params[:friendships].merge(pending: true)
      params.require("friendships").permit(:friend_id, :accepted, :pending)
    end

    def friendships_secret_params
      params[:friendships][:friend_id] = current_user.id
      params.require("friendships").permit(:friend_id,:secret_lover_ask)
    end

    def friendships_accept_secret_params
      params[:friendships][:friend_id] = current_user.id
      params.require("friendships").permit(:friend_id,:secret_lover_accepted)
    end

    def friendships_reset_secret_params
      params.require("friendships").permit(:friend_id,:secret_lover_ask)
    end

end
