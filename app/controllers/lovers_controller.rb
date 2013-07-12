class LoversController < ApplicationController
  #skip_before_filter  :verify_authenticity_token
  before_action :set_user, only: [:show_all, :show, :update, :destroy]
  before_action :set_lover, only: [:show, :update, :destroy]
  #before_action :signed_in_user, only: [:create, :update, :destroy]
  #before_action :correct_user,   only:  :destroy

  # GET users/:user_id/lovers
  # GET users/:user_id/lovers.json
  def show_all  
    @public_lovers = Lover.where(visibility: 0, user_id: @user.id)
    @secret_lovers = Lover.where(visibility: 1, user_id: @user.id)
    respond_to  do |format|
      format.html { render 'index' }
      format.json { render action: 'show_all'}
    end  
  end

  # GET users/:user_id/lovers/:lover_id
  # GET users/:user_id/lovers/:lover_id.json
  def show
    respond_to  do |format|
      format.html { redirect_to lovers_url }
      format.json { render action: 'show'}
    end  
  end

  # POST /lovers
  # POST /lovers.json
  def create
    @lover = current_user.lovers.build(lover_params)
    if @lover.save
      if @lover.experience.update_columns(experience_params)
        respond_to do |format|
          format.html { redirect_to current_user, notice: 'Lover was successfully created.' }
          format.json { render action: 'show', status: :created, location: @lover }
        end
      else
        respond_to do |format|
          format.html { render action: 'new' }
          format.json { render json: @lover.errors.full_messages, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /lovers/1
  # PATCH/PUT /lovers/1.json
  def update
    respond_to do |format|
      if @lover.update(lover_params)
        format.html { redirect_to @lover, notice: 'Lover was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lover.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lovers/1
  # DELETE /lovers/1.json
  def destroy
    @lover.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { render json: true }
    end
  end

  private
     def set_user
      @user = User.find(params[:user_id])
    end
    #Use callbacks to share common setup or constraints between actions.
    def set_lover
      logger.debug params
      @lover = Lover.find_by(lover_id: params[:lover_id], user_id: params[:user_id])
      logger.debug "lover"
      logger.debug @lover
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def lover_params
      params.require(:lover).permit(:user_id,:lover_id, :facebook_id, :name, :photo_url, :age, :sex_gender, :job, :height, :visibility, :pending)
    end

    def correct_user
      @lover = current_user.lovers.find_by(id: params[:id])
      if @lover.nil?
        respond_to do |format|
          format.html { redirect_to users_url }
          format.json { head :no_content }
        end
      end
    end
end
