
 module SessionsHelper
  def sign_in_(user)
     cookies.permanent[:remember_token] = user.remember_token
     self.current_user = user
   end

  def signed_in?
     !current_user.nil?
   end

  def sign_out
     self.current_user = nil
     cookies.delete(:remember_token)
   end

   def current_user=(user)
     @current_user = user
   end

   def current_user
     @current_user ||= User.find_by(remember_token: cookies[:remember_token])
   end

   def current_user?(user)
     user == current_user
   end

   def authenticate
     authenticate_or_request_with_http_token do |token, options|
       token == @user.remember_token
     end
   end

   def authenticate_admin
    authenticate_or_request_with_http_token do |token, options|
      @user = User.where(admin: true).first
      token == @user.remember_token and @user.admin == true
    end
  end

   def redirect_back_or(default)
     redirect_to(session[:return_to] || default)
     session.delete(:return_to)
   end

   def store_location
     session[:return_to] = request.url
   end

   def user_from_remember_token
     remember_token = cookies[:remember_token]
     User.find_by_remember_token(remember_token) unless remember_token.nil?
   end
 end

