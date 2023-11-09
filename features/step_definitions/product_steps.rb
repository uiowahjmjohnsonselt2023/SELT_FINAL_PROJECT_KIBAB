
require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))
Given /the following products exist/ do |products_table|
  products_table.hashes.each do |product|
    Product.create(
      user_id: product[:user_id],
      name: product[:name],
      category: product[:category],
      description: product[:description],
      price: product[:price],
      location: product[:location],
      is_sold: product[:is_sold]
    )
  end
end

Then /(.*) products should exist/ do | n_seeds |
  expect(Movie.count).to eq n_seeds.to_i
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  expect(/.*#{e1}.*#{e2}/m).to match page.body
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end
When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end
