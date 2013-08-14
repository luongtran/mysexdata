#################################################
## Controller that manages all REST methods related with Users ##
#################################################
class UsersController < ApplicationController

  # Token authentication
  before_action :set_user, except: [:index, :create]
  before_action :authenticate, except: [:index, :create]
  before_action :authenticate_guest, only: [:index, :create]

  respond_to :json

  # Definition of api doc params #

  # User params that are required
  def_param_group :user_param do
    param :name, String, 'Name of the user', required: true
    param :email, String, 'Email of the user', required: true
    param :facebook_id, String, 'Facebook id of the user facebook profile', required: true
    param :password, String, 'User password', required: true
    param :status, [0,1 ,2 ,3], 'User love status', required: true
    param :main_photo_url, String, 'Profile user photo', required: true
    param :photo_num,[1 ,2 ,3, 4], 'Number of photos to upload (Integer)', required: false
    param :job, [0 ,1 ,2 ,3], 'User job (Integer)', required: true
    param :age, Integer, 'User age', required: true
    param :birthday, String, 'Date of the birthday with the next format: dd/mm/yyyy', required: true
    param :startday, String, 'Date of the first relationship with the next format: dd/mm/yyyy', required: true
    param :eye_color, [0 ,1 ,2 ,3], 'User eyes color (Integer)', required: true
    param :hair_color, [0 ,1 ,2 ,3], 'User hair color (Integer) ', required: true
    param :height, [0 ,1], 'User hair color (Integer)', required: true
    param :hairdressing, [0 ,1], 'User hairdressing (Integer)', required: true
    param :sex_interest, [0,1 ,2], 'Sex in which user is interested in. (0: Woman, 1: Man, 2: Both) (Integer)', required: true
    param :sex_gender, [0 ,1], 'User gender (0: Female, 1: Male) (Integer)', required: true
    param :preferences,Array, 'Array of size 6. This must contain 1 to 6 integers sorted by user preferences. Example: [2,5,3,1,6,4] or [6,4,2,4,3,1]', required: true
  end

  # Optional user params used to update users.
  def_param_group :user_opt_param do
    param :name, String, 'Name of the user', required: false
    param :email, String, 'Email of the user', required: false
    param :facebook_id, String, 'Facebook id of the user facebook profile', required: false
    param :password, String, 'User password', required: false
    param :status, [0 ,1 ,2 ,3], 'User love status', required: false
    param :main_photo_url, String, 'Profile user photo', required: false
    param :photo_num,[0 ,1 ,2 ,3], 'Number of photos to upload (Integer)', required: false
    param :job, [0 ,1 ,2 ,3], 'User job (Integer)', required: false
    param :age, Integer, 'User age', required: false
    param :birthday, String, 'Date of the birthday with the next format: dd/mm/yyyy', required: false
    param :startday, String, 'Date of the first relationship with the next format: dd/mm/yyyy ', required: false
    param :eye_color, [0 ,1 ,2 ,3], 'User eyes color (Integer)', required: false
    param :hair_color, [0 ,1 ,2 ,3], 'User hair color (Integer)', required: false
    param :height, [0 ,1], 'User hair color (Integer)', required: false
    param :hairdressing, [0 ,1], 'User hairdressing (Integer)', required: false
    param :sex_interest, [0 ,1 ,2], 'Sex in which user is interested in. (0: Woman, 1: Man, 2: Both) (Integer)', required: false
    param :sex_gender, [0 ,1], 'User gender (0: Female, 1: Male) (Integer)', required: false
    param :preferences,Array, 'Array of size 6. This must contain 1 to 6 integers sorted by user preferences. Example: [2,5,3,1,6,4] or [6,4,2,4,3,1]', required: false
  end

  api :GET, '/users', 'Show all users'
  example "
  [{
    ‘user_id’: 1,
    ‘name’: ’Example User’,
    ‘email’: ‘example@railstutorial6.org’,
    ‘facebook_id’: ‘26’,
    ‘status’: 0,
    ‘main_photo_url’:’http://url.jpg’,
    ‘photo_num’: 0,
    ‘photo_num’: 1,
    ‘job’: 0,
    ‘age’: 25,
    ‘birthday: ‘11/11/1111’,
    ‘startday’: ‘11/11/1111’,
    ‘eye_color’: 0,
    ‘hair_color’: 0,
    ‘height’: 0,
    ‘hairdressing’: 0,
    ‘sex_interest’: 0,
    ‘sex_gender’: 0,
    ‘preferences’: [1, 2, 3, 4, 5, 6]
  },{
    'user_id': 2,
    'name': 'Example User2',
    ‘email’: ‘example@railstutorial2.org’,
    ‘facebook_id’: ‘26’,
    ‘status’: 0,
    ‘main_photo_url’:’http://url.jpg’,
    ‘photo_num’: 0,
    ‘photo_num’: 1,
    ‘job’: 0,
    ‘age’: 25,
    ‘birthday: ‘11/11/1111’,
    ‘startday’: ‘11/11/1111’,
    ‘eye_color’: 0,
    ‘hair_color’: 0,
    ‘height’: 0,
    ‘hairdressing’: 0,
    ‘sex_interest’: 0,
    ‘sex_gender’: 0,
    ‘preferences’: [1, 2, 3, 4, 5, 6]
  }]"
  def index
    @users = User.all
  end

  api :GET, '/users/:user_id', 'Show user profile'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  Response:
    {
      'user_id': 1,
      'name': 'Example User',
      ‘email’: ‘example@railstutorial6.org’,
      ‘password’: ‘1234’,
      ‘facebook_id’: ‘26’,
      ‘status’: 0,
      ‘main_photo_url’:’http://url.jpg’,
      ‘photo_num’: 0,
      ‘photo_num’: 1,
      ‘job’: 0,
      ‘age’: 25,
      ‘birthday: ‘11/11/1111’,
      ‘startday’: ‘11/11/1111’,
      ‘eye_color’: 0,
      ‘hair_color’: 0,
      ‘height’: 0,
      ‘hairdressing’: 0,
      ‘sex_interest’: 0,
      ‘sex_gender’: 0,
      ‘preferences’: [1, 2, 3, 4, 5, 6],
      'lovers': {
        'public': [
          {
            'lover_id': 3,
            'name': 'Kaci Adams DDS',
            'photo_url': 'http://Kaci Adams DDS.jpg'
            },
            {
              'lover_id': 7,
              'name': 'Judd Klein',
              'photo_url': 'http://Judd Klein.jpg'
            }
            ],
            'secret': [
              {
                'lover_id': 4,
                'name': 'Wilhelmine Gislason Sr.',
                'photo_url': 'http://Wilhelmine Gislason Sr..jpg'
              }
            ]
          }
    }"
  def show
  @public_lovers = @user.public_lovers
  @secret_lovers = @user.secret_lovers
  end


  api :POST, '/users','Create a user'
  formats ['json']
  description "
  <b>Headers</b>

  Content-type: application/json"
  param_group :user_param
  example "
  Request body:
  {
    'name': 'Example User',
    ‘email’: ‘example@railstutorial6.org’,
    ‘password’: ‘1234’,
    ‘facebook_id’: ‘26’,
    ‘status’: 0,
    ‘main_photo_url’:’http://url.jpg’,
    ‘photo_num’: 0,
    ‘photo_num’: 1,
    ‘job’: 0,
    ‘age’: 25,
    ‘birthday: ‘11/11/1111’,
    ‘startday’: ‘11/11/1111’,
    ‘eye_color’: 0,
    ‘hair_color’: 0,
    ‘height’: 0,
    ‘hairdressing’: 0,
    ‘sex_interest’: 0,
    ‘sex_gender’: 0,
    ‘preferences’: [1, 2, 3, 4, 5, 6]
  }

  Response:
  {
    'user_id': 1,
    'name': 'Example User',
    ‘email’: ‘example@railstutorial6.org’,
    ‘password’: ‘1234’,
    ‘facebook_id’: ‘26’,
    ‘status’: 0,
    ‘main_photo_url’:’http://url.jpg’,
    ‘photo_num’: 0,
    ‘photo_num’: 1,
    ‘job’: 0,
    ‘age’: 25,
    ‘birthday: ‘11/11/1111’,
    ‘startday’: ‘11/11/1111’,
    ‘eye_color’: 0,
    ‘hair_color’: 0,
    ‘height’: 0,
    ‘hairdressing’: 0,
    ‘sex_interest’: 0,
    ‘sex_gender’: 0,
    ‘preferences’: [1, 2, 3, 4, 5, 6],
    'remember_token': 'adfdfasafag213asd'
    }
  }"
  def create
    @user = User.new(user_params)
    friends_users = Array.new
    if @user.save
      # Retrieve users invitations by email and facebook_id
      friends_users = search_users_by_email_and_facebook_id(@user.email, @user.facebook_id);

      # Create pending friendship between the current user and users that sent requests.
      if create_friendships(friends_users)
        clear_external_invitations;
      end

      #TODO Add default photo


      return render action: 'show_with_token', status: :created
    else
      return render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  api :PUT, 'users/:user_id', 'Edit a user'
  formats ['json']
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  param_group :user_opt_param
  example "
  Request body:
  {
    'name':'Federico'
  }

  Response
  {
    'user_id': 1,
    'name': 'Federico',
    ‘email’: ‘example@railstutorial6.org’,
    ‘password’: ‘1234’,
    ‘facebook_id’: ‘26’,
    ‘status’: 0,
    ‘main_photo_url’:’http://url.jpg’,
    ‘photo_num’: 0,
    ‘photo_num’: 1,
    ‘job’: 0,
    ‘age’: 25,
    ‘birthday: ‘11/11/1111’,
    ‘startday’: ‘11/11/1111’,
    ‘eye_color’: 0,
    ‘hair_color’: 0,
    ‘height’: 0,
    ‘hairdressing’: 0,
    ‘sex_interest’: 0,
    ‘sex_gender’: 0,
    ‘preferences’: [1, 2, 3, 4, 5, 6]
  }"
  def update
    @public_lovers = @user.public_lovers
    @secret_lovers = @user.secret_lovers
    if @user.update(user_params)
      return render action: 'show'
    else
      return render json: {exception: "UserException", message: "User '#{@user.user_id}' cannot be updated, #{@user.errors.full_messages}."}
    end
  end

  api :DELETE, 'users/:user_id', 'Delete a user'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  {
     'info':'User :user_id was successfully remove'
  }"
  def destroy
    id = @user.user_id
    @user.destroy
    return  render json: {info:"User #{@user.id} was successfully remove"}
  end

  api :GET, '/users/:user_id/sex_affinity/:user2_id', 'Calculate sex affinity percentage of two users'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  Response:
  {
    'user_id': 1,
    'user2_id': 2,
    'sex_affinity': 95.6
  }"
  def sex_affinity
    @user2 = User.find(params[:user2_id])
    @affinity = calculate_sex_affinity(@user, @user2)
    render action: 'show_sex_affinity'
  end

  def report_abuse
    content = params[:content]
    if UserMailer.report_abuse(@user, content).deliver
      return render json: {info: "Abuse message sended"}
    else
      return render json: {exception:"UserException", message: "Abuse message cannot be sended"}
    end
  end

  private
      # Define current user.
      def set_user
        begin
          @user = User.find(params[:user_id])
        rescue
          return render json: {exception: "UserException", message: "This user doesn't exist"}, status: 412
        end
      end

      # List of parameters allowed in user requests.
      def user_params
        params.permit(:name, :email, :facebook_id, :status, :password, :password_confirmation, :age,:birthday, :startday, :eye_color, :hair_color, :height,:main_photo_url, :photo_num, :sex_interest, :sex_gender, {preferences: []}, :hairdressing, :job)
      end

      def admin_user
        redirect_to(root_path) unless @user.admin?
      end

      # Algorithm that calculates sex_affinity value between two users.
      def calculate_sex_affinity(user, user2)

        # Calculating each value.
        i = calculate_interest(user,user2)
        h = calculate_height(user,user2)
        hd = calculate_hairdressing(user,user2)
        p = calculate_preferences(user,user2)

        return sa = 100 * i *( 0.22*p[0] + 0.19*p[1] + 0.17*p[2] + 0.14*p[3] + 0.11*p[4] + 0.08*p[5] + 0.06*h + 0.03*hd )
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

      #Go to external invitations to retrieve users that sent requests to the current user.
      def search_users_by_email_and_facebook_id(email, facebook_id)
        users = Array.new
        email_requests = ExternalInvitation.where(receiver: email)
        facebook_requests = ExternalInvitation.where(facebook_id: facebook_id)
        email_requests.each do |req|
          if !users.include?(req.sender_id)
            users.push(req.sender_id)
          end
        end
        facebook_requests.each do |req|
          if !users.include?(req.sender_id)
            users.push(req.sender_id)
          end
        end
        return users
      end

      # Method to create a friendship.
      def create_friendships (friends_id)
        if friends_id.empty?
          return false
        end
        friends_id.each do |friend|
          user = User.where(id: friend).first
          if !user.nil?
            user.invite_friend!(@user)
          end
        end
        return true;
      end

      # Clear all invitations when a user is registered in application.
      def clear_external_invitations
        ExternalInvitation.where(receiver: @user.email).destroy_all
        ExternalInvitation.where(facebook_id: @user.facebook_id).destroy_all
      end
end
