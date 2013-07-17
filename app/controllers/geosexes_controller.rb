class GeosexesController < ApplicationController
  #before_action :signed_in_user, only: [:index, ]
  before_action :set_user, :authenticate

  # GET /geosexes
  # GET /geosexes.json
  def index
    @geosexes = Geosex.where(user_id: params[:user_id])

    @users = User.joins(:geosex).where("geosexes.status" => 0)
    @friends = Array.new
    @normal = Array.new
    @users.each do |user|
      if !current_user?(user)
        if current_user.friends?(user)
          @friends << user
        else
          @normal << user
        end
      end
    end
  end

  private
  # Defines the user that correspondes to the given urser_id
    def set_user
      @user = User.find(params[:user_id])
    end

end
