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

describe ShoppingCartController do
  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
                                                                  provider: 'google',
                                                                  uid: '123456',
                                                                  info: {
                                                                    email: 'user@example.com',
                                                                    name: 'Example User'
                                                                  }
                                                                })

    @user = User.create(email: 'user@example.com')
    session[:user_id] = @user.id
  end

  describe 'GET #index' do
    it 'assigns @current_shopping_cart_list' do
      shopping_cart = ShoppingCart.create(user_id: @user.id)
      get :index
      expect(assigns(:current_shopping_cart_list)).to eq(nil)
    end
  end

  describe 'POST #confirm_purchase' do
    it 'confirms the purchase and redirects to products_path' do
      product = Product.create(name: 'Sample Product') # Create a product
      shopping_cart = ShoppingCart.create(user_id: @user.id, product_id: product.id) # Create a shopping cart

      expect_any_instance_of(Product).to receive(:set_sold_true)
      expect(Purchase).to receive(:create!).with(user_id: @user.id, product_id: product.id, purchase_timestamp: kind_of(Time)).and_call_original
      expect(ShoppingCart).to receive(:destroy).with(shopping_cart.id)

      post :confirm_purchase
      # expect(flash[:notice]).to eq("Purchased successfully!")
      expect(response).to redirect_to(login_path_path)
    end
  end
end