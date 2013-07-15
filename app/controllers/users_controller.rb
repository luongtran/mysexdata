#################################################################
## Controller that manages all REST methods related with Users ##
#################################################################
class UsersController < ApplicationController

  # Token authentication
  #skip_before_filter  :verify_authenticity_token
  
  # Set user before the given methods.
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # Verifying user before the given methods with some filters.
  #before_filter :signed_in_user, only: [:index, :show, :edit, :update, :destroy, :friends, :pendingfriends]
  #before_filter :correct_user,   only: [:edit, :update, :pendingfriends]
  #before_filter :admin_user,     only: :destroy

  # Methods that don't need authentication
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

  # PUT /users/1
  # PUT /users/1.json
  def update
    #Checking that user_id can't be modified
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

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { render :json => {:message=>'User removed correctly'} }
    end
  end


  private
    # Define current user.
    def set_user
      @user = User.find(params[:id])
      
      # Not working!
      #if @user.nil?
      #  render :json => {:error=> 'User with user_id #{params[:id] doesn\'t exist}'}
      #end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(:name, :email, :facebook_id, :status, :password, :password_confirmation,  :age, :startday, :eye_color, :hair_color, :height,:main_photo_url, :photo_num, :sex_interest, :sex_gender, {preferences: []}, :hairdressing, :job)
    end

    def geo_params
      params.require(:geosex).permit(:access, :state, :lat, :lng)
    end

    def admin_user
      redirect_to(root_path) unless @user.admin?
    end
end
