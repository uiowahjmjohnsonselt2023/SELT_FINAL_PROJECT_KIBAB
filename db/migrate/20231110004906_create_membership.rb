class CreateMembership < ActiveRecord::Migration
  def change
    create_table :products_users, id: false do |t|
      t.belongs_to :user
      t.belongs_to :product
    end
  end
end
