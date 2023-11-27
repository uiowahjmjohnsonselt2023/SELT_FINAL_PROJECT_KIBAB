class SessionsController < ApplicationController
  # User implementation should be credited to the slides titled "More About Sign Ups, Logins and Sessions"
  # presented in class during week of 11/6

  # User implementation should be credited to the slides titled "Single Sign-On and Third Party Authentication"
  # presented in class during week of 11/6

  ## Additional documentation
  # Additional tutorial for implementation: https://dev.to/anne46/google-omniauth-in-a-rails-app-36ka
  # Additional implentation strategies: https://github.com/zquestz/omniauth-google-oauth2

  skip_before_action :set_current_user
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

end