class GeosexesController < ApplicationController
  #before_action :signed_in_user, only: [:index, ]
  before_action :set_user, :authenticate
  before_action :set_geouser, :except => [:create]

  DISTANCE_USERS =20 #Miles

  respond_to :json

  def_param_group :geosex_param do
    param :geosex, Hash do
      param :lat, Float, required: true
      param :lng, Float, required: true
    end
  end

  api :GET, '/users/:user_id/geosex','Show user location'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  Response
  {
    'user_id': 1,
    'access': 0,
    'lat': 41.2,
    'lng': 2.11,
    'address': 'Carretera de la Bunyola, 08820 El Prat de Llobregat, Barcelona, Spain'
  }"
  def index
    @geosex = Geosex.where(user_id: @user.user_id).first
    if @geosex.nil?
      return render json: {exception: 'GeosexException', message: 'Location not found'}
    end
    return render action: 'index'
  end

  api :POST, '/users/:user_id/geosex', 'Create your first location and save it'
  formats ['json']
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  param_group :geosex_param
  example "
  Request body:
  {
  'geosex':{
                  'lat':54.33555,
                  'lng':4.33
                }
  }

  Response:
  {
    'user_id': 7,
    'access': 0,
    'lat': 54.33555,
    'lng': 4.33,
    'address': null
  }"
  def create
    geosex = Geosex.where(user_id: @user.user_id).first
    if !geosex.nil?
      return render json: {exception: "GeosexException", message:"Geosex location already exists"}, status: 422
    end
    @geosex = @user.build_geosex(geo_params)
    if @geosex.save
      render action: 'index'
    else
      render json: {exception: "GeosexException", message: "Impossible to save your location. Remember that lat must be between -90 and 90 and lng between -180 and 180"}
    end
  end

  api :PUT, '/users/:user_id/geosex', 'Send your location to update it'
  formats ['json']
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  param_group :geosex_param
  example "
  Request body:
  {
  'geosex':{
                  'lat':54.33555,
                  'lng':4.33
                }
  }

  Response:
  {
    'user_id': 7,
    'access': 0,
    'lat': 54.33555,
    'lng': 4.33,
    'address': null
  }"
  def locate
    if @geosex.update_attributes(lat: params[:geosex][:lat], lng: params[:geosex][:lng], access: true)
      render action: 'index'
    else
      render json: {exception: "GeosexException", message: "Impossible to update your location.  Remember that lat must be between -90 and 90 and lng between -180 and 180"}
    end
  end

  # GET /users/:user_id/closer_users.json
  api :GET, '/users/:user_id/closer_users', 'Search closer users from the current user in a distance of 20 miles'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  {
    'user_id': 1,
    'lat': 54.33555,
    'lng': 4.33,
    'address': null,
    'closest_users': [
        {
            'user_id': 7,
            'name': 'Dante Gaylord',
            'status': 0,
            'main_photo_url': 'http://url.jpg'
        }
    ]
  }"
  def search_closest_users
    @closest_users = @user.geosex.nearbys(DISTANCE_USERS)
    @nearby_users = Array.new

    # Iterate over each closest user to retrieve his personal info.
    @closest_users.each do |user|
      nearby = User.find(user.user_id)
      @nearby_users.push(nearby)
    end
    render action: "show_closest_users"
  end

  private
  # Defines the user that correspondes to the given urser_id
    def set_user
      begin
        @user = User.find(params[:user_id])
      rescue
        return render json: {exception: "GeosexException", message: "This user with id: #{params[:user_id]} doesn't exist"}, status: 412
      end
    end

    def set_geouser
      begin
        @geosex = Geosex.find(params[:user_id])
      rescue
        return render json: {exception: "GeosexException", message: "This geosex user with id: #{params[:user_id]} doesn't exist"}, status: 412
      end

    end

    def geo_params
      params.require(:geosex).permit(:lat, :lng, :address)
    end

end
