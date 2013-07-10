class GeosexesController < ApplicationController
  before_action :signed_in_user, only: [:index, ]

  # GET /geosexes
  # GET /geosexes.json
  def index
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


end
