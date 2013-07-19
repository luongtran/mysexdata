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

  # GET /users/:user_id/sex_affinity/:user2_id
  def sex_affinity
    @user2 = User.find(params[:user2_id])
    @affinity = calculate_sex_affinity(@user, @user2)
    logger.debug @affinity
    render action: 'show_sex_affinity'
  end

  def calculate_sex_affinity(user, user2)

    # Calculating each value.
    i = calculate_interest(user,user2)
    h = calculate_height(user,user2)
    hd = calculate_hairdressing(user,user2)
    p = calculate_preferences(user,user2)

    logger.debug "Results i: #{i} , h: #{h}, hd: #{hd}, pref: #{p}"
      
    return sa= 100 * i*(0.22*p[0] + 0.19*p[1] + 0.17*p[2] + 0.14*p[3] + 0.11*p[4] + 0.08*p[5] + 0.06*h + 0.03*hd)
  end

  def calculate_interest(user,user2)
    i = 0
    i = 1 if (user.sex_interest == user2.sex_gender or user.sex_interest == 3)
  end

  def calculate_height(user,user2)
    h = 0
    h = 1 if ((user.sex_gender == 0 and user.height == user2.height) or (user.sex_gender == 1 and (user2.height == user.height + 1)) or (user.height == 3 and user2.height == 3))
    h = 0.5 if ((user.sex_gender == 1 and (user.height == user2.height and user.height < 3 and user2.height < 3)) or (user.sex_gender == 1 and (1..2).include?(user.height) and(1..2).include?(user2.height))   or (user.height == 3 and user.height == 2))

    return h
  end

  def calculate_hairdressing(user,user2)
    hd = 0
    hd = 1 unless (user.hairdressing == 1 and user1.hairdressing != user2.hairdressing)
  end

  def calculate_preferences(user,user2)
    # Default values
    g1 = 0
    g2 = 0
    g3 = 0
    g4 = 0
    g5 = 0
    g6 = 0

    g1 = 1 if user.preferences[0] == user2.preferences[0]
    g2 = 1 if user.preferences[1] == user2.preferences[1]
    g3 = 1 if user.preferences[2] == user2.preferences[2]
    g4 = 1 if user.preferences[3] == user2.preferences[3]
    g5 = 1 if user.preferences[4] == user2.preferences[4]
    g6 = 1 if user.preferences[5] == user2.preferences[5]

    return preferences = [g1,g2,g3,g4,g5,g6]
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
