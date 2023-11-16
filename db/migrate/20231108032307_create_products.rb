class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products, id: false do |t|
      t.primary_key :product_id
      t.references :user, index: true, foreign_key: true
      t.string :name
      t.string :category
      t.string :description
      t.string :price
      t.string :location
      t.boolean :is_sold, default: false
    end
  end
end