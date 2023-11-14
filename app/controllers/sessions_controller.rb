class SessionsController < ApplicationController
  # User implementation should be credited to the slides titled "More About Sign Ups, Logins and Sessions"
  # presented in class during week of 11/6

  skip_before_filter :set_current_user
  def new
  end

  def create
    auth = request.env['omniauth.auth']
    user = User.find_by_provider_and_uid(auth['provider'], auth['uid']) || User.create_with_omniauth(auth)
    session[:session_token] = user.session_token
    redirect_to products_path
  end

  def destroy
    session[:session_token]=nil
    @current_user=nil
    flash[:notice]= 'You have logged out'
    redirect_to products_path
  end

  # def omniauth
  #   auth = request.env['omniauth.auth']
  #   user = User.find_or_create_by(:uid => auth['uid'], :provider => auth['provider']) do |u|
  #     u.email = auth['info']['email']
  #     u.password = SecureRandom.hex(10)
  #   end
  #   if user.valid?
  #     session[:session_token]
  #   end
  # end

end