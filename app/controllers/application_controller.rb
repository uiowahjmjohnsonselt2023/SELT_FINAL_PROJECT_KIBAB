class ApplicationController < ActionController::Base
  # User implementation should be credited to the slides titled "More About Sign Ups, Logins and Sessions"
  # presented in class during week of 11/6

  protect_from_forgery with: :exception
  before_action :set_current_user

  protected
  def set_current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
    redirect_to login_path_url unless @current_user
  end

  def current_user?(id)
    @current_user.id.to_s == id
  end

end
