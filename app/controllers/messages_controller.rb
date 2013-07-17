class MessagesController < ApplicationController
  before_action :set_user, :authenticate


  def index
    @user = current_user
    @messages = current_user.messages
    respond_to do |format|
      format.html { render 'index' }
      format.json { render action:'index', location: @messages }
    end
  end

  def create
    @user = User.find(params[:message][:receiver_id])
    @message = @user.messages.build(sender_id: current_user.user_id, content: params[:message][:content])

    respond_to do |format|
      if @message.save
        format.html { redirect_back_or user }
        format.json { render action: 'show_message', status: :created, location: @user }
      else
        format.html { redirect_back_or user }
         format.json { head :no_content }
      end
    end
  end

  def clear
    @user = current_user
    @messages = current_user.messages.where("created_at <= :date", date: params[:message][:date_at]).destroy_all
    respond_to do |format|
      format.html { render 'index' }
      format.json {  render action:'index', location: @message }
    end


  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end

end
