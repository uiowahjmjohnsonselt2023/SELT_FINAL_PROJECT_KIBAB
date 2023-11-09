Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create(
      user_id: product[:user_id],
      email: product[:email],
      password_hash: product[:password_hash],
      first_name: product[:first_name],
      last_name: product[:last_name],
      address: product[:address]
    )
  end
end
Then(/(.*) person should exist/) do |n_users|
  expect(User.count).to eq(n_users.to_i)
end

When(/^I am logged in as: "(.*)"$/) do |email|
  #put login stuff for email here
end
When(/^I am not logged in as: "(.*)"$/) do |email|
  #put login stuff for email here
end

Then(/^The following data shall be displayed: (.*)$/) do |user_info|
  user_info.split(', ').each do |user|
    expect(page).to have_content(user)
  end
end

Then /No data shall be displayed/ do
  expect(page).to have_content("Please Login to view Information")
end
