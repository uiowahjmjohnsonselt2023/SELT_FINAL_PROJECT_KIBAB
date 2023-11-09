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
      expect(Products).to receive(:create).with({:name => "John Doe", :category => "Office", :description => "Like New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
      Products.create({:name => "John Doe", :category => "Office", :description => "Like New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0 })
    end
    it "should create a product using the create method" do
      product = Products.create({:name => "John Doe", :category => "Office", :description => "Like New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
      expect(product.name).to eq("John Doe")
      expect(product.category).to eq("Office")
      expect(product.description).to eq("Line New")
      expect(product.price).to eq("13.50")
      expect(product.location).to eq("123 WhoKnows Way, North Liberty, IA 52317")
      expect(product.is_sold?).to eq(false)
      expect(product.user_id).to eq(0)
    end
  end
  describe "Invalid Product inputs" do
    describe "Invalid price" do
      it "should return false when price is negative" do
        product = Products.create({:name => "John Doe", :category => "Office", :description => "Like New", :price => "-13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
      end
      it "should return false when price is has anything but numbers and/or a period" do
        product = Products.create({:name => "John Doe", :category => "Office", :description => "Like New", :price => "1a3.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
        product = Products.create({:name => "John Doe", :category => "Office", :description => "Like New", :price => "13!50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
        product = Products.create({:name => "John Doe", :category => "Office", :description => "Like New", :price => "13..50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
        product = Products.create({:name => "John Doe", :category => "Office", :description => "Like New", :price => "13.5-0", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
      end

    end
    describe "Invalid Category" do
      it "Isn't one of the listed categories" do
        product = Products.create({:name => "John Doe", :category => "Office", :description => "Hello", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
        product = Products.create({:name => "John Doe", :category => "Office", :description => "42", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
        product = Products.create({:name => "John Doe", :category => "Office", :description => "!!!", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
        product = Products.create({:name => "John Doe", :category => "Office", :description => "Like Pew", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
      end
      it "Has more than one category" do
        product = Products.create({:name => "John Doe", :category => "Office", :description => "Like New New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
        product = Products.create({:name => "John Doe", :category => "Office", :description => "Like New Used", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
        product = Products.create({:name => "John Doe", :category => "Office", :description => "New, Well Worn", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
        product = Products.create({:name => "John Doe", :category => "Office", :description => "New New New New New New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
      end
    end
    describe "Invalid Descriptions" do
      it "Isn't one of the listed Descriptions" do
        product = Products.create({:name => "John Doe", :category => "Jones", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
        product = Products.create({:name => "John Doe", :category => "...!!", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
        product = Products.create({:name => "John Doe", :category => "13456", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
        product = Products.create({:name => "John Doe", :category => "Office!", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
      end
      it "Has more than one description" do
        product = Products.create({:name => "John Doe", :category => "Office Home", :description => "Like New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
        product = Products.create({:name => "John Doe", :category => "Office, Office", :description => "Like New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
        product = Products.create({:name => "John Doe", :category => "Office Office", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
        product = Products.create({:name => "John Doe", :category => "Office, Other Other", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => 0})
        expect(product.valid?).to be false
      end
    end
    describe "Data not matching user database" do
      it 'If user trying to tell doesnt exist in the user database' do
        user = User.create({:email => "valid@email.com", :password => "password", :password_confirmation => "password", :first_name => "test", :last_name => "last", :address => "123 WhoKnows Way, North Liberty, IA 52317"})
        product = Products.new({:name => "John Doe", :category => "Office!", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => user.session_token.to_i + 1})
        expect(User.find_by(session_token: user.session_token)).not_to be_nil
        if product.save
          expect(product.errors[:user_id]).to include("User trying to sell must be in the user database")
        else
          expect(entry).not_to be_persisted
        end
      end
      it 'If user trying to tell doesnt exist in the user database' do
        user = User.create({:email => "valid@email.com", :password => "password", :password_confirmation => "password", :first_name => "test", :last_name => "last", :address => "123 WhoKnows Way, North Liberty, IA 52317"})
        product = Products.new({:name => "John Doe", :category => "Office!", :description => "New", :price => "13.50", :location => "123 WhoKnows Way, North Liberty, IA 52317", :is_sold? => false, :user_id => user.session_token})
        expect(User.find_by(session_token: user.session_token)).not_to be_nil
        if product.save
          expect(product.errors[:name]).to include("User trying to sell must use the name in their account")
        else
          expect(entry).not_to be_persisted
        end
      end
    end
  end
end

