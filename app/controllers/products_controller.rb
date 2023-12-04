class ProductsController < ApplicationController
  before_action :set_current_user

  def product_params
    params.require(:product).permit(:name,:image,:category,:quality,:description,:price,:street_address,:state,:city,:zip,:is_sold,:seller_review,:review_id)
  end
  def show
    id = params[:id]
    @current_product = Product.find_by_id(id)
    @seller_reviews = SellerReview.where(user_id: @current_product.user_id)
  end

  def index
    @products = Product.where(is_sold: false).where.not(user_id: @current_user.id)
    sorting
  end

  def search
    if params[:search].present? && !params[:search].blank? && params[:product][:categories].present? && params[:product][:quality].present?
      @products = Product.filtered_search(params[:search],params[:product][:categories], params[:product][:quality]).where(is_sold: false)
    elsif params[:search] == "" && params[:product][:categories].present? && params[:product][:quality].present?
      @products = Product.filtered_search('',params[:product][:categories], params[:product][:quality]).where(is_sold: false)
    end
    if !@products.present?
      if params[:search] == "" && params[:product][:categories]== 'None'&& params[:product][:quality]=='None'
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
    if check_address == true
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
    elsif @lookup.is_a?(String)
      flash[:notice]= "Error " + @lookup
      render 'new'
    else
      flash[:notice]= "Address validation failed error"
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
    if params[:product] && params[:product][:quality].present? && params[:product][:quality] != 'None'
      @products = @products.where(quality: params[:product][:quality])
    end
    @products = @products.where(is_sold: false).where.not(user_id: @current_user.id)
  end

  def add_bookmarks
    if params[:products] != nil
      params[:products].keys.each do |id|
        Product::add_to_bookmarks(@current_user.id, id)
      end
      flash[:notice] = "Product(s) were successfully added to bookmarks."
    else
      flash[:warning] = "No products were selected"
    end
    redirect_to products_path
  end

  def bookmark_from_product
    @current_product = Product.find_by_id(params[:id])
    Product::add_to_bookmarks(@current_user.id, @current_product.id)
    flash[:notice] = "#{@current_product.name} was added to your shopping cart."
    redirect_to products_path
  end

  def add_review
    if params[:seller_review] != nil
      SellerReview.create!(user_id: params[:review_id], name: @current_user.name, review: params[:seller_review][:review], rating: params[:seller_review][:rating])
      flash[:notice] = "Review successfully added"
      redirect_to purchase_history_path_path
    else
      flash[:notice] = "Missing required field"
      render new_seller_review_path
    end
  end

  def check_address
    if product_params[:city] != nil && product_params[:state] != nil && product_params[:street_address] != nil && product_params[:zip] != nil
      @lookup = Product.valid_address(product_params[:city],product_params[:state],product_params[:street_address],product_params[:zip])
      if @lookup.is_a?(String)
        return @lookup
      elsif @lookup == true
        return true
      else
        false
      end
    else
      render new_products_path
    end

  end
end