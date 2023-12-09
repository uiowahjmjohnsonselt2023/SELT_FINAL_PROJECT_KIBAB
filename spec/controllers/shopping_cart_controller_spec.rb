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
    it 'checks for sold products, removes bookmarks, and assigns current bookmarks' do
      product = Product.create(name: 'test', category: 'SomeCategory', quality: 'SomeQuality', is_sold: true, user_id: 1, product_traffic: 5)
      #user = User.create(email: 'test@example.com', name: 'Test User', session_token: 'your_session_token')
      shoppingcart = ShoppingCart.create(product_id: product.id, user_id: @user.id)
      controller.instance_variable_set(:@current_user, @user)
      allow(ShoppingCart).to receive(:where).with(user_id: @user.id).and_return([shoppingcart])
      allow(shoppingcart).to receive(:product).and_return(product)
      allow(product).to receive(:is_sold).and_return(true)
      allow(ShoppingCart).to receive(:destroy).and_return(shoppingcart.id)
      get :index
      expect(flash[:notice]).to eq("#{product.name} was sold.")
      expect(assigns(:current_shopping_cart_list)).to eq([shoppingcart])
    end
  end
  describe '#checkout' do
    it 'calculates price correctly' do
      product = Product.create(name: 'test', category: 'SomeCategory', quality: 'SomeQuality', is_sold: true, user_id: 1, product_traffic: 5, price:10.0)
      @cart = ShoppingCart.create(user_id: @user.id, product_id: product.id)
      @wallet = Wallet.create(user_id:@user.id, wallet: 50.0)
      controller.instance_variable_set(:@current_user, @user)
      controller.instance_variable_set(:@wallet, @wallet)
      controller.instance_variable_set(:@current_shopping_cart_list,@cart )
      allow(@cart).to receive(:product).and_return(product)
      allow(product).to receive(:price).and_return(10.0)
      post :checkout
      @user.reload
      @wallet.reload
      expected_price = @cart.product.price - @wallet.wallet
      expected_price = 0 if expected_price.negative?

      expect(assigns(:total_price)).to eq(expected_price)
    end

  end
  describe '#confirm_purchase' do
    let(:valid_params) do
      {
        address: {
          city: 'City',
          state: 'State',
          street_address: 'Street Address',
          zip: '12345'
        },
        credit_card: {
          credit_card_name: 'John Doe',
          credit_card_number: '1111111111111111',
          credit_card_security_num: '111',
          credit_card_expiration: '12/25'
        },
        use_wallet_balance: 'on'
      }
      it 'completes purchase' do

      end
    end


  end
end