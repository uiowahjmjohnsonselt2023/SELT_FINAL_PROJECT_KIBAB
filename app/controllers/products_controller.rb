class ProductsController < ApplicationController
  before_filter :set_current_user

  def product_params
    params.require(:product).permit(:name,:image,:category,:description,:price,:location,:is_sold?)
  end
  def show
    id = params[:id]
    @current_product = Product.find_by_id(id)
    # redirect_to 'about'
  end

  def index
    if params[:search]
      @products = Product.where('name LIKE ?', "%#{params[:search]}%").where(is_sold: false)
    else
      @products = Product.where(is_sold: false)
    end
    sorting
    if @products.blank?
      flash[:notice] = "No products match your search try something else"
    end
  end

  def new
  end

  def create
    @product = Product.create(product_params)
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
    id = params[:id]
    @current_product = Product.find_by_id(id)
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
    # find product from db and update is_sold? to true
    @current_product = Product.find_by_id(params[:id])
    @current_product.save
    Product.update(@current_product.id, :is_sold? => true)
    @purchase = Purchase.create(user: @current_user, product: @current_product, purchase_timestamp: Time.now)
    # add to the purchase table with the time which the product was bought
    @current_product.save

    flash[:notice] = "#{@current_product.name} was sold."
    redirect_to products_path
  end

  # STILL NEED TO INTEGRATE WITH SEARCH PARAM
  def sorting
    if params[:sort] && params[:direction]
      sort_direction = params[:direction] == 'asc' ? 'desc' : 'asc'
      case params[:sort]
      when 'price'
        if params[:direction] == 'asc'
          @products = @products.sort_by { |product| product.price.to_f }
        else
          @products = @products.sort_by { |product| product.price.to_f }.reverse
        end
      else
        @products = @products.order("#{params[:sort]} #{sort_direction}")
      end
    end
  end

end