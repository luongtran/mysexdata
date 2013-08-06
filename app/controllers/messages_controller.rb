class MessagesController < ApplicationController
include UsersHelper

  before_action :set_user, :authenticate

  respond_to :json

  # Definition of api doc params
  def_param_group :messages do
    param :message, Hash do
      param :receiver_id, Integer, required: true
      param :content, String, required: true
    end
  end

  api :GET, '/users/:user_id/messages', 'Retrieve all user messages from all senders'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  Response:
  {
  'receiver_id': 5,
    'messages': [
        {
            'sender_id': 1,
            'content': 'hola',
            'date': '2013-07-23T14:03:21.578Z'
        },
        {
            'sender_id': 2,
            'content': 'como estas?',
            'date': '2013-07-23T14:03:21.584Z'
        },
        {
            'sender_id': 3,
            'content': 'Yo estube en casa de mi hermana',
            'date': '2013-07-23T14:03:21.588Z'
        },
        {
            'sender_id': 4,
            'content': 'como fue la cena?',
            'date': '2013-07-23T14:03:21.593Z'
        },

  }"
  def index
    @messages = @user.messages
    render action:'index'
  end

  api :POST, '/users/:user_id/messages', 'Send a message to another user'
  formats ['json']
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  param_group :messages
  example "
  Request body:
  {
    'receiver_id':'2'
    'content':'Hola, ¿cómo estás?'
  }

  Response:
  {
    'receiver_id': 2,
    'sender_id': 1,
    'content': 'Hola, ¿cómo estás?',
    'created_at': '2013-07-24T08:22:27.021Z',
    'user_id': 1,
    'name': 'Example User'
  }"
  def create
    @receiver = User.find(params[:message][:receiver_id])
    if !is_blocked(@user, @receiver)
      @message = @receiver.messages.build(sender_id: @user.user_id, content: params[:message][:content])
    else
     return render json: {exception: "MessageException", message: "You are blocked by this user and you can't send any message"}
    end

    if @message.save
      return render action: 'show_message', status: :created
    else
      return render json: {exception: "MessageException", message:"Imposible to send your message"}
    end

  end

  api :DELETE, '/users/:user_id/messages', 'Clear all message from the server'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  Response:
  {
    'info':'Messages removed successfully'
  }"
  def clear
    @user.messages.destroy_all
    # @messages = @user.messages.where("created_at <= :date", date: params[:message][:date_at]).destroy_all
    return render json: {info: "Messages removed successfully"}
  end

  private

    def set_user
      begin
        @user = User.find(params[:user_id])
      rescue
        return render json: {exception: "MessageException", message: "This user doesn't exist"}, status: 412
      end
    end



    def message_params
      params.permit(:sender)
    end
end
