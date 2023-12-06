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

describe ApplicationRecord do
  it 'is an abstract class' do
    expect(ApplicationRecord.abstract_class).to be(true)
  end

  it 'has a .primary_key method defined' do
    expect(ApplicationRecord).to respond_to(:primary_key)
  end
end

