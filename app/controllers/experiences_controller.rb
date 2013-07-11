class ExperiencesController < ApplicationController

  before_action :set_experience, only: [:show, :update, :destroy]
  protect_from_forgery :except => [:update]

  def show
    @experience = Experience.find_by_lover_id(params[:lover_id])
    respond_to do |format|
      format.html {render 'show'}
      format.json {render action: 'show'}
    end
  end

  def show_all
    @lover = Lover.find(params[:lover_id])
    @experiences = Experience.where(lover_id: params[:lover_id])
    respond_to do |format|
      format.html {render 'show_all'}
      format.json {render action: 'show_all'}
    end
  end

  def create
  end

  def update
    respond_to do |format|
      if @experience.update(experience_params)
        format.html { redirect_to @experience, notice: 'Experience was successfully updated.' }
        format.json { render action: 'show', status: :updated }
      else
        format.html { render action: 'show' }
        format.json { ender json: @experience.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end

  private

    def set_experience
      @experience = Experience.find_by_lover_id(params[:lover_id])

    end

    def experience_params
      params.require(:experience).permit(:date,:location,:place,:detail_one,:detail_two,:detail_three,:hairdressing,:kiss,:oral_sex,:intercourse,:caresses,:anal_sex,:post_intercourse,:personal_score,:next_one,:msd_score,:bad_lover,:final_score)
    end

end
