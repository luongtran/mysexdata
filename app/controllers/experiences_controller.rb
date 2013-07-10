class ExperiencesController < ApplicationController
  def show
  end

  def show_all
    @user = User.find(params[:user_id])
    @experiences = Experience.find_by_lover_id(params[:lover_id])
    respond_to do |format|
      format.html {render 'show_all'}
      format.json {render action: 'show_all'}
    end
  end

  def create
  end

  def update
  end

  def destroy
  end
end
