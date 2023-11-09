  Feature: display products filtered by different categories
    As a customer buying products
    So that I can quickly see the products I want
    I want to see products matching my filters
#Categories: Home, Entertainment, Clothing, Personal Care, Office, and Other
#Descriptions: Well Worn, Used, Like New, New
#Assumed shopper is shopping in Iowa City Iowa
  Background: products have been added to database
    Given the following products exist:
    | user_id| name            | category       | description | price | location              | is_sold? |
    | 0      | Shower Curtain  | Home           | Used        | 15.49 | Iowa City Iowa        | False   |
    | 1      | Bookshelf       | Home           | Like New    | 89.65 | Chicago Illinois      | False   |
    | 2      | Zip-Up Hoodie   | Clothing       | New         | 23.42 | Denver Colorado       | False   |
    | 3      | Face Wash       | Personal Care  | New         | 5.00  | Seattle Washington    | False   |
    | 4      | Stapler         | Office         | Well Worn   | 7.12  | Kansas City Missouri  | False   |
    | 5      | Makeup Brush    | Personal Care  | Like New    | 3.22  | Minneapolis Minnesota | False   |
    | 6      | Black Socks     | Clothing       | New         | 1.50  | Iowa City Iowa        | False   |
    | 7      | Paper Weight    | Entertainment  | Well Worn   | 8.96  | Miami Florida         | False   |
    | 8      | Desk Fan        | Office         | Used        | 23.43 | Austin Texas          | False   |
    | 9      | Snap Back Hat   | Clothing       | Used        | 17.44 | Los Angeles California| False   |

    And I am on the Kibab home page
    Then 10 products should exist

  Scenario: restrict to products with "New" or "Like New" description
    When I check the following descriptions: New, Like New
    And I uncheck the following descriptions: Well Worn, Used
    And I press "Submit"
    Then I should see the following products: Bookshelf, Zip-Up Hoodie, Face Wash, Makeup Brush, Black Socks
    And  I should not see the following products: Shower Curtain, Stapler, Paper Weight, Desk Fan, Snap Back Hat

  Scenario: all descriptions selected
    When I check the following descriptions: Well Worn, Used, Like New, New
    And I press "Submit"
    Then I should see all the products

  Scenario: restrict to products with "Home" or "Office" categories
    When I check the following categories: Home, Office
    And I uncheck the following categories: Clothing, Personal Care, Entertainment, Other
    And I press "Submit"
    Then I should see the following products: Shower Curtain, Bookshelf, Stapler, Desk Fan
    And I should not see the following products: Zip-up Hoodie, Face Wash, Makeup Brush, Black Socks, Paper Weight, Snap Back Hat

  Scenario: all categories selected
    When I check the following descriptions: Home, Office, Clothing, Personal Care, Entertainment, Other
    And I press "Submit"
    Then I should see all the products

  Scenario: restrict to products with "Home" categories and with "Like New" description
    When I check the following categories: Home
    And I uncheck the following categories: Clothing, Personal Care, Entertainment, Other, Office
    And I press "Submit"
    And I check the following descriptions: Like New
    And I uncheck the following descriptions: New, Well Worn, Used
    And I press "Submit"
    Then I should see all the products: Bookshelf
    And I should not see the following products: Shower Curtain, Stapler, Desk Fan, Zip-up Hoodie, Face Wash, Makeup Brush, Black Socks, Paper Weight, Snap Back Hat
