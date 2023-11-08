class UsersController < ApplicationController
  # test
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