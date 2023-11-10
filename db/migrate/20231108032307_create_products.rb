class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products, id: false do |t|
      t.primary_key :product_id
      t.string :name
      t.string :category
      t.string :description
      t.string :price
      t.string :location
      t.boolean :is_sold?, default: false
      t.string :user_email
    end
  end
end