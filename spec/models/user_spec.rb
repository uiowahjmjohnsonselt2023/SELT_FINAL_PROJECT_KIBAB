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

describe User do
  describe "Create simple user" do
    it "should respond to the create method" do
      expect(User).to receive(:create).with({:email => "valid@email.com", :password => "password", :password_confirmation => "password", :first_name => "test", :last_name => "last", :address => "123 WhoKnows Way, North Liberty, IA 52317"})
      User.create({:email => "valid@email.com", :password => "password", :password_confirmation => "password", :first_name => "test", :last_name => "last", :address => "123 WhoKnows Way, North Liberty, IA 52317"})
    end
    it "should create a valid user using the create method" do
      user = User.create({:email => "valid@email.com", :password => "password", :password_confirmation => "password", :first_name => "test", :last_name => "last", :address => "123 WhoKnows Way, North Liberty, IA 52317"})
      expect(user.email).to eq("valid@email.com")
      expect(user.password).to eq("password")
      expect(user.first_name).to eq("test")
      expect(user.last_name).to eq("last")
      expect(user.address).to eq("123 WhoKnows Way, North Liberty, IA 52317")
    end
  end
  describe "New User who hasn't created account to not have a session token" do
    let(:user) { User.new }
      specify { expect(user).to be }
      specify { expect(user.session_token).to be_nil }
  end
  describe "New User who has just created account to have a session token" do
    let(:user) { User.create({:email => "valid@email.com", :password => "password", :password_confirmation => "password", :first_name => "test", :last_name => "last", :address => "123 WhoKnows Way, North Liberty, IA 52317"}) }
    specify { expect(user).to be }
    specify { expect(user.session_token).not_to be_nil }
  end
end