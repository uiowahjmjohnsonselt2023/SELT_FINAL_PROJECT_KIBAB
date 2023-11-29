class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :email
      t.string :name
      t.float :wallet, default: 100.0
    end
  end
end