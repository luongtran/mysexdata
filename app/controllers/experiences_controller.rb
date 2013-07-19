########################################################################################
## Controller that manages all REST methods related with User experiences with a lover ##
########################################################################################
class ExperiencesController < ApplicationController

  # Token authentication
  before_action :set_user, :authenticate
  
  before_action :set_lover, only: [:show_all, :show, :update, :destroy]
  before_action :set_experience, only: [:show, :update, :destroy]



  # Only responds in json format.
  respond_to :json

  # GET /users/:user_id/lovers/:lover_ir/experiences/:experience_id.json
  # GET /users/:user_id/lovers/:lover_ir/experiences/:experience_id
  def show
    return render action: 'show'
  end

  # DELETE /users/:user_id/lovers/:lover_ir/experiences
  # DELETE /users/:user_id/lovers/:lover_ir/experiences.json
  def show_all
    @experiences = @lover.experiences
    respond_to do |format|
      format.html {render 'show_all'}
      format.json {render action: 'show_all'}
    end
  end

  # POST /users/:user_id/lovers/:lover_ir/experiences
  # POST /users/:user_id/lovers/:lover_ir/experiences.json
  def create
  end

  # PUT /users/:user_id/lovers/:lover_ir/experiences/:experience_id.json
  # PUT /users/:user_id/lovers/:lover_ir/experiences/:experience_id
  def update
    respond_to do |format|
      if @experience.update(experience_params)
        #format.html { redirect_to @experience, notice: 'Experience was successfully updated.' }
        format.json { render action: 'show', status: :updated }
      else
        #format.html { render action: 'show' }
        format.json { render json: @experience.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/:user_id/lovers/:lover_ir/experiences/:experience_id.json
  # DELETE /users/:user_id/lovers/:lover_ir/experiences/:experience_id
  def destroy
    @experience.destroy
    return render json: {message: "Experience removed correctly"}
  end

  private
    
    # Defines current user
    def set_user
      begin
        @user = User.find(params[:user_id])
      rescue
        return render json: {errors: "This user doesn't exist"}, status: 422   
      end
    end

    # Defines current lover
    def set_lover
      begin
        @lover = Lover.find(params[:lover_id])
      rescue
        return render json: {errors: "This lover doesn't exist"}, status: 422   
      end
    end

    # Defines current experience
    def set_experience
      begin
        @experience = Experience.find(params[:experience_id])
      rescue
        return render json: {error: "This experience doesn't exist"}, status: 422
      end

    end

    # Parameters that are allowed by Experience model.
    def experience_params
      params.require(:experience).permit(:date,:location,:place,:detail_one,:detail_two,:detail_three,:hairdressing,:kiss,:oral_sex,:intercourse,:caresses,:anal_sex,:post_intercourse,:personal_score,:next_one,:msd_score,:bad_lover,:final_score)
    end

end
