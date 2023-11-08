class UsersController < ApplicationController
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
    if @user.valid?
      redirect_to users_path
    end
    redirect_to users_path
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