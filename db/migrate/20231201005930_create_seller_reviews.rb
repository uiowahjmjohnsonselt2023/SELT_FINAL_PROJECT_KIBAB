class CreateSellerReviews < ActiveRecord::Migration[7.1]
  def change
    create_table :seller_reviews do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :review
      t.float :rating
      t.timestamps
    end
  end
end
