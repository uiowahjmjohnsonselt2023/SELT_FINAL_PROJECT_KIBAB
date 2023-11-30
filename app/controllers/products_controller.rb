class ProductsController < ApplicationController
  before_action :set_current_user

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
    sorting
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
    sorting
  end

  def new
  end

  def create
    product_parameters = product_params.to_h
    product_parameters[:user_id] = @current_user.id
    @product = Product.create(product_parameters)
    # @product.user_id = @current_user.id
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
    @product.update(product_params)
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
    if params[:products] != nil
      params[:products].keys.each do |id|
        Product::add_to_shopping_cart(@current_user.id, id)
      end
      flash[:notice] = "Product(s) were successfully added to your shopping cart."
    else
      flash[:warning] = "No products were selected"
    end
    redirect_to products_path
  end

  def sorting
    if params[:sort] && params[:direction]
      sort_direction = params[:direction] == 'asc' ? 'desc' : 'asc'
      case params[:sort]
      when 'product_name'
        @products = @products.order("name #{sort_direction}")
      when 'price'
        @products = @products.order(Arel.sql("CAST(price AS float) #{sort_direction}"))
      else
        @products = @products.order("#{params[:sort]} #{sort_direction}")
      end
    end
    if params[:search]
      @products = @products.where('name LIKE ?', "%#{params[:search]}%")
    end
    if params[:product] && params[:product][:categories].present? && params[:product][:categories] != 'None'
      @products = @products.where(category: params[:product][:categories])
    end
    if params[:product] && params[:product][:descriptions].present? && params[:product][:descriptions] != 'None'
      @products = @products.where(description: params[:product][:descriptions])
    end
    @products = @products.where(is_sold: false).where.not(user_id: @current_user.id)
  end

end