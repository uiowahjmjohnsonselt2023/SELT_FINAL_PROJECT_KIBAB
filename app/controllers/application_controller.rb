class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_filter :set_current_user
  #protected
  #def set_current_user
  #  # we exploit the fact that the below query may return nil
  #  @current_user ||= User.where(:id => session[:user_id])
  #  redirect_to login_path and return unless @current_user
  #end

  #def current_user?(id)
  #  @current_user.id.to_s == id
  #end
end
