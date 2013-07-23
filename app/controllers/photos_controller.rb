class PhotosController < ApplicationController
  before_action :set_user, :authenticate
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @photo = @user.photos
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = @user.photos.create(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: 'Photo was successfully created.' }
        format.json { render action: 'show', status: :created }
      else
        format.html { render action: 'new' }
        format.json { render json: @photo.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: 'Photo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @photo.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url }
      format.json { render json: {message:"Photo removed successfully"} }
    end
  end

  private

    # Defines the user that correspondes to the given urser_id
    def set_user
     begin
        @user = User.find(params[:user_id])
      rescue
        return render json: {exception: "PhotosException", message: "This user doesn't exist"}, status: 422
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      begin
        @photo = Photo.find(params[:photo_id])
      rescue
        return render json: {exception: "PhotosException", message: "This photo doesn't exist"}, status: 422
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:photo_url)
    end
end
