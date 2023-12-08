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
RSpec.describe BookmarksController, type: :controller do
  let(:user) { instance_double(User, id: 1) }
  let(:product) { instance_double(Product, id: 1, name: 'Test Product', is_sold: false) }

  before do

    allow(controller).to receive(:set_current_user).and_return(user)
    allow(controller).to receive(:set_current_shopping_cart)
  end

  describe '#index' do
    it 'checks for sold products, removes bookmarks, and assigns current bookmarks' do
      product = Product.create(name: 'test', category: 'SomeCategory', quality: 'SomeQuality', is_sold: false, user_id: 1, product_traffic: 5)
      user = User.create(email: 'test@example.com', name: 'Test User', session_token: 'your_session_token')
      bookmark = Bookmark.create(product_id: product.id, user_id: user.id)
      controller.instance_variable_set(:@current_user, user)
      allow(Bookmark).to receive(:where).with(user_id: user.id).and_return([bookmark])
      allow(bookmark).to receive(:product).and_return(product)
      allow(product).to receive(:is_sold).and_return(true)
      allow(Bookmark).to receive(:destroy).and_return(bookmark.id)
      get :index
      expect(flash[:notice]).to eq("#{product.name} was sold.")
      expect(assigns(:current_bookmarks)).to eq([bookmark])
    end
  end

  describe '#destroy' do
    it 'destroys all bookmarks and redirects to products_path' do
      product = Product.create(name: 'test', category: 'SomeCategory', quality: 'SomeQuality', is_sold: false, user_id: 1, product_traffic: 5)
      user = User.create(email: 'test@example.com', name: 'Test User', session_token: 'your_session_token')
      bookmark = Bookmark.create(product_id: product.id, user_id: user.id)
      allow(Bookmark).to receive(:destroy).and_return(bookmark.id)
      controller.instance_variable_set(:@current_user, user)
      delete :destroy
      expect(response).to redirect_to(products_path)
    end
  end

  describe '#delete_one' do
    it 'destroys a specific bookmark and redirects to view_bookmarks_path' do
      bookmark_id = '1'
      controller.instance_variable_set(:@current_bookmark, bookmark_id)
      allow(Bookmark).to receive(:destroy)

      delete :delete_one, params: { id: bookmark_id }

      expect(flash[:notice]).to eq('Bookmark deleted.')
      expect(response).to redirect_to(view_bookmarks_path)
    end

    it 'handles the case when bookmark_params[:id] is not present' do
      product = Product.create(name: 'test', category: 'SomeCategory', quality: 'SomeQuality', is_sold: false, user_id: 1, product_traffic: 5)
      user = User.create(email: 'test@example.com', name: 'Test User', session_token: 'your_session_token')
      bookmark = Bookmark.create(product_id: product.id, user_id: user.id)
      controller.instance_variable_set(:@current_bookmark, bookmark)
      allow(Bookmark).to receive(:destroy)
      allow(bookmark).to receive(:product).and_return(product)
      delete :delete_one, params: {}

      expect(flash[:notice]).to eq("Could not delete #{product.name}." )
    end
  end
end

