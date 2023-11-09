class UsersController < ApplicationController
  before_filter :set_current_user

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :address,:password,:password_confirmation)
  end

  def show
    id = params[:user_id]
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

end