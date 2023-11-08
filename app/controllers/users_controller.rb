class UsersController < ApplicationController
  def show
    id = params[:id]
  end

  def index
    # render 'index' template
  end

  def new
    # default: render 'new' template
  end

  def create
    if @user.valid?
      @user.create()#with stuff
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