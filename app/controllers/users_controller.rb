class UsersController < ApplicationController
  #skip_before_filter  :verify_authenticity_token
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  #before_filter :signed_in_user, only: [:index, :show, :edit, :update, :destroy, :friends, :pendingfriends]
  #before_filter :correct_user,   only: [:edit, :update, :pendingfriends]
  #before_filter :admin_user,     only: :destroy
  protect_from_forgery :except => :show  

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @friendship = Friendship.find_by_user_id(params[:id])
    if current_user?(@user)
      @lovers = @user.lovers
    elsif @friendship
      if @friendship.secret_lover_accepted
        @lovers_secret = @user.lovers.secret
      end
      @lovers = @user.lovers.visible
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        sign_in @user
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'edit' }
        format.json { head :no_content  }
      end
    end
  end

  # POST /users/1
  # POST /users/1.json
  # It must be a post method to get user_id params.
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { render :json => {:message=>'User removed correctly'} }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(:name, :email,  :facebook_id, :password, :password_confirmation,  :birthday, :startday, :eye_color, :hair_color, :height,:main_photo_url, :photo_num, :sex_interest, :sex_gender, {preferences: []}, :hairdressing, :job)
    end

    def geo_params
      params.require(:geosex).permit(:access, :state, :lat, :lng)
    end



    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
