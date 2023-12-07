require 'spec_helper'
require 'rails_helper'

if RUBY_VERSION>='2.6.0'
  if Rails.version < '5'
    class ActionController::TestResponse < ActionDispatch::TestResponse
      def recycle!
        # hack to avoid MonitorMixin double-initialize error:
        @mon_mutex_owner_object_id = nil
        @mon_mutex = nil
        initialize
      end
    end
  else
    puts "Monkeypatch for ActionController::TestResponse no longer needed"
  end
end

describe ProductsController, type: :controller do
  before do
    @user = User.create(email: 'test@example.com', name: 'Test User', session_token: 'your_session_token')
    allow(controller).to receive(:current_user).and_return(@user)
    session[:session_token] = @user.session_token
  end

  describe '#search' do
    it 'returns a successful response' do
      get :search
      expect(response).to be_successful
    end
    it 'calls filtered_search with correct parameters' do
      allow(Product).to receive(:filtered_search).and_return(Product.none)
      get :search, params: { search: 'test', product: {categories: 'SomeCategory', quality: 'SomeQuality'} }
      expect(Product).to have_received(:filtered_search).with('test', 'SomeCategory', 'SomeQuality')
    end
    it 'calls filtered_search nothing in search' do
      allow(Product).to receive(:filtered_search).and_return(Product.none)
      get :search, params: { search: ' ', product: {categories: ' ', quality: ' '} }
      expect(Product).to have_received(:filtered_search).twice.with('', 'None', 'None')
    end
    it 'calls filtered_search with only category filled' do
      allow(Product).to receive(:filtered_search).and_return(Product.none)
      get :search, params: { search: '', product: {categories: 'SomeCategory', quality: ''} }
      expect(Product).to have_received(:filtered_search).with('', 'SomeCategory', 'None')
    end
    it 'calls filtered_search with only quality filled' do
      allow(Product).to receive(:filtered_search).and_return(Product.none)
      get :search, params: { search: '', product: {categories: '', quality: 'SomeQuality'} }
      expect(Product).to have_received(:filtered_search).with('', 'None', 'SomeQuality')
    end
    it 'calls filtered_search with only search filled' do
      allow(Product).to receive(:filtered_search).and_return(Product.none)
      get :search, params: { search: 'test', product: {categories: '', quality: ''} }
      expect(Product).to have_received(:filtered_search).twice.with('test', 'None', 'None')
    end
    it 'should select the search results template for rendering' do
      allow(Product).to receive(:filtered_search).and_return(Product.none)
      post :search, params: { search: 'test', product: {categories: 'SomeCategory', quality: 'SomeQuality'} }
      expect(response).to render_template('products/search')
      #expect(response).to render_template('layouts/application')
    end
    it 'calls filtered_search with correct parameters' do
      product1 = Product.create(name: 'test', category: 'SomeCategory', quality: 'SomeQuality')
      allow(Product).to receive(:filtered_search).and_return(Product.where(id: product1.id))
      get :search, params: { search: 'test', product: { categories: 'SomeCategory', quality: 'SomeQuality' } }
      expect(assigns(:products).to_a).to eq(Product.where(id: product1.id).to_a)
    end
  end
  describe '#index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
    it 'gets values' do
      product2 = Product.create(name: 'test', category: 'SomeCategory', quality: 'SomeQuality',is_sold: false, user_id: @user.id, product_traffic: 5)
      get :index
      expect(assigns(:products).to_a).to eq(Product.where(id: product2.id).to_a)
    end
    it 'calls sorting' do
      expect(controller).to receive(:sorting)
      get :index
    end
  end
  describe '#new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end
  end
  describe '#create' do
    context 'with valid parameters' do
      it 'creates a new product' do
        allow(controller).to receive(:render)
        allow_any_instance_of(ProductsController).to receive(:check_address).and_return({ lat: 0.0, long: 0.0 })
        allow(Product).to receive(:valid_address).and_return(true)
        expect {
          post :create, params: { product: { name: 'New Product', price: 19.99 , category: 'None', quality: 'None', description: 'none'} }
        }.to change(Product, :count).by(1)
      end
      it 'redirects to the products index page' do
        allow(controller).to receive(:render)
        allow_any_instance_of(ProductsController).to receive(:check_address).and_return({ lat: 0.0, long: 0.0 })
        post :create, params: { product: { name: 'New Product', price: 19.99 , category: 'None', quality: 'None', description: 'none'} }
        expect(response).to redirect_to(products_path)
      end
    end
    context 'with invalid parameters' do
      it 'does not create a new product' do
        allow(controller).to receive(:render)
        allow_any_instance_of(ProductsController).to receive(:check_address).and_return({ lat: 0.0, long: 0.0 })
        expect {
          post :create, params: { product: { name: nil, price: 19.99 , category: 'None', quality: 'None', description: 'none'} }
        }.to_not change(Product, :count)
      end

      it 'renders the new template' do
        allow(controller).to receive(:render)
        allow_any_instance_of(ProductsController).to receive(:check_address).and_return({ lat: 0.0, long: 0.0 })
        post :create, params: { product: { name: nil, price: 19.99 , category: 'None'} }
        expect(response).to render_template(nil)
      end
      it 'Error from smarty streets' do
        allow(controller).to receive(:render)
        allow_any_instance_of(ProductsController).to receive(:check_address).and_return("Test")
        post :create, params: { product: { name: nil, price: 19.99 } }
        expect(flash[:notice]).to eq("Error Test")
        expect(response).to render_template(nil)
      end
      it 'Address validation error' do
        allow(controller).to receive(:render)
        allow_any_instance_of(ProductsController).to receive(:check_address).and_return(false)
        post :create, params: { product: { name: nil, price: 19.99 } }
        expect(flash[:notice]).to eq("Address validation failed error")
        expect(response).to render_template(nil)
      end
    end
  end
  describe '#show' do
    it 'Sets current product increments traffic, and sets user review' do
      product3 = Product.create(name: 'test', category: 'SomeCategory', quality: 'SomeQuality',is_sold: false, user_id: @user.id, product_traffic: 5)
      product3.id = 1
      allow(Product).to receive(:find_by_id).with(product3.id.to_s).and_return(product3)
      expect(product3).to receive(:increment!).with(:product_traffic)

      # Stub the where method on SellerReview to return an empty relation
      allow(SellerReview).to receive(:where).and_return(SellerReview.none)

      get :show, params: { id: product3.id }

      expect(assigns(:current_product)).to eq(product3)
      expect(assigns(:seller_reviews)).to eq(SellerReview.none)
    end
  end
  describe '#edit' do
    it 'sets current product' do
      product4 = Product.create(name: 'test', category: 'SomeCategory', quality: 'SomeQuality',is_sold: false, user_id: 1, product_traffic: 5)
      product4.id = 1
      @user.id = 1
      allow(Product).to receive(:find_by_id).with(product4.id.to_s).and_return(product4)
      get :edit, params: { id: product4.id }
      expect(assigns(:current_product)).to eq(product4)
    end
    it 'sends flash and redirects' do
      product5 = Product.create(name: 'test', category: 'SomeCategory', quality: 'SomeQuality',is_sold: false, user_id: User.create(email: 'test@example.com', name: 'Test User', session_token: 'your_session_token').id, product_traffic: 5)
      product5.id = 1
      allow(Product).to receive(:find_by_id).with(product5.id.to_s).and_return(product5)
      get :edit, params: { id: product5.id }
      expect(flash[:notice]).to eq("This is not a product you are selling")
      expect(response).to redirect_to(product_path(product5.id))
    end
  end
  describe '#update' do
    it 'Sets product updates and send flash' do
      product6 = Product.create(name: 'test', category: 'SomeCategory', quality: 'SomeQuality', is_sold: false, user_id: @user.id, product_traffic: 5)
      product6.id = 1
      allow(Product).to receive(:find_by_id).with(product6.id.to_s).and_return(product6)
      allow(product6).to receive(:update).and_return(true)
      get :update, params: { id: product6.id, product: { name: 'New Name', category: 'New Category' } }
      expect(flash[:notice]).to eq("Product was updated successfully.")
      expect(response).to redirect_to(products_path)
    end
  end
  describe '#destroy' do
    it 'destroys the product' do
      product = Product.create(name: 'test', category: 'SomeCategory', quality: 'SomeQuality', is_sold: false, user_id: @user.id, product_traffic: 5)
      product.id = 1
      allow(Product).to receive(:find_by_id).with(product.id.to_s).and_return(product)
      expect(product).to receive(:destroy!)
      delete :destroy, params: {id: product.id}
      expect(response).to have_http_status(:no_content)
    end
  end
  describe '#transaction' do
    it 'finds the current product and adds to shopping cart' do
      product = Product.create(name: 'test', category: 'SomeCategory', quality: 'SomeQuality', is_sold: false, user_id: @user.id, product_traffic: 5)
      product.id = 1
      allow(Product).to receive(:find_by_id).with(product.id.to_s).and_return(product)
      allow(Product).to receive(:add_to_shopping_cart).with(@user.id, product.id)
      get :transaction,  params: {id: product.id}
      expect(flash[:notice]).to eq("#{product.name} was added to your shopping cart.")
      expect(response).to redirect_to(products_path)
    end
  end
  describe '#add_shopping_cart' do
    it'adds items to cart if there are items' do
      product = Product.create(name: 'test', category: 'SomeCategory', quality: 'SomeQuality', is_sold: false, user_id: @user.id, product_traffic: 5)
      product.id = 1
      expect(Product).to receive(:add_to_shopping_cart).with(@user.id,'user_id')
      post :add_shopping_cart, params:{products:{user_id: @user.id}}
      expect(flash[:notice]).to eq("Product(s) were successfully added to your shopping cart.")
      expect(response).to redirect_to(products_path)
    end
    it'wont add anything to cart' do
      product = Product.create(name: 'test', category: 'SomeCategory', quality: 'SomeQuality', is_sold: false, user_id: @user.id, product_traffic: 5, price:12,description:"none")
      expect(product).to be_valid
      post :add_shopping_cart, params: nil
      expect(response).to redirect_to(products_path)
    end
  end
  describe '#add_bookmarks' do
    it'adds items to cart if there are items' do
      product = Product.create(name: 'test', category: 'SomeCategory', quality: 'SomeQuality', is_sold: false, user_id: @user.id, product_traffic: 5)
      product.id = 1
      expect(Product).to receive(:add_to_bookmarks).with(@user.id,'user_id')
      post :add_bookmarks, params:{products:{user_id: @user.id}}
      expect(flash[:notice]).to eq("Product(s) were successfully added to bookmarks.")
      expect(response).to redirect_to(products_path)
    end
    it'wont add anything to cart' do
      product = Product.create(name: 'test', category: 'SomeCategory', quality: 'SomeQuality', is_sold: false, user_id: @user.id, product_traffic: 5, price:12,description:"none")
      expect(product).to be_valid
      post :add_bookmarks, params: nil
      expect(response).to redirect_to(products_path)
    end
  end
  describe '#bookmark_from_product' do
    it 'returns a successful response' do
      get :bookmark_from_product
      expect(response).to be_successful
    end
  end
  # describe '#bookmark_from_product' do
  #   it 'add a bookmark' do
  #     @current_product = Product.create(name: 'test', category: 'SomeCategory', quality: 'SomeQuality', is_sold: false, user_id: 12, product_traffic: 5, price: 12, description: "none")
  #     @current_product.id = 1
  #
  #     puts("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!#{@current_product.id}")
  #
  #     post :bookmark_from_product, params: { products:{user_id: @user.id ,product_id: @current_product.id}  }
  #
  #     allow(Product).to receive(:add_to_bookmarks).with(@user.id, @current_product.id)
  #     expect(flash[:notice]).to eq("#{@current_product.name} was added to your bookmarks.")
  #     expect(response).to redirect_to(products_path)
  #   end
  # end
  describe 'POST #add_review' do
    it 'adds a review when parameters are valid' do
      @user = User.create(name: 'Test User', email:"test@test.com")
      valid_params = {
        review_id: @user.id,
        seller_review: {
          name: @user.name,
          review: 'test',
          rating: 5
        }
      }

      post :add_review, params: valid_params
      expect(response).to redirect_to(purchase_history_path_path)
      expect(flash[:notice]).to eq('Review successfully added')
      expect(SellerReview.count).to eq(1)
      expect(SellerReview.first.user_id).to eq(valid_params[:review_id])
      expect(SellerReview.first.name).to eq(@user.name)
      expect(SellerReview.first.review).to eq(valid_params[:seller_review][:review])
      expect(SellerReview.first.rating).to eq(valid_params[:seller_review][:rating])
    end

    it 'renders new_seller_review_path when parameters are missing' do
      @user = User.create(name: 'Test User', email:"test@test.com")
      missing_params = {
      }

      post :add_review, params: missing_params
      expect(flash[:notice]).to eq('Missing required field')
      expect(SellerReview.count).to eq(0)
    end
  end
end
