require 'faker'
# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
def get_random_timestamp
  Time.at(rand((Time.now - 100.days).to_i..Time.now.to_i))
end

users = [
  {uid: SecureRandom.uuid, provider: 'google', email: Faker::Internet.email, name: Faker::Name.name},
  {uid: SecureRandom.uuid, provider: 'google', email: Faker::Internet.email, name: Faker::Name.name},
  {uid: SecureRandom.uuid, provider: 'google', email: Faker::Internet.email, name: Faker::Name.name},
  {uid: SecureRandom.uuid, provider: 'google', email: Faker::Internet.email, name: Faker::Name.name},
  {uid: SecureRandom.uuid, provider: 'google', email: Faker::Internet.email, name: Faker::Name.name},
  {uid: SecureRandom.uuid, provider: 'google', email: Faker::Internet.email, name: Faker::Name.name},
  {uid: SecureRandom.uuid, provider: 'google', email: Faker::Internet.email, name: Faker::Name.name},
  {uid: SecureRandom.uuid, provider: 'google', email: Faker::Internet.email, name: Faker::Name.name},
]

products = [
  {:user_id => 1, :name => "Bookshelf", :category => "Home", :quality => "Like New", :description => "Bought a new one need to get rid of it", :price => "89.65", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0},
  {:user_id => 1, :name => "Shower Curtain", :category => "Home", :quality => "Used", :description => "Bought a new one need to get rid of it", :price => "15.49", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0},
  {:user_id => 2, :name => "Face Wash", :category => "Personal Care", :quality => "New", :description => "Bought a new one need to get rid of it", :price => "5.00", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0},
  {:user_id => 2, :name => "Stapler", :category => "Office", :quality => "New", :price => "7.12", :description => "Bought a new one need to get rid of it", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0},
  {:user_id => 3, :name => "Makeup Brush", :category => "Personal Care", :quality => "Like New", :description => "Bought a new one need to get rid of it", :price => "3.15", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0},
  {:user_id => 4, :name => "Zip Up Hoodie", :category => "Clothing", :quality => "Well Worn", :description => "Bought a new one need to get rid of it", :price => "23.32", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0},
  {:user_id => 4, :name => "TV", :category => "Entertainment", :quality => "Like New", :description => "Bought a new one need to get rid of it", :price => "142.24", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0},
  # items that have already been bought
  {:user_id => 2, :name => "Night Stand", :category => "Home", :quality => "New", :description => "Bought a new one need to get rid of it", :price => "142.24", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :lat => 41.61986538321291, :long => -87.84873608867929, :is_sold => true, :product_traffic => 0},
  {:user_id => 4, :name => "Bowl", :category => "Home", :quality => "Like New", :description => "Simple patterned bowl", :price => "8.40", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :is_sold => true, :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0},
  {:user_id => 1, :name => "Scissors", :category => "Office", :quality => "New",:description => "Very dull", :price => "5.24", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :is_sold => true, :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0},
  {:user_id => 3, :name => "Dice", :category => "Entertainment", :quality => "Like New",:description => "Missing some paint", :price => "2.00", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :is_sold => true, :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0},
  {:user_id => 1, :name => "Cup", :category => "Home", :quality => "Used", :description => "Has a small crack", :price => "3.99", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :is_sold => true, :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0},
  {:user_id => 3, :name => "Charger", :category => "Home", :quality => "Like New", :description => "Doesn't work but could be used for parts", :price => "8.99", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :lat => 41.61986538321291, :long => -87.84873608867929, :is_sold => true, :product_traffic => 0},
  {:user_id => 4, :name => "Monitor", :category => "Office", :quality => "Like New",:description => "Just an old monitor", :price => "120.50", :street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :is_sold => true, :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0},
  {:user_id => 4, :name => "Headphones", :category => "Office", :quality => "Like New", :description => "Headphones play sound well.", :price => "50.00",:street_address => "732 Orland Square Dr", :city => "Orland Park", :state => "IL", :zip => "60462", :is_sold => true, :lat => 41.61986538321291, :long => -87.84873608867929, :product_traffic => 0},
]

purchases = [
  {:user_id => 3, :product_id => 8, :purchase_timestamp => get_random_timestamp},
  {:user_id => 3, :product_id => 9, :purchase_timestamp => get_random_timestamp},
  {:user_id => 3, :product_id => 10, :purchase_timestamp => get_random_timestamp},
  {:user_id => 1, :product_id => 11, :purchase_timestamp => get_random_timestamp},
  {:user_id => 1, :product_id => 12, :purchase_timestamp => get_random_timestamp},
  {:user_id => 1, :product_id => 13, :purchase_timestamp => get_random_timestamp},
  {:user_id => 1, :product_id => 14, :purchase_timestamp => get_random_timestamp},
  {:user_id => 4, :product_id => 15, :purchase_timestamp => get_random_timestamp},
]

wallets = [
  {:user_id => 1, wallet: rand(100.0..1000.0)},
  {:user_id => 2, wallet: rand(100.0..1000.0)},
  {:user_id => 3, wallet: rand(100.0..1000.0)},
  {:user_id => 4, wallet: rand(100.0..1000.0)},
  {:user_id => 5, wallet: rand(100.0..1000.0)},
  {:user_id => 6, wallet: rand(100.0..1000.0)},
  {:user_id => 7, wallet: rand(100.0..1000.0)},
  {:user_id => 8, wallet: rand(100.0..1000.0)},
]

seller_reviews = [
  {:user_id => 1, :name => Faker::Name.name, :review => "Good product", :rating => 5.0},
  {:user_id => 1, :name => Faker::Name.name, :review => "Good product", :rating => 4.0},
  {:user_id => 1, :name => Faker::Name.name, :review => "Good product", :rating => 3.0},
  {:user_id => 3, :name => Faker::Name.name, :review => "Good product", :rating => 5.0},
  {:user_id => 4, :name => Faker::Name.name, :review => "Good product", :rating => 3.0},
  {:user_id => 3, :name => Faker::Name.name, :review => "Good product", :rating => 3.0},
  {:user_id => 3, :name => Faker::Name.name, :review => "Good product", :rating => 1.0},
  {:user_id => 1, :name => Faker::Name.name, :review => "Good product", :rating => 4.0},
]

users.each do |user|
  User.create!(user)
end

products.each do |product|
  Product.create!([product])
end

purchases.each do |purchase|
  Purchase.create(purchase)
end

wallets.each do |wallet|
  Wallet.create(wallet)
end

seller_reviews.each do |review|
  SellerReview.create!(review)
end