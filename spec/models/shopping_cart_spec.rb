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

describe ShoppingCart do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:product) }
  end

  describe '.compute_total_price' do
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
    end

    it 'calculates total price without considering wallet' do
      p1 = {:user_id => 1, :name => "Bookshelf", :category => "Home", :quality => "Like New", :description => "Bought a new one need to get rid of it", :price => "89.65", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0}
      p2 = {:user_id => 1, :name => "Shower Curtain", :category => "Home", :quality => "Used", :description => "Bought a new one need to get rid of it", :price => "15.49", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0}
      product1 = Product.create!(p1)
      product2 = Product.create!(p2)
      user = User.create_with_omniauth(OmniAuth.config.mock_auth[:google])
      shopping_cart_list = [ShoppingCart.create!(user_id: user.id, product_id: product1.id), ShoppingCart.create!(user_id: user.id, product_id: product2.id)]

      total_price = ShoppingCart.compute_total_price(shopping_cart_list, 0, false)
      expect(total_price).to eq("105.14")
    end

    it 'calculates total price considering wallet with enough balance' do
      p1 = {:user_id => 1, :name => "Bookshelf", :category => "Home", :quality => "Like New", :description => "Bought a new one need to get rid of it", :price => "89.65", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0}
      p2 = {:user_id => 1, :name => "Shower Curtain", :category => "Home", :quality => "Used", :description => "Bought a new one need to get rid of it", :price => "15.49", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0}
      product1 = Product.create!(p1)
      product2 = Product.create!(p2)
      user = User.create_with_omniauth(OmniAuth.config.mock_auth[:google])
      shopping_cart_list = [ShoppingCart.create!(user_id: user.id, product_id: product1.id), ShoppingCart.create!(user_id: user.id, product_id: product2.id)]

      current_wallet = 60.0
      total_price = ShoppingCart.compute_total_price(shopping_cart_list, current_wallet, true)
      expect(total_price).to eq("45.14")
    end

    it 'calculates total price considering wallet with insufficient balance' do
      p1 = {:user_id => 1, :name => "Bookshelf", :category => "Home", :quality => "Like New", :description => "Bought a new one need to get rid of it", :price => "10.00", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0}
      p2 = {:user_id => 1, :name => "Shower Curtain", :category => "Home", :quality => "Used", :description => "Bought a new one need to get rid of it", :price => "10.00", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0}
      product1 = Product.create!(p1)
      product2 = Product.create!(p2)
      user = User.create_with_omniauth(OmniAuth.config.mock_auth[:google])
      shopping_cart_list = [ShoppingCart.create!(user_id: user.id, product_id: product1.id), ShoppingCart.create!(user_id: user.id, product_id: product2.id)]

      current_wallet = 60.0
      total_price = ShoppingCart.compute_total_price(shopping_cart_list, current_wallet, true)
      expect(total_price).to eq("0.00")
    end
  end

  describe '.update_wallet' do
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
    end
    it 'wallet is less than total price' do
      user = User.create_with_omniauth(OmniAuth.config.mock_auth[:google])
      current_wallet = Wallet.create!(user_id: user.id, wallet: 50.00)
      ShoppingCart.update_wallet(current_wallet, 100.00)
      expect(current_wallet.wallet).to eq(0.00)
    end
    it 'wallet is more than total price' do
      user = User.create_with_omniauth(OmniAuth.config.mock_auth[:google])
      current_wallet = Wallet.create!(user_id: user.id, wallet: 50.00)
      ShoppingCart.update_wallet(current_wallet, 25.00)
      expect(current_wallet.wallet).to eq(25.00)
    end
  end

  describe '.buy_each_shopping_cart_item' do
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
    end
    it 'deleting an item and return its price' do
      user = User.create_with_omniauth(OmniAuth.config.mock_auth[:google])
      p1 = {:user_id => 1, :name => "Bookshelf", :category => "Home", :quality => "Like New", :description => "Bought a new one need to get rid of it", :price => "89.65", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0}
      p2 = {:user_id => 1, :name => "Shower Curtain", :category => "Home", :quality => "Used", :description => "Bought a new one need to get rid of it", :price => "15.49", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0}
      product1 = Product.create!(p1)
      product2 = Product.create!(p2)
      shopping_cart_list = [ShoppingCart.create!(user_id: user.id, product_id: product1.id), ShoppingCart.create!(user_id: user.id, product_id: product2.id)]
      price = ShoppingCart.buy_each_shopping_cart_item(shopping_cart_list.first, user)
      expect(price).to eq(89.65)
    end
  end
end