
Given /the following products exist:/ do |products_table|
  products_table.hashes.each do |product|
    Products.create(
      user_id: product[:user_id],
      name: product[:name],
      category: product[:category],
      description: product[:description],
      price: product[:price],
      location: product[:location],
      is_sold?: product[:is_sold?]
    )
  end
end

Then /(.*) products should exist/ do | n_seeds |
  expect(Product.count).to eq n_seeds.to_i
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  expect(/.*#{e1}.*#{e2}/m).to match page.body
end

When /I (un)?check the following categories: (.*)/ do |uncheck, categories_list|
  categories_list.split(', ').each do |categorie|
    if uncheck
      uncheck("categories[#{categorie}]")
    else
      check("categories[#{categorie}]")
    end
  end
end

# Part 2, Step 3
Then /^I should (not )?see the following products: (.*)$/ do |no, product_list|
  if no.nil?
    product_list.split(', ').each do |product|
      expect(page).to have_content(product)
    end
  else
    product_list.split(', ').each do |product|
      expect(page).not_to have_content(product)
    end
  end
end

Then /I should see all the products/ do
  Product.all.each do |product|
    expect(page).to have_content(product.title)
  end
end

When /I (un)?check the following descriptions: (.*)/ do |uncheck, descriptions_list|
  descriptions_list.split(', ').each do |description|
    if uncheck
      uncheck("descriptions[#{description}]")
    else
      check("descriptions[#{description}]")
    end
  end
end

Then /^I should (not )?see the following descriptions: (.*)$/ do |no, description_list|
  if no.nil?
    description_list.split(', ').each do |description|
      expect(page).to have_content(description)
    end
  else
    description_list.split(', ').each do |description|
      expect(page).not_to have_content(description)
    end
  end
end


Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link(link)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button(button)
end

When /^(?:|I )check (?:the\s+)?"([^"]*)"(?:\s*checkbox)?$/ do |field|
  check(field)
end

When /^(?:|I )uncheck (?:the\s+)?"([^"]*)"(?:\s*checkbox)?$/ do |field|
  uncheck(field)
end
