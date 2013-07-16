module SessionsHelper

  def current_user=(user)
    @current_user = user
  end

  def current_user?(user)
    user == current_user
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      token == @user.remember_token
    end
  end

end
