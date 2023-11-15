class UsersController < ApplicationController
  # User implementation should be credited to the slides titled "Single Sign-On and Third Party Authentication"
  # presented in class during week of 11/6

  ## Additional documentation
  # Additional tutorial for implementation: https://dev.to/anne46/google-omniauth-in-a-rails-app-36ka
  # Additional implentation strategies: https://github.com/zquestz/omniauth-google-oauth2

  before_filter :set_current_user

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :address,:password,:password_confirmation)
  end

  def show
    id = params[:id]
    if !current_user?(id)
      flash[:warning]="Can only show profile of logged-in user"
    end
  end

  def index
    # render 'index' template
  end

  def new
    # default: render 'new' template
  end

  def create
    @user = User.create(user_params)
    if @user.save
      flash[:notice] = "Sign up successful! Welcome to KIBAB"
      redirect_to users_path
    else
      errors = @user.errors.full_messages
      puts "Validation failed with errors: #{errors.join(', ')}"
      render 'new'
    end

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