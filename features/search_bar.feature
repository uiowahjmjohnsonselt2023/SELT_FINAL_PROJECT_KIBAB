Feature: display products when search
  As a customer
  So that I can quickly see the products
  I want to see products sorted by name, price, and location
#Categories: Home, Entertainment, Clothing, Personal Care, and Office
#Descriptions: Well Worn, Used, Like New, New
#Assumed shopper is shopping in Iowa City Iowa
#Default same product names, lower price first
  Background: products have been added to database
    Given the following products exist:
      | user_email               | name            | category       | description | price | location              | is_sold? |
      | johnjones@gmail.com      | Shower Curtain  | Home           | Used        | 15.49 | Iowa City Iowa        | false   |
      | johnjones@gmail.com      | Bookshelf       | Home           | Like New    | 89.65 | Chicago Illinois      | false   |
      | johnjones@gmail.com      | Zip-Up Hoodie   | Clothing       | New         | 23.42 | Denver Colorado       | false   |
      | johnjones@gmail.com      | Face Wash       | Personal Care  | New         | 5.00  | Seattle Washington    | false   |
      | johnjones@gmail.com      | Stapler         | Office         | Well Worn   | 7.12  | Kansas City Missouri  | false   |
      | johnjones@gmail.com      | Makeup Brush    | Personal Care  | Like New    | 3.22  | Minneapolis Minnesota | false   |
      | johnjones@gmail.com      | Black Socks     | Clothing       | New         | 1.50  | Iowa City Iowa        | false   |
      | johnjones@gmail.com      | Paper Weight    | Entertainment  | Well Worn   | 8.96  | Miami Florida         | false   |
      | johnjones@gmail.com      | Desk Fan        | Office         | Used        | 23.43 | Austin Texas          | false   |
      | johnjones@gmail.com      | Snap Back Hat   | Clothing       | Used        | 17.44 | Los Angeles California| false   |

    And I am on the Kibab home page
    Then 10 products should exist

  Scenario: looking up a product that doesnt exist
    When I am on the Kibab home page
    And "HW 6 in teams" is in the search bar
    And I press "Search"
    Then I shouldnt see anything

  Scenario: looking up product with same name
    When I am on the Kibab home page
    And "Shower Curtain" is in the search bar
    And No categories have been selected
    And No descriptions have been selected
    And I press "Search"
    Then I should see the following products: Shower Curtain
    And I should see "Shower Curtain" with user_id 0 before "Shower Curtain" with user_id 11
    And I should not see the following products: Zip-up Hoodie, Face Wash, Makeup Brush, Black Socks, Paper Weight, Snap Back Hat, Bookshelf, Stapler, Desk Fan, Shower Mat

  Scenario: looking up product with same name and clicking to sort
    When I am on the Kibab home page
    And "Shower Curtain" is in the search bar
    And No categories have been selected
    And No descriptions have been selected
    And I press "Search"
    And I follow "Price"
    Then I should see the following products: Shower Curtain
    And I should see "Shower Curtain" with user_id 11 before "Shower Curtain" with user_id 0
    And I should not see the following products: Zip-up Hoodie, Face Wash, Makeup Brush, Black Socks, Paper Weight, Snap Back Hat, Bookshelf, Stapler, Desk Fan, Shower Mat

  Scenario: looking up product with multiple cases
    When I am on the Kibab home page
    And "Shower" is in the search bar
    And No categories have been selected
    And No descriptions have been selected
    And I press "Search"
    Then I should see the following products: Shower Curtain, Shower Mat
    And I should see "Shower Curtain" with user_id 0 before "Shower Curtain" with user_id 11
    And I should see "Shower Curtain" with user_id 11 before "Shower Mat" with user_id 10
    And I should not see the following products: Zip-up Hoodie, Face Wash, Makeup Brush, Black Socks, Paper Weight, Snap Back Hat, Bookshelf, Stapler, Desk Fan

  Scenario: looking up products with same name but with a filter
    When I am on the Kibab home page
    And "Shower Curtain" is in the search bar
    And No categories have been selected
    And I check the following descriptions: New
    And I uncheck the following descriptions: Well Worn, Used, Like New
    And I press "Submit"
    And I press "Search"
    Then I should see "Shower Curtain" with user_id 11 before "Shower Curtain" with user_id 0
    And I should not see the following products: Zip-up Hoodie, Face Wash, Makeup Brush, Black Socks, Paper Weight, Snap Back Hat, Bookshelf, Stapler, Desk Fan, Shower Mat

  Scenario: looking up products and a category it does not have
    When I am on the Kibab home page
    And "Desk Fan" is in the search bar
    And I check the following categories: Personal Care
    And I uncheck the following descriptions: Home, Office, Clothing, Entertainment, Other
    And I press "Submit"
    And No descriptions have been selected
    And I press "Search"
    Then I the page should say: "There are no products with that name in the categories/filters selected here are some related products"
    And I should see the following products: Desk Fan
    And I should not see the following products: Zip-up Hoodie, Face Wash, Makeup Brush, Black Socks, Paper Weight, Snap Back Hat, Bookshelf, Stapler, Shower Curtain, Shower Mat

  Scenario: looking up generic product names with a category
    When I am on the Kibab home page
    And "Shower" is in the search bar
    And I check the following categories: Personal Care
    And I uncheck the following descriptions: Home, Office, Clothing, Entertainment, Other
    And I press "Submit"
    And No descriptions have been selected
    And I press "Search"
    Then I should see the following products: Shower Mat
    And I should not see the following products: Zip-up Hoodie, Face Wash, Makeup Brush, Black Socks, Paper Weight, Snap Back Hat, Bookshelf, Stapler, Desk Fan, Shower Curtain









