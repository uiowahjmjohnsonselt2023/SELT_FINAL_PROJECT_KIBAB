require 'spec_helper'
require 'rails_helper'
require 'faker'

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

describe Product do
  describe 'Validations' do
    it 'validates presence of name' do
      product = Product.new(name: nil)
      expect(product).not_to be_valid
      expect(product.errors[:name]).to include("can't be blank")
    end
    it 'validates length of name' do
      product = Product.new(name: 'a' * 51)
      expect(product).not_to be_valid
      expect(product.errors[:name]).to include('is too long (maximum is 50 characters)')
    end
    it 'validates presence of category' do
      product = Product.new(category: nil)
      expect(product).not_to be_valid
      expect(product.errors[:category]).to include("can't be blank")
    end
    it 'validates length of category' do
      product = Product.new(category: 'a' * 51)
      expect(product).not_to be_valid
      expect(product.errors[:category]).to include('is too long (maximum is 50 characters)')
    end
    it 'validates presence of description' do
      product = Product.new(description: nil)
      expect(product).not_to be_valid
      expect(product.errors[:description]).to include("can't be blank")
    end
    it 'validates presence of price' do
      product = Product.new(price: nil)
      expect(product).not_to be_valid
      expect(product.errors[:price]).to include("can't be blank")
    end
    it 'validates correct format of price' do
      VALID_PRICE_REGEX = /\d+()|(.\d\d)/
      product = Product.new(price: "a")
      expect(product).not_to be_valid
      expect(product.errors[:price]).to include("is invalid")
    end
    # it 'validates presence of location' do
    #   product = Product.new(location: nil)
    #   expect(product).not_to be_valid
    #   expect(product.errors[:location]).to include("can't be blank")
    # end
    # it 'validates that everything is present and correct' do
    #   product = Product.new(name: "name", category: 'Home', description: "Item", price: "1.00" )
    #   expect(product).to be_valid
    # end
  end
  describe 'Methods' do
    let(:product) { described_class.new(name: 'Test Product', category: 'Home', quality: "Used", description: 'Product', price: '10.00', city: "Iowa City", state: "Iowa", street_address: '630 S Capitol St', zip: '52240') }
    it 'calculates transaction price when 10 or higher' do
      expect(product.transaction).to eq('8.50')
    end
    it 'validates price format using valid_price?' do
      expect(product.valid_price?).to be_truthy
    end
    it 'validate quality' do
      expect(product.valid_quality?).to be_truthy
    end
    it 'validates address' do
      expect(Product.valid_address("Iowa City", "Iowa", "630 S Capitol St", "52240")).to be_truthy
    end
    it 'validates category' do
      expect(product.valid_category?).to be true
    end
  end

  describe 'Transaction Price' do
    let(:product) { described_class.new(name: 'Test Product', category: 'Home', description: 'Used', price: "9.00") }
    it 'calculates transaction price when 10 or higher' do
      expect(product.transaction).to eq('8.10')
    end
  end

  describe 'Class methods' do
    describe '.filtered_search' do
      it 'returns products based on search, category, and description' do
        products = described_class.filtered_search('Bookshelf', 'Home', 'New')
        expect(products).to be_an(ActiveRecord::Relation)
      end
      it 'returns products based on category' do
        products = described_class.filtered_search('', 'Home', 'None')
        expect(products).to be_an(ActiveRecord::Relation)
      end
      it 'returns products based on description' do
        products = described_class.filtered_search('', 'None', 'New')
        expect(products).to be_an(ActiveRecord::Relation)
      end
      it 'returns products based on category and description' do
        products = described_class.filtered_search('', 'Home', 'New')
        expect(products).to be_an(ActiveRecord::Relation)
      end
      it 'returns products based on search' do
        products = described_class.filtered_search('Bookshelf', 'None', 'None')
        expect(products).to be_an(ActiveRecord::Relation)
      end
      it 'returns products based on search and description' do
        products = described_class.filtered_search('Bookshelf', 'None', 'New')
        expect(products).to be_an(ActiveRecord::Relation)
      end
      it 'returns products based on search and category' do
        products = described_class.filtered_search('Bookshelf', 'Home', 'None')
        expect(products).to be_an(ActiveRecord::Relation)
      end
      # it 'search by a category' do
      #   products = described_class.search_by_category('Home')
      #   expect(products).to be_an(ActiveRecord::Relation)
      # end
      # it 'search by a category nil for code coverage' do
      #   products = described_class.search_by_category(nil)
      #   expect(products).to eq(described_class)
      # end
      it 'create bookmark' do
        user = User.create!({uid: SecureRandom.uuid, provider: 'google', email: Faker::Internet.email, name: Faker::Name.name})
        user2 = User.create!({uid: SecureRandom.uuid, provider: 'google', email: Faker::Internet.email, name: Faker::Name.name})
        product = Product.create!({:user_id => user2.id, :name => "Face Wash", :category => "Personal Care", :quality => "New", :description => "Bought a new one need to get rid of it", :price => "5.00", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :product_traffic => 0})
        products = described_class.add_to_bookmarks(user.id, product.id)
        expect(products).to eq(Bookmark.where(user_id: user.id).first)
      end
    end

    describe '.add_to_shopping_cart' do
      it 'adds a product to the shopping cart for a user' do
        user_id = 1
        product_id = 1
        shopping_cart_item = { :user_id => user_id, :product_id => product_id }
        expect(ShoppingCart).to receive(:create!).with(shopping_cart_item)
        described_class.add_to_shopping_cart(user_id, product_id)
      end
    end
  end

  describe '#set_sold_true' do
    it 'sets is_sold attribute to true and saves the product' do
      product = described_class.new(name: 'Test Product', is_sold: false)
      expect(product.is_sold).to be_falsey
      product.set_sold_true
      expect(product.is_sold).to be_truthy
      # expect(product).to be_persisted # Ensure the product is saved in the database
    end
  end
end