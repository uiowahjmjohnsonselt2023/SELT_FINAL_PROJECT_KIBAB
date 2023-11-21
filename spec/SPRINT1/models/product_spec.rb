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
describe Product do
  describe "List a product" do
    it "should respond to the create method" do
      expect(Product).to receive(:create).with({:name => "John Doe", :category => "Office", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
      Product.create({:name => "John Doe", :category => "Office", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
    end
    it "should create a product using the create method" do
      product = Product.create({:name => "John Doe", :category => "Office", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
      expect(product.name).to eq("John Doe")
      expect(product.category).to eq("Office")
      expect(product.description).to eq("New")
      expect(product.price).to eq("13.50")
      expect(product.location).to eq("123 WhoKnows Way, North Liberty, IA 52317")
      expect(product.is_sold).to eq(false)
    end
    it 'If user trying to tell doesnt exist in the user database' do
      user = User.create({:email => "valid@email.com", :password => "password", :password_confirmation => "password", :first_name => "test", :last_name => "last", :address => "123 WhoKnows Way, North Liberty, IA 52317"})
      product = Product.create({:name => "John Doe", :category => "Office", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
      expect(User.find_by(session_token: user.session_token)).not_to be_nil
      product.save
      expect(product).to be_persisted
    end
  end
  describe "Invalid Product inputs" do
    describe "Invalid price" do
      it "should return false when price is negative" do
        product = Product.create({:name => "John Doe", :category => "Office", :description => "New", :price => "-13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_price?).to be false
      end
      it "should return false when price is has anything but numbers and/or a period" do
        product = Product.create({:name => "John Doe", :category => "Office", :description => "New", :price => "1a3.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_price?).to be false
        product = Product.create({:name => "John Doe", :category => "Office", :description => "New", :price => "13!50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_price?).to be false
        product = Product.create({:name => "John Doe", :category => "Office", :description => "New", :price => "13..50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_price?).to be false
        product = Product.create({:name => "John Doe", :category => "Office", :description => "New", :price => "13.5-0", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_price?).to be false
      end

    end
    describe "Invalid Descriptions" do
      it "Isn't one of the listed descriptions" do
        product = Product.create({:name => "John Doe", :category => "Office", :description => "Hello", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_description?).to be false
        product = Product.create({:name => "John Doe", :category => "Office", :description => "42", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_description?).to be false
        product = Product.create({:name => "John Doe", :category => "Office", :description => "!!!", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_description?).to be false
        product = Product.create({:name => "John Doe", :category => "Office", :description => "Like Pew", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_description?).to be false
      end
      it "Has more than one description" do
        product = Product.create({:name => "John Doe", :category => "Office", :description => "Like New, New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_description?).to be false
        product = Product.create({:name => "John Doe", :category => "Office", :description => "Like New, Used", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_description?).to be false
        product = Product.create({:name => "John Doe", :category => "Office", :description => "New, Well Worn", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_description?).to be false
        product = Product.create({:name => "John Doe", :category => "Office", :description => "New, New, New, New, New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_description?).to be false
      end
    end
    describe "Invalid Categories" do
      it "Isn't one of the listed categories" do
        product = Product.create({:name => "John Doe", :category => "Jones", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_category?).to be false
        product = Product.create({:name => "John Doe", :category => "....!", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_category?).to be false
        product = Product.create({:name => "John Doe", :category => "123445", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_category?).to be false
        product = Product.create({:name => "John Doe", :category => "Office!", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_category?).to be false
      end
      it "Has more than one category" do
        product = Product.create({:name => "John Doe", :category => "Office, Home", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_category?).to be false
        product = Product.create({:name => "John Doe", :category => "Office, Office", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_category?).to be false
        product = Product.create({:name => "John Doe", :category => "Office, Office, Office, Office", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_category?).to be false
        product = Product.create({:name => "John Doe", :category => "Office, Home, Home", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_category?).to be false
      end
    end
    describe "Address is invalid" do
      it 'Address has no street label' do
        product = Product.create({:name => "John Doe", :category => "Office", :description => "New", :price => "13.50", :location => "123 WhoKnows, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_address?).to be false
      end
      it 'Address has no number' do
        product = Product.create({:name => "John Doe", :category => "Office", :description => "New", :price => "13.50", :location => "WhoKnows Way, North Liberty, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_address?).to be false
      end
      it 'Address has no city' do
        product = Product.create({:name => "John Doe", :category => "Office", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, IA 52317", :user_email => "valid@email.com"})
        expect(product.valid_address?).to be false
      end
      it 'Address has no state' do
        product = Product.create({:name => "John Doe", :category => "Office", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, 52317", :user_email => "valid@email.com"})
        expect(product.valid_address?).to be false
      end
      it 'Address has no postal code' do
        product = Product.create({:name => "John Doe", :category => "Office", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA", :user_email => "valid@email.com"})
        expect(product.valid_address?).to be false
      end
      it 'Address isnt valid' do
        product = Product.create({:name => "John Doe", :category => "Office", :description => "New", :price => "13.50", :location => "invalid address", :user_email => "valid@email.com"})
        expect(product.valid_address?).to be false
      end
    end
  end
end

