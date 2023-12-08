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
    @user = User.create(email: 'test@example.com', name: 'Test User', session_token: 'your_session_token')
    allow(controller).to receive(:set_current_user).and_return(@user)
    allow(controller).to receive(:set_current_shopping_cart)
  end

  describe '#index' do
    it 'checks for sold products, removes bookmarks, and assigns current bookmarks' do
      product = Product.create(name: 'test', category: 'SomeCategory', quality: 'SomeQuality', is_sold: false, user_id: 1, product_traffic: 5)
      bookmark = Bookmark.create(user_id: @user.id, product_id: product.id)
      allow(bookmark).to receive(:with).with(user_id: @user.id).and_return(bookmark)
      allow(bookmark).to receive(:each).and_return(product)
      allow(product).to receive(:is_sold).and_return(true)
      expect(flash[:notice]).to eq("#{product.name} was sold.")
      expect(assigns(:current_bookmarks)).to eq([])
    end
  end

  describe '#destroy' do
    it 'destroys all bookmarks and redirects to products_path' do
      allow(Bookmark).to receive(:destroy_all)

      delete :destroy

      expect(response).to redirect_to(products_path)
    end
  end

  describe '#delete_one' do
    it 'destroys a specific bookmark and redirects to view_bookmarks_path' do
      bookmark_id = '1'
      allow(bookmark_id).to receive(:permit).with(:id).and_return('id' => '1')
      allow(Bookmark).to receive(:destroy)

      delete :delete_one, params: { id: bookmark_id }

      expect(flash[:notice]).to eq('Bookmark deleted.')
      expect(response).to redirect_to(view_bookmarks_path)
    end

    it 'handles the case when bookmark_params[:id] is not present' do
      allow(bookmark_params).to receive(:permit).with(:id).and_return({})
      allow(Bookmark).to receive(:destroy)

      delete :delete_one

      expect(flash[:notice]).to eq('Could not delete .')
      expect(response).to redirect_to(view_bookmarks_path)
    end
  end
end

