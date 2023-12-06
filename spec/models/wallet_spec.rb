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

describe Wallet do
  describe 'Associations' do
    it { should belong_to(:user) }
  end
  describe 'check credit card' do
    it 'name does not match' do
      expect(described_class.check_credit('123', '123', '123', '12/2023')).to eq('There was a problem with you name, please only use letters')
    end

    it 'number does not match' do
      expect(described_class.check_credit('John Doe', 'abc', '123', '12/2023')).to eq('There was a problem with you credit card number make sure it is the right length and only includes numbers')
    end

    it 'cvv does not match' do
      expect(described_class.check_credit('John Doe', '1234567890123456', 'abc', '12/2023')).to eq('There was a problems with the cvv make sure it is the right length and only includes numbers')
    end

    it 'date is not present' do
      expect(described_class.check_credit('John Doe', '1234567890123456', '123', '')).to eq('')
    end

    it 'date does not match' do
      expect(described_class.check_credit('John Doe', '1234567890123456', '123', '20/2023')).to eq('Make sure the sure the data follow mm/yyyy format')
    end

    it 'card is expired' do
      expect(described_class.check_credit('John Doe', '1234567890123456', '123', '12/2020')).to eq('Your card cannot be expired')
    end
  end
end