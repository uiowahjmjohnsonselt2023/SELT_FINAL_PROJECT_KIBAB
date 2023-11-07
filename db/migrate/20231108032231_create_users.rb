class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :user_id
      t.string :email
      t.string :password_hash
      t.string :first_name
      t.string :last_name
      t.string :address
    end
  end
end