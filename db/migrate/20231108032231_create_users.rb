class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.primary_key :user_id
      t.string :email, unique: true
      t.string :password_hash
      t.string :first_name
      t.string :last_name
      t.string :address
    end
  end
end