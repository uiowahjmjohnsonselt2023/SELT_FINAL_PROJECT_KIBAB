class ProductsController < ApplicationController
  before_action :set_current_user, only: [:new, :update, :destroy, :edit]

  def product_params
    params.require(:product).permit(:name,:category,:description,:price,:location,:is_sold?)
  end
  def show
    id = params[:id]
    redirect_to 'about'
  end

  def index
    # render 'index' template
  end

  def new
  end

  def create
    @product = Product.create(product_params)
    @product = Product.set_user_email(@current_user.email)
    if @user.save
      flash[:notice] = "Product created successfully!"
      redirect_to products_path
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
    # destroy product
  end

  def about
    # edit later
  end

end