class ProductsController < ApplicationController
  before_action :set_current_user, only: [:new, :create, :update, :destroy, :edit]

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
    @product.set_user_email(@current_user.email)
    if @product.save
      flash[:notice] = "Product created successfully!"
      redirect_to products_path
    else
      errors = @product.errors.full_messages
      puts "Validation failed with errors: #{errors.join(', ')}"
      # TODO - add warning for invalid price value - Brandon
      render 'new'
    end
  end

  def edit
    # render 'edit'
  end

  def update
    # update product
    # @product.is_sold? = true
    # @product.update
  end

  def destroy
    # destroy product
  end

  def about
    # edit later
  end

end