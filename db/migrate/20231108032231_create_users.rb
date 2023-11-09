class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users, id: false do |t|
      t.primary_key :user_id
      t.string :email, unique: true
      t.string :password_digest
      t.string :first_name
      t.string :last_name
      t.string :address
    end
  end
end