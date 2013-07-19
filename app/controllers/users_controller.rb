#################################################################
## Controller that manages all REST methods related with Users ##
#################################################################
class UsersController < ApplicationController

  # Token authentication
  before_action :set_user, except: [ :index, :create ]
  before_action :authenticate, except: [ :index, :create ]

  protect_from_forgery :except => [:index,:create]
  

  # Verifying user before the given methods with some filters.
  #before_filter :signed_in_user, only: [:index, :show, :edit, :update, :destroy, :friends, :pendingfriends]
  #before_filter :correct_user,   only: [:edit, :update, :pendingfriends]
  #before_filter :admin_user,     only: :destroy


  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @public_lovers = @user.public_lovers
    @secret_lovers = @user.secret_lovers
  end


  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save 
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created}
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render action: 'show'}
      else
        format.html { render action: 'edit' }
        format.json { head :no_content  }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    id = @user.user_id
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { render :json => {:info=>'User #{id} removed successfully'} }
    end
  end


  private
    # Define current user.
    def set_user
      begin
        @user = User.find(params[:user_id])
      rescue
        return render json: {errors: "This user with id: #{params[:user_id]} doesn't exist"}, status: 412   
      end
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
