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

  describe 'GET #search' do
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
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end
  end
  describe 'GET #new' do
    it 'returns a successful response' do
      get :new
      expect(response).to be_successful
    end
  end
end
