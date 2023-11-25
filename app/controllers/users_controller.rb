class UsersController < ApplicationController
  # User implementation should be credited to the slides titled "Single Sign-On and Third Party Authentication"
  # presented in class during week of 11/6

  ## Additional documentation
  # Additional tutorial for implementation: https://dev.to/anne46/google-omniauth-in-a-rails-app-36ka
  # Additional implentation strategies: https://github.com/zquestz/omniauth-google-oauth2

  before_action :set_current_user

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :address,:password,:password_confirmation)
  end

  def show
    id = params[:id]
    unless current_user?(id)
      flash[:warning] = "Can only show profile of logged-in user"
    end
  end

  def index
    # render 'index' template
  end

  def new
    # default: render 'new' template
  end

  def create
    # left empty
  end

  def edit
    # render 'edit'
  end

  def update
    # update product
  end

  def destroy
    # destroy user
  end

  def purchase
    @user_purchases = Purchase.where(user_id: @current_user.id)
  end
end