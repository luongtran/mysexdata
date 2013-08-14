#####################################################
## Controller that manages all REST methods related with User Lovers ##
#####################################################
class LoversController < ApplicationController

  # Token authentication
  before_action :set_user#, :authenticate

  before_action :set_lover, only: [:show, :update, :destroy]

  # Definition of api doc params
  def_param_group :lover do
    param :lovers, Array  do
      param :name, String, required: true
      param :email, String, required: true
      param :facebook_id, String, required: true
      param :photo_url, String, required: true
      param :age, String, required: false
      param :sex_gender, [0,1],'(Integer)', required: false
      param :job, [0,1,2,3],'(Integer)', required: false
      param :height, [0,1],'(Integer)', required: false
      param :visibility, [0,1],'(Integer)', required: true
      param :pending, [true, false], '(Boolean)',required: true
    end
  end

  # Definition of api doc params
  def_param_group :lover_up do
    param :lovers, Hash  do
      param :name, String, required: false
      param :email, String, required: false
      param :facebook_id, String, required: false
      param :photo_url, String, required: false
      param :age, String, required: false
      param :sex_gender, [0,1],'(Integer)', required: false
      param :job, [0,1,2,3],'(Integer)', required: false
      param :height, [0,1],'(Integer)', required: false
      param :visibility, [0,1],'(Integer)', required: false
      param :pending, [true, false], '(Boolean)',required: false
    end
  end

  # Verifying user before the given methods.
  #before_action :signed_in_user, only: [:create, :update, :destroy]

  # Only responds in json format.
  respond_to :json

  api :GET, '/users/:user_id/lovers', 'Get user public and secret lovers'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  {
    'user_id': 1,
    'lovers': {
        'public': [
            {
                'lover_id': 3,
                'name': 'Kaci Adams DDS',
                'photo_url': 'http://Kaci Adams DDS.jpg',
                'age': -1,
                'sex_gender': -1,
                'job': -1,
                'height': -1
            }
        ],
        'secret': [
            {
                'lover_id': 4,
                'name': 'Wilhelmine Gislason Sr.',
                'photo_url': 'http://Wilhelmine Gislason Sr..jpg',
                'age': -1,
                'sex_gender': -1,
                'job': -1,
                'height': -1
            }
        ]
    }
  }"
  def index
    @public_lovers = @user.public_lovers
    @secret_lovers = @user.secret_lovers
    return render action: 'index'
  end


  api :GET, '/users/:user_id/lovers/:lover_id', 'Show a user lover'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  {
    'lover_id': 5,
    'facebook_id': 'hosjz5b3w7c6rrf',
    'name': 'Frederique Bernier',
    'photo_url': 'http://Frederique Bernier.jpg',
    'age': -1,
    'sex_gender': -1,
    'job': -1,
    'height': -1
  }"
  def show
    @rel_lover  = @user.user_lovers.where(lover_id: @lover.lover_id).first
    return render action: 'show'
  end

  api :POST, '/users/:user_id/lovers', 'Create a new lover to this user'
  formats ['json']
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  param_group :lover
  example "
  Content:

  {
    'lovers':[
      {
        'name': 'Emilio Garcia',
        'facebook_id': '3er',
        'photo_url': 'http://myphoto_emilio.com',
        'age': 36,
        'sex_gender': 0,
        'job': 1,
        'height': 1,
        'visibility': 1,
        'pending': true
      },
      {
        'name': 'Emilio Sanchez',
        'facebook_id': '2er',
        'photo_url': 'http://myphoto_sanchez.com',
        'age': 32,
        'sex_gender': 0,
        'job': 1,
        'height': 1,
        'visibility': 0,
        'pending': false
      }
    ]
  }

  Response

  {
    'info': [
        'Lover with facebook_id: 3er and name:Emilio Gaererrcia added successfully',
        'Lover with facebook_id: 2er and name:Emilio Sereranchez added successfully'
    ]
  }

  Error

  {
    'exception': 'LoversException',
    'message': [
        'Lover with facebook_id: 3edfr and name: Emilio Garcia already exists'
    ],
    'info': [
        'Lover with facebook_id: 2wewer and name:Emilio Sanchez added successfully'
    ]
  }"
  def create
    lovers = JSON.parse(params[:lovers].to_json)
    errors = []
    info = []
    lovers.each do |lov|
      if @user.lovers.exists?(facebook_id: lov["facebook_id"], name: lov["name"])
        errors << "Lover with facebook_id: #{lov["facebook_id"]} and name: #{lov["name"]} already exists"
      else
        begin
          created_lover = Lover.create!(name: lov["name"],facebook_id: lov["facebook_id"], photo_url: lov["photo_url"], age: lov["age"], sex_gender: lov["sex_gender"], job: lov["job"], height: lov["height"])
          @lover = @user.user_lovers.create(lover: created_lover, visibility: lov["visibility"], pending: lov["pending"])
        rescue
          errors << "#{$!}"
          break;
        end
        info << "Lover with facebook_id: #{lov["facebook_id"]} and name:#{lov["name"]} added successfully"
      end
    end
    if !errors.empty?
      return render json: {exception: "LoversException", message: errors, info: info}
    end
    render json: {info: info}
  end

  api :PUT, '/user/:user_id/lovers/:lover_id', 'Edit a user lover'
  formats ['json']
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  param_group :lover_up
  example "
  {
      'lovers':{
        'name': 'Emilio Sereno'
      }
  }

  Response
  {
    'lover_id': 14,
    'facebook_id': '2wewer',
    'name': 'Emilio Sánchez',
    'photo_url': 'http://myphoto_sanchez.com',
    'age': 32,
    'sex_gender': 0,
    'job': 1,
    'height': 3
  }"
  def update
    @rel_lover  = @user.user_lovers.where(lover_id: @lover.lover_id).first
    if !params[:lovers][:visibility].nil?
      if @rel_lover.update_attribute(:visibility, params[:lovers][:visibility])
        return render action: 'show'
      else
        return render json: @rel_lover.errors.full_messages, status: :unprocessable_entity
      end
    end

     if !params[:lovers][:pending].nil?
      if @rel_lover.update_attribute(:pending, params[:lovers][:pending])
        return render action: 'show'
      else
        return render json: @rel_lover.errors.full_messages, status: :unprocessable_entity
      end
    end

    if @lover.update(lover_params)
      return render action: 'show'
    else
      return render json: @lover.errors.full_messages, status: :unprocessable_entity
    end
  end

  api :DELETE, '/users/:user_id/lovers/:lover_id', 'Delete a user lover'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  {
    'info': 'Lover :lover_id removed successfully'
  }"
  def destroy
    @lover.destroy
    return  render json: {info: "Lover #{@lover.lover_id} removed successfully"}
  end

  api :GET, 'users/:user_id/lovers_pending', 'Retrieve pending lovers'
  description"
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  {
   'lovers':[
      {
        'name': 'Emilio Garcia',
        'facebook_id': '3er',
        'photo_url': 'http://myphoto_emilio.com',
      },
      {
        'name': 'Emilio Sanchez',
        'facebook_id': '2er',
        'photo_url': 'http://myphoto_sanchez.com',
      }
  }"
  def pending_lovers
    @pending_lovers = @user.pending_lovers
    render action: 'show_pending'
  end

  private

    # Defines the user that correspondes to the given urser_id
    def set_user
     begin
        @user = User.find(params[:user_id])
      rescue
        return render json: {exception: "LoverException", message: "This user doesn't exist"}, status: 400
      end
    end

    #Use callbacks to share common setup or constraints between actions.
    def set_lover
      begin
        @lover = Lover.find(params[:lover_id])
      rescue
        return render json: {exception: "LoverException", message: "This lover doesn't exist"}, status: 400
      end

    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def lover_params
      params.require(:lovers).permit(:name, :facebook_id, :photo_url, :age, :sex_gender, :job, :height)
    end
end
