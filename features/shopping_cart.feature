Feature: Have a page that stores all products a customer may want to buy
  As a customer buying products
  So that I can have multiple products I can buy, and so I can save products to buy for later
  I want to have a page that has all the products I want to buy
#Categories: Home, Entertainment, Clothing, Personal Care, Office, and Other
#Descriptions: Well Worn, Used, Like New, New
#Assumed shopper is shopping in Iowa City Iowa
  Background: products have been added to database
    Given the following products exist:
      | user_id| name            | category       | description | price | location              | is_sold |
      | 1      | Shower Curtain  | Home           | Used        | 15.49 | Iowa City Iowa        | false   |
      | 2      | Bookshelf       | Home           | Like New    | 89.65 | Chicago Illinois      | false   |
      | 3      | Zip-Up Hoodie   | Clothing       | New         | 23.42 | Denver Colorado       | false   |
      | 4      | Face Wash       | Personal Care  | New         | 5.00  | Seattle Washington    | false   |
      | 5      | Stapler         | Office         | Well Worn   | 7.12  | Kansas City Missouri  | false   |
      | 6      | Makeup Brush    | Personal Care  | Like New    | 3.22  | Minneapolis Minnesota | false   |
      | 7      | Black Socks     | Clothing       | New         | 1.50  | Iowa City Iowa        | false   |
      | 8      | Paper Weight    | Entertainment  | Well Worn   | 8.96  | Miami Florida         | false   |
      | 9      | Desk Fan        | Office         | Used        | 23.43 | Austin Texas          | false   |
      | 10     | Snap Back Hat   | Clothing       | Used        | 17.44 | Los Angeles California| false   |

    And I am on the Kibab home page
    Then 10 products should exist
  Scenario: add a product to the shopping cart
    Given I am logged in with Google
    When I am on the Kibab home page
    And I should see all the products
    And I select "Shower Curtain"
    And I press "Add Selected Items to Shopping Cart"
    And I press "Shopping Cart"
    And I am on the Shopping Cart Page
    Then I should see the following products: Shower Curtain
  Scenario: add more than one product to the shopping cart
    When I select "Shower Curtain"
    And I select "Black Socks"
    And I press "Add Selected Items to Shopping Cart"
    And I press "Shopping Cart"
    And I am on the Shopping Cart Page
    Then I should see the following products: Shower Curtain, Black Socks
  Scenario: Shopping cart items persist when page is left
    When I select "Shower Curtain"
    And I select "Black Socks"
    And I press "Add Selected Items to Shopping Cart"
    And I press "Shopping Cart"
    And I am on the Shopping Cart Page
    And I press "KIBAB Shop"
    And I am on the Home Page
    And I press "Shopping Cart"
    And I am on the Shopping Cart Page
    Then I should see the following products: Shower Curtain, Black Socks
  Scenario: User has no items in shopping cart
    When I press "Shopping Cart"
    And I am on the Shopping Cart Page
    Then The page should say: "You have no items in your shopping cart"
  Scenario: User clicks Return to products page
    When I press "Shopping Cart"
    And I am on the Shopping Cart Page
    And I follow "Return to products page"
    Then I am on the home page

#  Scenario: Cannot buy a product if user is not logged in
#    When I add "Shower Curtain" to my shopping cart
#    And I am not logged in
#    Then I am on "the Create Account Page"
#    And The page should say: "You must create an account before you can buy a product"
#  Scenario: User tries to check out
#    When I add "Shower Curtain" to my shopping cart
#    And I press "Shopping Cart"
#    And I am on the Shopping Cart Page
#    And I press "Buy for all products"
#    Then I am on "Checkout Page"