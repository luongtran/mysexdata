class SessionsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

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
    if user && user.authenticate(params[:session][:password])
      sign_in_ user
      respond_to do |format|
        format.html { redirect_back_or user }
        format.json { render :json => {:user_id => user.user_id, :email => user.email, :remember_token => user.remember_token } }
      end

    else
      respond_to do |format|
        format.html { flash[:error] = 'Invalid email/password combination' # Not quite right!
        render 'new' }
        format.json { render :json => {:Error => 'Invalid email/password combination'} , status: :unprocessable_entity }
      end
    end
  end

  def destroy
    sign_out_
    respond_to do |format|
      format.html { redirect_to root_url }
    end
  end
end
