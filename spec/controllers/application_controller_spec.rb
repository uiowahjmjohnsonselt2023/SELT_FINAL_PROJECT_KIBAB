# require 'spec_helper'
# require 'rails_helper'
#
# if RUBY_VERSION>='2.6.0'
#   if Rails.version < '5'
#     class ActionController::TestResponse < ActionDispatch::TestResponse
#       def recycle!
#         # hack to avoid MonitorMixin double-initialize error:
#         @mon_mutex_owner_object_id = nil
#         @mon_mutex = nil
#         initialize
#       end
#     end
#   else
#     puts "Monkeypatch for ActionController::TestResponse no longer needed"
#   end
# end
#
# describe ApplicationController, type: :controller do
#   # let(:user) { instance_double(User, id:1)}
#   # before do
#   #   allow(User).to receive(:find_by_session_token).and_return(user)
#   #   allow(controller).to receive(:session).and_return({ session_token: 'fake_session_token' })
#   #   #@user = User.create(email: 'test@example.com', name: 'Test User', session_token: 'your_session_token')
#   #   #allow(controller).to receive(:current_user).and_return(@user)
#   #   #session[:session_token] = @user.session_token
#   # end
#
#   describe '#set_current_user' do
#     it 'does not redirect' do
#       allow(User).to receive(:find_by_session_token).and_return(nil)
#       get :set_current_user
#       expect(response).not_to redirect_to(login_path_url)
#     end
#     it 'does redirect' do
#       allow(User).to receive(:find_by_session_token).and_return({ session_token: 'fake_session_token' })
#       controller.send(:set_current_user)
#       expect(response).to redirect_to(login_path_url)
#     end
#   end
# end