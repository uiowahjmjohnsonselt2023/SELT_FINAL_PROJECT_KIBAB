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

describe ProductsController do
  describe 'searching database' do
    it 'should call the model method that searches database by category'do
      fake_results = [double('product1'), double('product2')]
      expect(Product).to recieve(:search_by_category).with('Home')
        and_return(fake_results)
      post :search_product, {:search_terms => 'Home'}
    end
    it 'should call the model method that searches database by name'do
      fake_results = [double('product1'), double('product2')]
      expect(Product).to recieve(:search_by_name).with('Shower Curtain')
      and_return(fake_results)
      post :search_product, {:search_terms => 'Shower Curtain'}
    end

    it 'should call the model method that searches database by description'do
      fake_results = [double('product1'), double('product2')]
      expect(Product).to recieve(:search_by_category).with('New')
      and_return(fake_results)
      post :search_product, {:search_terms => 'New'}
    end
  end
end

