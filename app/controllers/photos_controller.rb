class PhotosController < ApplicationController
  before_action :set_user, :authenticate
  before_action :set_photo, only: [:edit, :update, :destroy]

  respond_to :json

  def_param_group :photos_param do
    param :photo, Hash do
      param :url, String, required: false
    end
  end

  api :GET, 'users/:user_id/photos', 'Retrieve all photos from a user'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  Response:
  {
    'user_id': 1,
    'photos': [
        {
            'photo_id': 1,
            'url': 'http://myurl1'
        },
        {
            'photo_id': 2,
            'url': 'http://myurl2'
        },
        {
            'photo_id': 3,
            'url': 'http://myurl3'
        },
        {
            'photo_id': 4,
            'url': 'http://myurl4'
        },
        {
            'photo_id': 5,
            'url': 'http://myurl5'
        }
    ]
  }"
  def index
    @photos = Photo.all
  end

  api :GET, '/users/:user_id/photos/:photo_id', 'Get info of a photo'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  Response:
  {
    'photo_id': 1,
    'url': 'http://myurl1',
    'date': '2013-07-24T08:53:31.510Z'
  }"
  def show
    @photo = @user.photos.where(photo_id: params[:photo_id]).first
    return render action: 'show'
  end


  # GET /photos/1/edit
  def edit
  end


  api :POST, '/users/:user_id/photos', 'Add a photo'
  formats ['json']
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  param_group :photos_param
  example "
  Request body:
  {
    'url':'http://photourl.jpg'
  }

  Response:
  {
    'photo_id': 6,
    'url': 'http://photourl.jpg',
    'date': '2013-07-24T09:12:13.273Z'
  }"
  def create
    @photo = @user.photos.create(photo_params)
    if @photo.save
      return render action: 'show', status: :created
    else
      return render json: {exception: 'PhotoEsception', message: @photo.errors.full_messages}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  # NOT USED!
  def update
    if @photo.update(photo_params)
      return render json: {info: 'Photo successfully updated'}
    else
      return render json: {exception: 'PhotoEsception', message: @photo.errors.full_messages}, status: :unprocessable_entity
    end
  end

  api :DELETE, 'users/:user_id/photos/:photo_id', 'Remove a photo from user\'s album'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  {
    'info': 'Photo removed successfully'
  }"
  def destroy
    @photo.destroy
    return render json: {info:"Photo removed successfully"}
  end

  private

    # Defines the user that correspondes to the given urser_id
    def set_user
     begin
        @user = User.find(params[:user_id])
      rescue
        return render json: {exception: "PhotosException", message: "This user doesn't exist"}, status: 400
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      begin
        @photo = Photo.find(params[:photo_id])
      rescue
        return render json: {exception: "PhotosException", message: "This photo doesn't exist"}, status: 400
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:url)
    end
end
