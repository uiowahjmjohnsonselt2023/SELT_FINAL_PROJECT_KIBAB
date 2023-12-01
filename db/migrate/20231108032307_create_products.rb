class CreateProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :products do |t|
      # t.primary_key :product_id
      t.references :user, foreign_key: true
      t.string :name
      t.string :image
      t.string :category
      t.string :description
      t.string :price
      t.string :city
      t.string :state
      t.string :street_address
      t.string :zip
      t.boolean :is_sold, default: false
    end
  end
end