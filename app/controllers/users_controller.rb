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
    logger.debug params
    @public_lovers = @user.lovers.where(visibility: 0)
    @secret_lovers = @user.lovers.where(visibility: 1)
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
    #Check that user can't modify user_ids
    if !params[:user_id].nil?
      return render :json => {:error => 'Id is not possible to be modified'}
    end
    
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
      
      # Not working!
      if @user.nil?
        render :json => {:error=> 'User with user_id #{params[:id] doesn\'t exist}'}
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(:name, :email, :facebook_id, :status, :password, :password_confirmation,  :age, :startday, :eye_color, :hair_color, :height,:main_photo_url, :photo_num, :sex_interest, :sex_gender, {preferences: []}, :hairdressing, :job)
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
