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

describe Purchase do
  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:product) }
  end
  it 'valid address' do
    expect(Purchase.valid_address("Iowa City", "Iowa", "630 S Capitol St", "52240")).to be_truthy
  end
end
