#######################################################################
## Controller that manages all REST methods related with User Lovers ##
#######################################################################
class LoversController < ApplicationController

  # Token authentication
  before_action :set_user, :authenticate
  
  before_action :set_lover, only: [:show, :update, :destroy]


  # Verifying user before the given methods.
  #before_action :signed_in_user, only: [:create, :update, :destroy]
  #before_action :correct_user,   only:  :destroy

  # Only responds in json format.
  respond_to :json

  # GET users/:user_id/lovers
  # GET users/:user_id/lovers.json
  def show_all
    @public_lovers = @user.lovers.where(visibility: 0)
    @secret_lovers = @user.lovers.where(visibility: 1)
    return render action: 'show_all'
  end

  # GET users/:user_id/lovers/:lover_id
  # GET users/:user_id/lovers/:lover_id.json
  def show
    return render action: 'show'
  end

  # POST /lovers
  # POST /lovers.json
  def create 
    @lover = @user.lovers.create(lover_params)
    if @lover.save
      #if @lover.experience.update_columns(experience_params)
        respond_to do |format|
          #format.html { redirect_to @user, notice: 'Lover was successfully created.' }
          format.json { render action: 'show', status: :created}
        end
      else
        respond_to do |format|
          #format.html { render action: 'new' }
          format.json { render json: @lover.errors.full_messages, status: :unprocessable_entity }
        end
      #end
    end
  end

  # PATCH/PUT /lovers/1
  # PATCH/PUT /lovers/1.json
  def update
    respond_to do |format|
      if @lover.update(lover_params)
        #format.html { redirect_to @lover, notice: 'Lover was successfully updated.' }
        format.json { render action: 'show'}
      else
        #format.html { render action: 'edit' }
        format.json { render json: @lover.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lovers/1
  # DELETE /lovers/1.json
  def destroy
    @lover = Lover.find(params[:id])
    @lover.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { render :json => {"message"=> "Lover removed correctly"} }
    end
  end

  private

    # Defines the user that correspondes to the given urser_id
    def set_user
      @user = User.find(params[:user_id])
    end

    #Use callbacks to share common setup or constraints between actions.
    def set_lover
      @lover = Lover.find(params[:lover_id])
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def lover_params
      params.permit(:name, :facebook_id, :photo_url, :age, :sex_gender, :job, :height, :visibility, :pending)

      # Not implemented yet
      #logger.debug "Paramlovers : #{params[:lovers]}"
      #params.require(:lovers).each do |lover|
      #  lover.permit(:facebook_id, :name, :photo_url, :age, :sex_gender, :job, :height, :visibility, :pending)
      #end
    end 
end
