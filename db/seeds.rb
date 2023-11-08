# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# will add fake data later - Brandon
users = [{:user_id => 0, :email => "", :password_hash => "", :first_name => "", :last_name => "", :address => ""}]
products = [{:product_id => 0, :name => "", :category => "", :description => "", :price => "", :location => "", :is_sold? => true}]