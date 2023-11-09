class ProductsController < ApplicationController
  before_action :set_current_user, only: [:new, :update, :destroy, :edit]

  def product_params
    params.require(:product).permit(:name,:category,:description,:price,:location,:is_sold?,:user_id,:seller_id)
  end
  def show
    id = params[:id]
    redirect_to 'about'
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

  def about
    # edit later
  end

end