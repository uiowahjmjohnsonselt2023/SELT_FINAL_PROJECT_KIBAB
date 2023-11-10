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

Scenario: sort products names alphabetically
  When I follow "name"
  Then I should see "Shower Curtain" before "Stapler"
  And  I should see "Black Socks" before "Makeup Brush"
  And  I should see "Snap Back Hat" before "Stapler"
  And  I should see "Paper Weight" before "Zip-Up Hoodie"
  And  I should see "Desk Fan" before "Face Wash"
  And  I should see "Black Socks" before "Bookshelf"
  And  I should see "Makeup Brush" before "Snap Back Hat"

Scenario: sort product prices in increasing order of price
  When I follow "Price"
  Then I should see "Face Wash" before "Stapler"
  And  I should see "Black Socks" before "Makeup Brush"
  And  I should see "Zip-Up Hoodie" before "Desk Fan"
  And  I should see "Shower Curtain" before "Bookshelf"
  And  I should see "Shower Curtain" before "Snap Back Hat"
  And  I should see "Makeup Brush" before "Paper Weight"
  And  I should see "Stapler" before "Paper Weight"

Scenario: sort products location in increasing order of price
  When I follow "location"
  Then I should see "Shower Curtain" before "Zip-Up Hoodie"
  And I should see "Bookshelf" before "Desk Fan"
  And I should see "Stapler" before "Snap Back Hat"