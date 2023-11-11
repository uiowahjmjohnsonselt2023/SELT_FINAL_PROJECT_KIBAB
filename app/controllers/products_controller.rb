class ProductsController < ApplicationController
  before_action :set_current_user, only: [:new, :create, :update, :destroy, :edit]

  def product_params
    params.require(:product).permit(:name,:category,:description,:price,:location,:is_sold?)
  end
  def show
    id = params[:id]
    @current_product = Product.find_by_product_id(id)
    # redirect_to 'about'
  end

  def index
    if params[:search]
      @products = Product.where('name LIKE ?', "%#{params[:search]}%").where(is_sold?: false)
      if @products.blank?
        flash[:notice] = "No products match your search try something else"
      end
    else
      @products = Product.where(is_sold?: false)
    end
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
    @current_product = Product.find_by_product_id(params[:id])
    @current_product.destroy!
  end

  def about
    # edit later
  end

  def transaction
    @current_product = Product.find_by_product_id(params[:id])
    @current_product.save
    Product.update(@current_product.product_id, :is_sold? => true)
    @current_product.transaction
    @current_product.save
    flash[:notice] = "#{@current_product.name} was sold."
    redirect_to products_path
  end

end