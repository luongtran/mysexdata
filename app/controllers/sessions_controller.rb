class SessionsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  respond_to :json

  def new
    @title = "Sign in"
  end

  api :POST, '/session', 'Returns remember token to access user information'
  formats ['json']
  param :email, String, required: true
  param :password, String, required: true
  example "
  Request body:
  {
    'email':'example@railstutorial.org'
    'password':'1234'
  }

  Response:
  {
    'user_id': 1,
    'email': 'example@railstutorial.org',
    'remember_token': 'xxxxxxxxxxxx'
  }"
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user
      return render json: {user_id:user.user_id, email: user.email, remember_token: user.remember_token }
    else
      return render json: {error:'Invalid email/password combination'} , status: 400
    end
  end

  api :GET, '/guest', 'Returns guest token to create a user and to see all registered users'
  example "
  Response:
  {
    'user': 'Guest',
    'remember_token':'xxxxxxxxxxxx'
  }"
  def guest_token
    user = User.find_by_user_id(1)
    if !user.nil?
      return render json: {user: "Guest", remember_token: user.remember_token}
    else
      return render json: {exception: "SessionsException", message: "Guest user not found"}
    end
  end

end
