#################################################################
## Controller that manages all REST methods related with Users ##
#################################################################
class UsersController < ApplicationController

  # Token authentication
  before_action :set_user, except: [ :index, :create ]
  before_action :authenticate, except: [ :index, :create ]

  protect_from_forgery :except => [:index,:create]

  respond_to :json

  def_param_group :user do
    param :name, String, 'Name of the user', required: true
    param :email, String, 'Email of the user', required: true
    param :facebook_id, String, 'Facebook id of the user facebook profile', required: true
    param :password, String, 'User password', required: true
    param :password_confirmation, String, 'Password to match introduced password', required: true
    param :status, [0,1,2,3], 'User love status', required: true
    param :main_photo_url, String, 'Profile user photo', required: true
    param :photo_num,[0,1,2,3], 'Number of photos to upload', required: true
    param :job, [0,1,2,3], 'User job', required: true
    param :age, Integer, 'User age', required: true
    param :startday, String, 'Date of the first relationship', required: true
    param :eye_color, [0,1,2,3], 'User eyes color', required: true
    param :hair_color, [0,1,2,3], 'User hair color', required: true
    param :height, [0,1], 'User hair color', required: true
    param :hairdressing, [0,1], 'User hairdressing', required: true
    param :sex_interest, [0,1,2], 'Sex in which user is interested in. (0: Woman, 1: Man, 2: Both)', required: true
    param :sex_gender, [0,1], 'User gender (0: Female, 1: Male)', required: true
    param :preferences,Array, 'Array of size 6. This must contain 1 to 6 numbers sorted by user preferences. Example: [2,5,3,1,6,4] or [6,4,2,4,3,1]', required: true
  end




  # Verifying user before the given methods with some filters.
  #before_filter :signed_in_user, only: [:index, :show, :edit, :update, :destroy, :friends, :pendingfriends]
  #before_filter :admin_user,     only: :destroy


  api :GET, '/users', 'Show user profile'
  param_group :user
  description "{
      'user_id': 1,
      'name': 'Example User'
      ‘email’: ‘example@railstutorial6.org’,
      ‘password’: ‘1234’,
      ‘password_confirmation’: ‘1234’,
      ‘facebook_id’: ‘26’,
      ‘status’: 0
      ‘main_photo_url’:’http://url.jpg’,
      ‘photo_num’: 0,
      ‘job’: 0,
      ‘age’: 25,
      ‘startday’: ‘11/11/1111’,
      ‘eye_color’: 0,
      ‘hair_color’: 0,
      ‘height’: 0,
      ‘hairdressing’: 0,
      ‘sex_interest’: 0,
      ‘sex_gender’: 0,
      ‘preferences’: [1, 2, 3, 4, 5, 6]
  }"
  def index
    @users = User.all
  end

  api :GET, '/users/:user_id', 'Show user profile'
  description "{
      'user_id': 1,
      'name': 'Example User'
      ‘email’: ‘example@railstutorial6.org’,
      ‘password’: ‘1234’,
      ‘password_confirmation’: ‘1234’,
      ‘facebook_id’: ‘26’,
      ‘status’: 0
      ‘main_photo_url’:’http://url.jpg’,
      ‘photo_num’: 0,
      ‘job’: 0,
      ‘age’: 25,
      ‘startday’: ‘11/11/1111’,
      ‘eye_color’: 0,
      ‘hair_color’: 0,
      ‘height’: 0,
      ‘hairdressing’: 0,
      ‘sex_interest’: 0,
      ‘sex_gender’: 0,
      ‘preferences’: [1, 2, 3, 4, 5, 6]
  }"
  def show
    @public_lovers = @user.public_lovers
    @secret_lovers = @user.secret_lovers
  end


  # POST /users
  # POST /users.json
  api :POST, '/users','Create a user'
  param :user_id, Integer
  formats ['json']
  param_group :user
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
