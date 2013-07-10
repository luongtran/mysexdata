class SessionsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def new
    @title = "Sign in"
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      respond_to do |format|
        format.html { redirect_back_or user }
        format.json { render :json => {:user_id => user.id, :request_method => cookies[:request_method], :_mysexdata_session => cookies[:_mysexdata_session], :remember_token => user.remember_token } }      
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
    sign_out
    respond_to do |format|
      format.html { redirect_to root_url }
    end
  end
end
