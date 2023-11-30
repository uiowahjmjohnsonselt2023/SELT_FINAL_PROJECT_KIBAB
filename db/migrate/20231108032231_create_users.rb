class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :email
      t.string :name
    end
  end
end