class CreatePurchases < ActiveRecord::Migration[7.1]
  def change
    create_table :purchases do |t|
      t.references :user, index: true, foreign_key: true
      t.references :product, foreign_key: true
      t.datetime :purchase_timestamp

      t.timestamps null: false
    end
  end
end
