Feature: display list of products sorted by various criteria

  As a customer
  So that I can quickly view a wide variety of products
  I want to see products sorted by name, price, and location
#Categories: Home, Entertainment, Clothing, Personal Care, and Office
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
  Scenario: looking up a product that doesnt exist
    When I am on the Kibab home page
    And I follow "About"
    Then I am on the Kibab about page
  Scenario: looking up a product that doesnt exist
    When I am on the Kibab home page
    And I follow "Create Account"
    Then I am on the Create Account page
  Scenario: looking up a product that doesnt exist
    When I am on the Kibab home page
    And I follow "Login"
    Then I am on the Kibab login page
