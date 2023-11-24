class ProductsController < ApplicationController
  before_filter :set_current_user

  def product_params
    params.require(:product).permit(:name,:image,:category,:description,:price,:location,:is_sold)
  end
  def show
    id = params[:id]
    @current_product = Product.find_by_id(id)
    # redirect_to 'about'
  end

  def index
     @products = Product.where(is_sold: false).where.not(user_id: @current_user.id)
  end

  def search
    if params[:search].present? && !params[:search].blank? && params[:product][:categories].present? && params[:product][:descriptions].present?
      @products = Product.filtered_search(params[:search],params[:product][:categories], params[:product][:descriptions]).where(is_sold: false)
    elsif params[:search] == "" && params[:product][:categories].present? && params[:product][:descriptions].present?
      @products = Product.filtered_search('',params[:product][:categories], params[:product][:descriptions]).where(is_sold: false)
    end
    if @products.empty?
      if params[:search] == "" && params[:product][:categories]== 'None'&& params[:product][:descriptions]=='None'
        @products = Product.where(is_sold: false)
      else
        flash[:notice] = "No products match your search here are some close results"
        @products = Product.filtered_search(params[:search],"None", "None").where(is_sold: false)
      end

    end
  end

  def new
  end

  def create
    @product = Product.create(product_params)
    @product.user_id = @current_user.id
    if @product.save
      flash[:notice] = "Product created successfully!"
      redirect_to products_path
    else
      errors = @product.errors.full_messages
      puts "Validation failed with errors: #{errors.join(', ')}"
      render 'new'
    end
  end

  def edit
    id = params[:id]
    product = Product.find_by_id(id)
    if @current_user.id.eql?(product.user_id)
      @current_product = product
    else
      flash[:notice] = "This is not a product you are selling"
      redirect_to product_path(id)
    end
  end

  def update
    id = params[:id]
    @product = Product.find_by_id(id)
    @product.update_attributes!(product_params)
    flash[:notice] = "Product was updated successfully."
    redirect_to products_path
  end

  def destroy
    # destroy product
    @current_product = Product.find_by_id(params[:id])
    @current_product.destroy!
  end

  def about
    # edit later
  end

  def transaction
    @current_product = Product.find_by_id(params[:id])
    Product::add_to_shopping_cart(@current_user.id, @current_product.id)
    flash[:notice] = "#{@current_product.name} was added to your shopping cart."
    redirect_to products_path
  end

  def add_shopping_cart
    if params[:products].nil?
      flash[:notice] = "No products were selected"
      # redirect_to products_path and return
    end
    params[:products].keys.each do |id|
      Product::add_to_shopping_cart(@current_user.id, id)
    end
    flash[:notice] = "Products were successfully added to your shopping cart."
    redirect_to products_path
  end

end