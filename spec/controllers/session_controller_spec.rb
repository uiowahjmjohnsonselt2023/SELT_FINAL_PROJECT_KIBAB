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


RSpec.describe SessionsController, type: :controller do
  let(:user) { instance_double(User, id: 1, session_token: 'fake_session_token') }
  let(:auth_hash) { { 'provider' => 'fake_provider', 'uid' => 'fake_uid' } }

  before do
    allow(controller).to receive(:set_current_user) # Avoid execution of set_current_user in this context
    allow(controller).to receive(:set_current_shopping_cart) # Avoid execution of set_current_shopping_cart in this context
  end

  describe '#new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe '#create' do
    context 'with valid authentication' do
      before do
        allow(request.env['omniauth.auth']).to receive(:[]).with('provider').and_return(auth_hash['provider'])
        allow(request.env['omniauth.auth']).to receive(:[]).with('uid').and_return(auth_hash['uid'])
        allow(User).to receive(:find_by_provider_and_uid).with(auth_hash['provider'], auth_hash['uid']).and_return(user)
        allow(User).to receive(:create_with_omniauth).with(auth_hash).and_return(user)
      end

      it 'sets the session_token and redirects to products_path' do
        post :create, params:{'omniauth.auth' => auth_hash}
        expect(session[:session_token]).to eq('fake_session_token')
        expect(response).to redirect_to(products_path)
      end
    end
  end

  describe '#destroy' do
    it 'clears the session_token, sets current_user to nil, flashes a notice, and redirects to products_path' do
      session[:session_token] = 'fake_session_token'
      allow(controller).to receive(:current_user).and_return(user)

      delete :destroy

      expect(session[:session_token]).to be_nil
      expect(controller.instance_variable_get(:@current_user)).to be_nil
      expect(flash[:notice]).to eq('You have logged out')
      expect(response).to redirect_to(products_path)
    end
  end
end


