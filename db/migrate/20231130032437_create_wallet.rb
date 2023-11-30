class CreateWallet < ActiveRecord::Migration[7.1]
  def change
    create_table :wallets do |t|
      t.references :user, foreign_key: true
      t.float :wallet, default: 100.0
    end
  end
end
