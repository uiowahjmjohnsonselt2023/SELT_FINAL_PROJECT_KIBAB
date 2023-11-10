Given /the following users exist/ do |users_table|
  users_table.hashes.each do |user|
    User.create(
      email: user[:email],
      password: user[:password],
      password_confirmation: user[:password_confirmation],
      first_name: user[:first_name],
      last_name: user[:last_name],
      address: user[:address]
    )
  end
end

When /^I have input email "(.*?)" and password "(.*?)"$/ do |email, password|
  visit login_path_url
  fill_in 'Email', :with => email
  fill_in 'Password', :with => password
  click_button 'Sign in'
end

Then /^I should see the user page for "(.*?)" and password "(.*?)"$/ do |email, password|
  visit login_path_url
  fill_in 'Email', :with => email
  fill_in 'Password', :with => password
  click_button 'Sign in'
  @user_id = User.find_by_email(email).user_id
  visit user_path(@user_id)
  expect(page).to have_content("Kailey Mackin")
end

When(/^I am not logged in as: "(.*)"$/) do |email|
  @user = User.find_by_email(email)
  expect(@user).to be_nil
end

Then(/^The following data shall be displayed: (.*)$/) do |user_info|
  user_info.split(', ').each do |user|
    expect(page).to have_content(user)
  end
end

Then /^I should not see the user page for "(.*)" with "(.*)" and password "(.*)"$/ do |email1, email2, password|
  visit login_path_url
  fill_in 'Email', :with => email2
  fill_in 'Password', :with => password
  click_button 'Sign in'
  @user_id = User.find_by_email(email1).user_id
  visit user_path(@user_id)
  expect(page).not_to have_content("John Jones")
end

Then /No data shall be displayed/ do
  expect(page).to have_content("Please Login to view Information")
end

