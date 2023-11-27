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
  now = Time.now.to_i
  Time.at(rand((Time.now - 100.days).to_i..Time.now.to_i))
end

users = [
  {:email => "johnjones@gmail.com", :password => "password", :password_confirmation => "password", :first_name => "John", :last_name => "Jones", :address => "7486 West Blackburn Court Cheshire CT 06410"},
  {:email => "iankuk@yahoo.com", :password => "password", :password_confirmation => "password", :first_name => "Ian", :last_name => "Kuk", :address => "70 Meadowbrook Street Ashburn VA 20147"},
  {:email => "brandoncano@hotmail.com", :password => "password", :password_confirmation => "password", :first_name => "Brandon", :last_name => "Cano", :address => "101 Valley Farms Avenue New Bern NC 28560"},
  {:email => "angelozamba@aol.com", :password => "password", :password_confirmation => "password", :first_name => "Angelo", :last_name => "Zamba", :address => "1  Pilgrim Lane Ringgold GA 30736"},
  {:email => "brendansuter@yahoo.com", :password => "password", :password_confirmation => "password", :first_name => "Brendan", :last_name => "Suter", :address => "56 Atlantic Street Muncie IN 47302"},
  {:email => "kaileymackin@gmail.com", :password => "password", :password_confirmation => "password", :first_name => "Kailey", :last_name => "Mackin", :address => "879 East Ryan Court Nashville TN 37205"},
  {:email => "megantaylor@yahoo.com", :password => "password", :password_confirmation => "password", :first_name => :"Megan", :last_name => "Taylor", :address => "797 Plymouth Drive Yonkers NY 10701"},
  {:email => "jennamarbles@hotmail.com", :password => "password", :password_confirmation => "password", :first_name => "Jenna", :last_name => "Marbles", :address => "998 Marconi Court Spring Valley NY 10977"},
]

products = [
  {:user_id => 1, :name => "Bookshelf", :category => "Home", :description => "Like New", :price => "89.65", :location => "Iowa City Iowa"},
  {:user_id => 1, :name => "Shower Curtain", :category => "Home", :description => "Used", :price => "15.49", :location => "Iowa City Iowa"},
  {:user_id => 2, :name => "Face Wash", :category => "Personal Care", :description => "New", :price => "5.00", :location => "Denver Colorado"},
  {:user_id => 2, :name => "Stapler", :category => "Office", :description => "New", :price => "7.12", :location => "Kansas City Missouri"},
  {:user_id => 3, :name => "Makeup Brush", :category => "Personal Care", :description => "Like New", :price => "3.15", :location => "Iowa City Iowa"},
  {:user_id => 4, :name => "Zip Up Hoodie", :category => "Clothing", :description => "Well Worn", :price => "23.32", :location => "Seattle Washington"},
  {:user_id => 4, :name => "TV", :category => "Entertainment", :description => "Like New", :price => "142.24", :location => "Iowa City Iowa"},
  # items that have already been bought
  {:user_id => 2, :name => "Night Stand", :category => "Home", :description => "New", :price => "142.24", :location => "Iowa City Iowa", :is_sold => true},
  {:user_id => 4, :name => "Bowl", :category => "Home", :description => "Like New", :price => "8.40", :location => "Iowa City Iowa", :is_sold => true},
  {:user_id => 1, :name => "Scissors", :category => "Office", :description => "New", :price => "5.24", :location => "Iowa City Iowa", :is_sold => true},
  {:user_id => 3, :name => "Dice", :category => "Entertainment", :description => "Like New", :price => "2.00", :location => "Iowa City Iowa", :is_sold => true},
  {:user_id => 1, :name => "Cup", :category => "Home", :description => "Used", :price => "3.99", :location => "Iowa City Iowa", :is_sold => true},
  {:user_id => 3, :name => "Charger", :category => "Home", :description => "Like New", :price => "8.99", :location => "Iowa City Iowa", :is_sold => true},
  {:user_id => 4, :name => "Monitor", :category => "Office", :description => "Like New", :price => "120.50", :location => "Iowa City Iowa", :is_sold => true},
  {:user_id => 4, :name => "Headphones", :category => "Office", :description => "Like New", :price => "50.00", :location => "Iowa City Iowa", :is_sold => true},
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

# users.each do |user|
#   User.create!(user)
# end

products.each do |product|
  Product.create!([product])
end

purchases.each do |purchase|
  Purchase.create(purchase)
end