class GeosexesController < ApplicationController
  #before_action :signed_in_user, only: [:index, ]
  before_action :set_user, :authenticate
  before_action :set_geouser, :except => [:create]

  DISTANCE_USERS =20

  respond_to :json

  # GET /geosexes
  # GET /geosexes.json
  def index
    @geosex = Geosex.where(user_id: @user.user_id)
    render json: @geosex
  end

  # POST /users/:user_id/geosexes.json
  def create
   @geouser = @user.create_geosex(geo_params)
   

   if @geouser.save
      render json: @geouser
    else
      render json: {error: "Impossible to save your location"}
    end
  end

  # PUT /users/:user_id/geosexes.json
  def locate
    if @geouser.update_attributes(lat: params[:geosex][:lat], lng: params[:geosex][:lng], access: true)
      render json: @geouser
    else
      render json: {error: "Impossible to save your location"}
    end
  end

  # GET /users/:user_id/closer_users.json
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
        return render json: {errors: "This user with id: #{params[:user_id]} doesn't exist"}, status: 412   
      end
    end

    def set_geouser
      begin
        @geouser = Geosex.find(params[:user_id])
      rescue
        return render json: {errors: "This geosex user with id: #{params[:user_id]} doesn't exist"}, status: 412
      end

    end

    def geo_params
      params.require(:geosex).permit(:lat, :lng, :address)
    end

end
