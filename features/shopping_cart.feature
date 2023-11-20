Feature: Have a page that stores all products a customer may want to buy
  As a customer buying products
  So that I can have multiple products I can buy, and so I can save products to buy for later
  I want to have a page that has all the products I want to buy
#Categories: Home, Entertainment, Clothing, Personal Care, Office, and Other
#Descriptions: Well Worn, Used, Like New, New
#Assumed shopper is shopping in Iowa City Iowa
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
  Scenario: add a product to the shopping cart
    When I add "Shower Curtain" to my shopping cart
    And I press "Shopping Cart"
    And I am on the Shopping Cart Page
    Then I should see the following products: Shower Curtain
  Scenario: add more than one product to the shopping cart
    When I add "Shower Curtain" to my shopping cart
    And I add "Black Socks" to my shopping cart
    And I press "Shopping Cart"
    And I am on the Shopping Cart Page
    Then I should see the following products: Shower Curtain, Black Socks
  Scenario: Shopping cart items persist when page is left
    When I add "Shower Curtain" to my shopping cart
    And I add "Black Socks" to my shopping cart
    And I press "Shopping Cart"
    And I am on the Shopping Cart Page
    And I press "Home"
    And I am on the Home Page
    And I press "Shopping Cart"
    And I am on the Shopping Cart Page
    Then I should see the following products: Shower Curtain, Black Socks
#  Scenario: Cannot buy a product if user is not logged in
#    When I add "Shower Curtain" to my shopping cart
#    And I am not logged in
#    Then I am on "the Create Account Page"
#    And The page should say: "You must create an account before you can buy a product"
  Scenario: User tries to check out
    When I add "Shower Curtain" to my shopping cart
    And I press "Shopping Cart"
    And I am on the Shopping Cart Page
    And I press "Buy for all products"
    Then I am on "Checkout Page"