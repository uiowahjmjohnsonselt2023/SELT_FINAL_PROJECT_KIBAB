## Project Summary
A basic application that allows a user to buy and sell things which will accrue a commission for the company supplying the service when a product is purchased. Users should be able to either buy or sell without being restricted to a specific role.

Upon opening the application the user should see the home screen of the website which will display the basic functionality of the search tool. This should include typing a basic search term (ie socks) which once entered will explore items that are a direct match to the key term the user typed. Products will be displayed according to the most recent product being sold. The user which is currently not logged in should have access to filtering products based on categories or potentially locations of items. Items will be categorized according to general usage including Home, Entertainment, Clothing, Personal Care, and Office. Selecting a product opens a product page which will display information stored regarding that product. This will include an image of the product, a basic description of the item, a location for the seller, and the price of the item. The user can buy a product, by selecting the product to put it in their cart and selecting buy cart. When the user opens the buy cart menu, the user can put in their shipping information, their credit card information and any other required information to complete the purchase. The user should be able to select what form of shipping they would like to utilize and the application should automatically calculate the required amount for shipping costs.

New users that want further functionality as buyers or to have seller functionality should be expected to initially create a new user profile including a username, and password. The user will then be required to re-login to confirm that the user has created an account successfully. If successful, then have access to either a buy mode or sell mode which will be more tailored to a user. The buy mode will act similarly to the buy mode when not logged in but may include things such as stored payment methods, shipping addresses, etc. The user will also have access to their purchase history to see previously bought items. The user can use their user profile page to select links regarding selling items including the link to sell a new item or to view the items they are currently selling.

## Cloning Instructions
**Make sure to cd into the directory before cloning**\
git init\
git add .\
git commit -m "first commit"\
git branch -M main\
git remote add origin https://github.com/uiowahjmjohnsonselt2023/SELT_FINAL_PROJECT_KIBAB \
git push -u origin main

## Bundling Instructions
**Make sure to run 'bundle install --without production'**\
Check to make sure you have bundler 1.17.3 with 'bundler -v'\
If it isn't the right version, run 'gem uninstall bundler', followed by 'gem install bundler -v 1.17.3'\
To switch your Ruby version, run 'rbenv global 2.6.6', and check with 'ruby -v'

## Testing Instructions
Testing gems used for KIBAB-Project include cucumber-rails 2.1.0 (capybara (>= 2.12, < 4) cucumber (>= 3.0.2, < 5)), rails-rspec 4.1.2, simplecov 0.22.0
To test and see full test coverage first run rspec:

    bundle exec rspec spec/
    
Then run cucumber scenarios:

    bundle exec cucumber features/
    
To see coverage, open the coverage folder and find the index.html file within. Open this file in your preferred browser to see all current coverage. SimpleCov also
creates several images to view for seeing more in-depth coverage.

## Heroku App
[KIBAB App](https://glacial-depths-15499-48fc4ab6a25b.herokuapp.com/)
