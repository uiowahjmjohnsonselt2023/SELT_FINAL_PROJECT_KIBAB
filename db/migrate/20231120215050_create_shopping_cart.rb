class CreateShoppingCart < ActiveRecord::Migration[7.1]
  def change
    create_table :shopping_carts do |t|
      t.references :user, index: true, foreign_key: true
      t.references :product, foreign_key: true
    end
  end
end
