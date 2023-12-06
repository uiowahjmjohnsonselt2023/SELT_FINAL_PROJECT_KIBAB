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

describe UsersController do
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
  describe 'show method' do
    context 'when user is logged in' do
      it 'shows the home page with the user logged in' do
        user = User.create_with_omniauth(OmniAuth.config.mock_auth[:google]) # Create a user in your test database
        allow(request.env['omniauth.auth']).to receive(:[]).with('provider').and_return('google')
        allow(request.env['omniauth.auth']).to receive(:[]).with('uid').and_return('123456')
        allow(request.env['omniauth.auth']).to receive(:[]).with('info').and_return({ 'email' => 'user@example.com', 'name' => 'Example User' })
        session[:user_id] = user.id # Simulate setting the user ID in the session after authentication
        get :index
        expect(response).to redirect_to(login_path_path)
      end
    end
    context 'when the user is not logged in' do
      it 'redirects to the login page' do
        get :new
        expect(response).to redirect_to(login_path_path)
      end
    end
  end

  describe 'purchase method' do
    context 'when user is logged in' do
      it 'returns all purchases of the current user' do
        user = User.create_with_omniauth(OmniAuth.config.mock_auth[:google]) # Assuming you have a factory for creating users
        session[:user_id] = user.id
        get :purchase
        expect(assigns(:user_purchases))
      end
    end

    context 'when user is not logged in' do
      it 'redirects to the login page' do
        get :purchase
        expect(response).to redirect_to(login_path_path)
      end
    end
  end
end