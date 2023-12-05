class AddProductTrafficToProducts < ActiveRecord::Migration[7.1]
  def change
    add_column :products, :product_traffic, :integer
  end
end
