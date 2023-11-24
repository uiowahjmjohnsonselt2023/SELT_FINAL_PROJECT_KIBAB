## Project Summary
A basic application that allows a user to buy and sell things which will accrue a commission for the company supplying the service when a product is purchased. Users should be able to either buy or sell without being restricted to a specific role.

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
[KIBAB App Sprint 1](https://glacial-depths-15499-48fc4ab6a25b.herokuapp.com/)
[KIBAB App Sprint 2](https://shielded-tundra-14985-98ad5af16458.herokuapp.com/)
