class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      # t.primary_key :product_id
      t.references :user, foreign_key: true
      t.string :name
      t.string :image
      t.string :category
      t.string :description
      t.string :price
      t.string :location
      t.boolean :is_sold, default: false
    end
  end
end