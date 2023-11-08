class ProductsController < ApplicationController

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
    redirect_to products_path
  end

  def edit
    # render 'edit'
  end

  def update
    # update product
  end

  def destroy
    # destroy product
  end

end