# Completed step definitions for basic features: AddMovie, ViewDetails, EditMovie

Given /^I am on the RottenPotatoes home page$/ do
  visit movies_path
end


When /^I have added a movie with title "(.*?)" and rating "(.*?)"$/ do |title, rating|
  visit new_movie_path
  fill_in 'Title', :with => title
  select rating, :from => 'Rating'
  click_button 'Save Changes'
end

Then /^I should see a movie list entry with title "(.*?)" and rating "(.*?)"$/ do |title, rating|
  result=false
  all("tr").each do |tr|
    if tr.has_content?(title) && tr.has_content?(rating)
      result = true
      break
    end
  end
  expect(result).to be_truthy
end

When /^I have visited the Details about "(.*?)" page$/ do |title|
  visit movies_path
  click_on "More about #{title}"
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  expect(page).to have_content(text)
end

When /^I have edited the movie "(.*?)" to change the rating to "(.*?)"$/ do |movie, rating|
  click_on "Edit"
  select rating, :from => 'Rating'
  click_button 'Update Movie Info'
end

Given /the following movies have been added to RottenPotatoes:/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create!(movie)
  end
end

When /^I have opted to see movies rated: "(.*?)"$/ do |arg1|
  ratings = arg1.split(', ')
  ratings.each do |rating|
    check("ratings_#{rating}")
  end
end

Then /^I should see only movies rated: "(.*?)"$/ do |arg1|
  ratings = arg1.split(', ')
  ratings.each do |rating|
    check("ratings_#{rating}")
  end
end
Then /^I should see all of the movies$/ do
  expect(page.all('table#movies tbody tr').length).to eq Movie.count
end
When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end
Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  expect(/[\s\S]*#{e1}[\s\S]*#{e2}/).to match page.body
end
