######################################################
## Controller that manages all REST methods related with User Friends ##
######################################################
class FriendshipsController < ApplicationController

  # Token authentication
  before_action :set_user, :authenticate
  before_action :set_friend, only: [:show, :update, :destroy, :lovers, :lover]

  # Definition of api doc params
  def_param_group :accept_params do
    param :friendships, Hash do
      param :friend_id, String, required: true
    end
  end

  def_param_group :facebook_params do
    param :friendships, Array do
      param :name, String, required: true
      param :facebook_id, String, required: true
      param :photo_url, String, required: true
    end


  end

  # All querys will be answered in a JSON format
  respond_to :json

  api :GET, '/users/:user_id/friendships.json',  'Show all friends of the given user'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  {
    'user_id': 1,
    'friendships': [
        {
            'user_id': '4',
            'name': 'Ida Fadel',
            'main_photo_url': 'http://url.jpg'
        },
        {
            'user_id': '5',
            'name': 'Zena Johns',
            'main_photo_url': 'http://url.jpg'
        }
  }"
  error code:400
  def index
    @friendships = @user.friends
    @users = []
    @friendships.each do |friend|
      @users.push(User.find(friend.user_id))
    end
    return render action:'index'
  end

  api :GET, '/users/:user_id/friendships/:friend_id','Show all info of the given user friend'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  {
    'user_id': 1,
    'friend': {
        'user_id': 4,
        'name': 'Ida Fadel',
        'lovers_num': 0,
        'sex_interest': 0,
        'age': 30,
        'startday': '1111-11-11T00:00:00.000Z',
        'eye_color': 0,
        'hair_color': 0,
        'height': 0,
        'hairdressing': 0,
        'preferences': [
            1,
            2,
            3,
            4,
            5,
            6
        ],
        'lovers': {
            'public': [
                {
                    'lover_id': 1,
                    'name': 'Xavier Olson',
                    'photo_url': 'http://Xavier Olson.jpg'
                },
                {
                    'lover_id': 3,
                    'name': 'Savanna Wolf Jr.',
                    'photo_url': 'http://Savanna Wolf Jr..jpg'
                },
                {
                    'lover_id': 5,
                    'name': 'Dr. Hilbert Haag',
                    'photo_url': 'http://Dr. Hilbert Haag.jpg'
                }
            ],
            'secret': []
        },
        'messages': []
    }
  }"
  error code: 400
  def show
    @friendships = Friendship.where(friend_id: params[:friend_id], user_id: params[:user_id]).first
    @public_lovers = @friend.public_lovers

    # Checking permissions for showing secret lovers.
    @secret_lovers = []
    @lovers_num = @friend.user_lovers.where(visibility: 1).count
    if secret_friendship
      @lovers_num = @friend.user_lovers.count
      @secret_lovers = @friend.secret_lovers
    end

    # User messages
    @messages = @friend.messages

    # If this user doesn't have any friends with this friendship_id, then we throw an error.
    if !@friendships.nil?
      return render action:'show'
    else
      return  render json: {exception: "FriendshipException", message: "This friendship doesn't belong to the given user"}, status: 400
    end
  end


  api :POST,'/users/:user_id/friendships', 'Send a request to the given user to be his/her friend'
  formats ['json']
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  param :friends_id, Array, required: true, allow_nil: true
  example "
  Request body:
  {
    'emails':['info@mysexdata.com','info2@mysexdata.com'']
  }

  Response:
  {
    'info': 'Invitations sent'
  }"
  error code:400
  def create

    # Sender user
    @user_sender= User.find(params[:user_id])

    # Store array values to iterate.
    friends_id  = params[:friends_id]

    # Rending a request for each user.
    if !friends_id.nil?
      friends_id.each do |id|
        begin
          @user_receiver = User.find(id)
          @user_sender.invite_friend!(@user_receiver)
        rescue => e
          return render json: {exception: "FriendshipException", message: e.message}
        end
      end
    end

    # Throwing error only if there aren't any user id or email
    return render json: {exception: "FriendshipException", message: "No friends to invite"}, status: 400 if friends_id.nil?
    return render json: {info: "Invitations sent"}, status: 201

  end

  api :POST,'/users/:user_id/friendships_mail', 'Send a request to the given user to be his/her friend via email'
  formats ['json']
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  param :emails, Array, required: true, allow_nil: true
  example "
  Request body:
  {
    'emails':['info@mysexdata.com']
  }

  Response:
  {
    'info': 'Invitations sent'
  }"
  error code: 400
  def create_mail

    # Sender user
    @user_sender= User.find(params[:user_id])

    # Store array values to iterate.
    emails  = params[:emails]

    # Sending a request for each email.
    if !emails.nil?
      emails.each do |email|
        begin
          # Sending email request.
          @user_sender.invite_email_friend!(@user, email)
        rescue => e
          return render json: {exception: e.inspect, message: e.message}
        end
      end
    end

    # Throwing error only if there aren't any user id or email
    return render json: {exception: "FriendshipException", message: "No friends to invite"}, status: 400 if emails.nil?
    return render json: {info: "Invitations sent"}, status: 201

  end

  api :POST,'/users/:user_id/friendships_facebook', 'Send a request to the given user to be his/her friend via facebook'
  formats ['json']
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  param_group :facebook_params
  example "
  Request body:
  {

    'friendships':[
      {
        'email':'pedro@gmail.com',
        'name':'Pedro',
        'facebook_id':'ee11241rd',
        'photo_url':'http://masd.com'
      },
      {
        'email':'cristiann@gmail.com',
        'name':'Cristian',
        'facebook_id':'211241rd',
        'photo_url':'http://masd.com'
      }
    ]
  }

  Response:
  {
    'info': 'Invitations sent'
  }"
  error code: 400
  def create_facebook

    # Sender user
    @user_sender= User.find(params[:user_id])

    # Store array values to iterate.
    facebooks  = params[:friendships]

    # Sending a request for each email.
    if !facebooks.nil?
      facebooks.each do |fc|
        begin
          @user_sender.invite_facebook_friend!(@user, fc)
        rescue => e
          return render json: {exception: e.inspect, message: e.message}
        end
      end
    end

    # Throwing error only if there aren't any user id or email
    return render json: {exception: "FriendshipException", message: "No friends to invite"}, status: 400 if facebooks.nil?
    return render json: {info: "Invitations sent"}, status: 201

  end


  api :PUT, '/users/:user_id/friendships/:friend_id','Accepts the given user as your friend'
  formats ['json']
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  param_group :accept_params
  example "
  {
    'friendships':
      {
          'friend_id':'2'
      }
  }"
  error code:400
  def accept
    # Friend to accept
    @friend_user = User.find(params[:friendships][:friend_id])

    # Get frienship to check if is pending or not.
    @friendship = @user.friendships.where(friend_id: params[:friendships][:friend_id]).first

    # Get reverse relationship to update.
    @reverse_friendship = @friend_user.friendships.where(friend_id: @user.user_id).first

    #Throwing error if friendship doesn't exist
    if @friendship.nil? or @reverse_friendship.nil?
      return render json: {exception: "FriendshipException", message: "Unexisting friendship"}
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
      return render json: {exception: "FriendshipException", message: "He/She friend is not a pending friend"}
    end
    return render json: {message: "Invitation accepted"}
  end

  api :GET, '/users/:user_id/friendships_pending', 'Show all pending friends'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  Response:
  {
      'user_id': 10,
      'friendships': [
        {
            'user_id': '4',
            'name': 'Ida Fadel',
            'main_photo_url': 'http://url.jpg'
        },
        {
            'user_id': '6',
            'name': 'Pedro Sanchez',
            'main_photo_url': 'http://url.jpg'
        }
      ]
  }"
  error code:400
  def pending
    @friendships = @user.pending_friends
    return render action: 'show_pending'
  end

  api :DELETE, '/users/:user_id/frienships/omit', 'Omit friendship'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  param_group :accept_params
  example "
  Request body:
  {
    'friendships':
      {
          'friend_id':'2'
      }
  }"
  error code:400
  def omit
    begin
      @user2 = User.find(params[:friendships][:friend_id])
      @user.omit_friend!(@user2)
    rescue => e
      return render json: {exception: "UnomittedFriend", message: "Impossible to omit friend with id: #{@user2.user_id}"}
    end
    return render json: {message:"Request omitted"}
  end

  api :GET, '/users/:user_id/friendships_secret_pending', 'Show friends that accepts to show his/her secret lovers.'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  Response:
  {
      'user_id': 10,
      'friendships': [
        {
            'friend_id': 1
        },
        {
            'friend_id': 2
        }
      ]
  }"
  error code:400
  def secrets
    @friendships = @user.secret_petitions
    return render action:'show_pending'
  end

  api :POST,'/users/:user_id/friendships_secret', 'Send an invitation to see his/her friend secret lovers.'
  formats ['json']
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  param_group :accept_params
  example "
  {
    'info': 'Invitations sent'
  }"
  error code:400
  def create_secret
    @user2 = User.find(params[:friendships][:friend_id])
    # Checking that friendship exists to send a request.
    @friendship = @user2.friendships.where(friend_id: @user.user_id).first
    if !@friendship.nil? and @friendship.accepted?
        @user.invite_secret_friend!(@user2)
        return render json: {message: "Sending invitation to see his/her friend"}
    end
    return render json: {exception:"FriendshipException", message: "Not accepted friend"}
  end

  api :PUT, '/users/:user_id/friendships_secret/:friend_id','Accept to see secret lovers'
  formats ['json']
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  param_group :accept_params
  example "
  Request body:
  {
    'friendships':
      {
          'friend_id':'2'
      }
  }"
  error code: 400
  def accept_secret
    @user2 = User.find(params[:friendships][:friend_id])
    begin
      @user.accept_secret_friend!(@user2)
    rescue
      return render json: {exception: "FrienshipError", message:"Now your friend #{@user2.name} can not see your secret lovers"}, status: 400
    end
      return  render json: {message:"Now your friend #{@user2.name} can see your secret lovers"}
  end

  api :DELETE, '/users/:user_id/frienships_secret/omit', 'Not to show secret lovers to the given users'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  param_group :accept_params
  example "
  Request body:
  {
    'friendships':
      {
          'friend_id':'2'
      }
  }"
  error code:400
  def omit_secret
    @user2 = User.find(params[:friendships][:friend_id])

    if @user.omit_secret_friend!(@user2)
      return render json: {message: "Omitted secret friend with id #{@user2.user_id}"}
    else
      return render json: {exception: "FriendshipException", message: "Impossible to omit secret friend"}
    end
  end

  api :GET, '/users/:user_id/friendships/:friend_id/lovers', 'Method to see your friend lovers'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  Response:
  {

    'user_id': 10,
    'friend_id': 1,
    'lovers': {
        'public': [
            {
                'lover_id': 1,
                'name': 'Pascale King',
                'photo_url': 'http://Pascale King.jpg'
            },
            {
                'lover_id': 7,
                'name': 'Oceane Marvin',
                'photo_url': 'http://Oceane Marvin.jpg'
            }
        ],
        'secret':[
            {
                'lover_id': 9,
                'name': 'Seven Stage',
                'photo_url': 'http://Seven Stage.jpg'
            },
            {
                'lover_id': 8,
                'name': 'Rake Partin',
                'photo_url': 'http://Rake Partin.jpg'
            }
        ]
    }
  }"
  error code:400
  def get_friend_lovers
    @public_lovers = @friend.public_lovers
    @friendship = Friendship.where(user_id: @user.user_id, friend_id: @friend.user_id).first
    @secret_lovers = []
    if secret_friendship
      @secret_lovers = @friend.secret_lovers
    end
      return render action: 'show_lovers'
  end

  api :GET, '/users/:user_id/friendships/:friend_id/lovers/:lover_id', 'Retrieve all info about lover from user friend'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  Response:
  {
    'user_id': 10,
    'friend_id': 1,
    'lover': {
        'lover_id': 1,
        'facebook_id': 'v8lyae5v9mktv1v',
        'name': 'Pascale King',
        'photo_url': 'http://Pascale King.jpg',
        'experiences': [
            {
                'experience_id': 1,
                'final_score': 4
            },
            {
                'experience_id': 2,
                'final_score': 4
            },
            {
                'experience_id': 3,
                'final_score': 7
            }
        ]
    }
  }"
  error code:400
  def get_friend_lover
    @lover = Lover.find_by_lover_id(params[:lover_id])
    @lover_rel = UserLover.where(user_id: params[:friend_id], lover_id: params[:lover_id]).first

    # Check if it is a secret lover and user doesn't have friend permission to see his/her secret lovers.
    return render json: {error: "FriendshipException", message: "Is not possible to show a secret lover without friend permissions"} if !secret_friendship and @lover_rel.visibility==0

    @experiences = @lover.experiences
    return render action: 'show_lover'
  end

  api :GET, '/users/:user_id/friendships/:friend_id/lovers/:lover_id/experiences/:experience_id', 'Getting info about lover experience of the given user friend'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  Response:
  {
    'experience_id': 1,
    'final_score': 4
  }"
  def lover_experience
    begin
      @lover_rel  = UserLover.where(lover_id: params[:lover_id]).first
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
        return render json: {exception:"FriendshipException", message: "This user doesn't exist"}, status: 400
      end
    end

    # Set current friend.
    def set_friend
      begin
        @friend = User.find(params[:friend_id])
      rescue
        return render json: {exception:"FriendshipException", message: "This friend doesn't exist"}, status: 400
      end
    end

    # Checks if a user is allowed to see secret lovers from any friend
    def secret_friendship
      @friendship = Friendship.where(user_id: @user.user_id, friend_id: params[:friend_id]).first
      if @friendship.nil?
        return false
      end
      @friendship.secret_lover_accepted
    end

    def friendships_params
      params.permit(:friend_id, :email, :user_id)
    end

end
