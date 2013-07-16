########################################################################################
## Controller that manages all REST methods related with User experiences with a lover ##
########################################################################################
class ExperiencesController < ApplicationController

  # Token authentication
  #skip_before_filter  :verify_authenticity_token

  # Set user, lover and experience before the given methods.
  before_action :set_user, only: [:show_all, :show, :update, :destroy]
  before_action :set_lover, only: [:show_all, :show, :update, :destroy]
  before_action :set_experience, only: [:show, :update, :destroy]

  before_action :authenticate


  # Only responds in json format.
  respond_to :json

  # GET /users/:user_id/lovers/:lover_ir/experiences/:experience_id.json
  # GET /users/:user_id/lovers/:lover_ir/experiences/:experience_id
  def show
    respond_to do |format|
      format.html {render 'show'}
      format.json {render action: 'show'}
    end
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
        format.json { ender json: @experience.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/:user_id/lovers/:lover_ir/experiences/:experience_id.json
  # DELETE /users/:user_id/lovers/:lover_ir/experiences/:experience_id
  def destroy
    @experience = Experience.find(params[:id])
    @experience.destroy
    return render :json => {"message"=> "Experience removed correctly"}
  end

  private
    
    # Defines current user
    def set_user
      @user = User.find(params[:user_id])
    end

    # Defines current lover
    def set_lover
      @lover = Lover.find(params[:lover_id])
    end

    # Defines current experience
    def set_experience
      @experience = Experience.find(params[:experience_id])

    end

    # Parameters that are allowed by Experience model.
    def experience_params
      params.require(:experience).permit(:date,:location,:place,:detail_one,:detail_two,:detail_three,:hairdressing,:kiss,:oral_sex,:intercourse,:caresses,:anal_sex,:post_intercourse,:personal_score,:next_one,:msd_score,:bad_lover,:final_score)
    end

end
