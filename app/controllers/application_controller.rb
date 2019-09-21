class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?

  def log_in_user(user) 
    session[:session_token] = user.reset_session_token!
  end

  def current_user
    @curent_user ||= User.find_by(session_token: session[:session_token])
  end

  def logout
    current_user.reset_session_token!
    @current_user = nil
    session[:session_token] = nil 
  end

  def logged_in?
    !!current_user
  end

  def ensure_logged_in
  end
end