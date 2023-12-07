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
    # Create a user instance and set the session token
    @user = User.create(email: 'test@example.com', name: 'Test User', session_token: 'your_session_token')
    allow(controller).to receive(:current_user).and_return(@user)
    session[:session_token] = @user.session_token
  end

  describe 'GET #search' do
    it 'calls filtered_search with correct parameters' do
      allow(Product).to receive(:filtered_search).and_return(Product.none)
      get :search, params: { search: 'test', product: {categories: 'SomeCategory', quality: 'SomeQuality'} }
      expect(Product).to have_received(:filtered_search).with('test', 'SomeCategory', 'SomeQuality')
    end
  end
end

  # describe 'searching database' do
  #   it 'should call the model method that searches database by category'do
  #     fake_results = [double('product1')]
  #     post :search, params: {search: 'Book', product: {category: 'Home', quality: 'None'} }
  #     expect(Product).to receive(:filtered_search).with('Book','Home','None').and_return(fake_results)
  #   end
  #
  #   it 'should select the search results template for rendering' do
  #     allow(Product).to receive(:search_by_category)
  #     post :search_product, {:search_terms => 'Home'}
  #     expect(response).to render_template('search_product')
  #   end
  #
  #   it 'should make product search results available to that template' do
  #     fake_results = [double('product1'), double('product2')]
  #     expect(Product).to receive(:search_by_category).and_return(fake_results)
  #     post :search_product, {:search_terms => 'Home'}
  #     expect(assigns(:products)).to eq(fake_results)
  #   end
  #
  #   it 'should call the model method that searches database by name'do
  #     fake_results = [double('product1'), double('product2')]
  #     expect(Product).to receive(:search_by_name).with('Shower Curtain').and_return(fake_results)
  #     post :search_product, {:search_terms => 'Shower Curtain'}
  #   end
  #
  #   it 'should select the search results template for rendering' do
  #     allow(Product).to receive(:search_by_name)
  #     post :search_product, {:search_terms => 'Shower Curtain'}
  #     expect(response).to render_template('search_product')
  #   end
  #
  #   it 'should make product search results available to that template' do
  #     fake_results = [double('product1'), double('product2')]
  #     expect(Product).to receive(:search_by_name).and_return(fake_results)
  #     post :search_product, {:search_terms => 'Shower Curtain'}
  #     expect(assigns(:products)).to eq(fake_results)
  #   end
  #
  #   it 'should call the model method that searches database by description'do
  #     fake_results = [double('product1'), double('product2')]
  #     expect(Product).to receive(:search_by_description).with('New').and_return(fake_results)
  #     post :search_product, {:search_terms => 'New'}
  #   end
  #
  #   it 'should select the search results template for rendering' do
  #     allow(Product).to receive(:search_by_description)
  #     post :search_product, {:search_terms => 'New'}
  #     expect(response).to render_template('search_product')
  #   end
  #
  #   it 'should make product search results available to that template' do
  #     fake_results = [double('product1'), double('product2')]
  #     expect(Product).to receive(:search_by_description).and_return(fake_results)
  #     post :search_product, {:search_terms => 'New'}
  #     expect(assigns(:products)).to eq(fake_results)
  #   end
  #
  # end
  #
