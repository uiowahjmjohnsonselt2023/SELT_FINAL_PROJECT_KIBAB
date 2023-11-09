class AddSellerIdToProducts < ActiveRecord::Migration
  def change
    # Adds a seller_id column to the products table and is set as a foreign key that references the id column in
    # the users table
    add_foreign_key :products, :users, column: :seller_id
  end
end
