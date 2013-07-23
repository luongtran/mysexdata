class MessagesController < ApplicationController
  before_action :set_user, :authenticate


  # GET /users/:user_id/messages
  def index
    @messages = @user.messages
    respond_to do |format|
      format.html { render 'index' }
      format.json { render action:'index' }
    end
  end

  # POST /users/:user_id/messages
  def create
    @receiver = User.find(params[:message][:receiver_id])
    @message = @receiver.messages.build(sender_id: @user.user_id, content: params[:message][:content])

    respond_to do |format|
      if @message.save
        format.html { redirect_back_or user }
        format.json { render action: 'show_message', status: :created }
      else
        format.html { redirect_back_or user }
         format.json { render json: {error:"Imposible to send your message"}}
      end
    end
  end

  # DELETE /users/:user_id/messages
  def clear
    @messages = @user.messages.destroy_all
    # @messages = @user.messages.where("created_at <= :date", date: params[:message][:date_at]).destroy_all
    respond_to do |format|
      format.html { render 'index' }
      format.json {  render action:'index', location: @message }
    end


  end

  private

    def set_user
      begin
        @user = User.find(params[:user_id])
      rescue
        return render json: {exception: "MessageException", message: "This user doesn't exist"}, status: 412
      end
    end
end
