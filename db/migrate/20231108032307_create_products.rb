class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.primary_key :product_id
      t.string :name
      t.string :category
      t.string :description
      t.string :price
      t.string :location
      t.boolean :is_sold?
      t.reference :user, foreign_key: true
    end
  end
end