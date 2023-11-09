Feature: display individual users information on their page

  As a customer
  So that I can see my infomation
  I want to see my first and last name, email, and address displayed on my page
#Categories: Home, Entertainment, Clothing, Personal Care, and Office
#Descriptions: Well Worn, Used, Like New, New
#Assumed shopper is shopping in Iowa City Iowa
  Background: products have been added to database
    Given the following products exist:
      | user_id| email                   | password hash  | first name | last name | address               |
      | 0      | johnjones@gmail.com     | password       | John       | Jones     | Iowa City Iowa        |
      | 1      | iankuk@yahoo.com        | password       | Ian        | Kuk       | Chicago Illinois      |
      | 2      | brandoncano@hotmail.com | password       | Brandon    | Cano      | Denver Colorado       |
      | 3      | angelozamba@aol.com     | password       | Angelo     | Zamba     | Seattle Washington    |
      | 4      | brendansuttor@yahoo.com | password       | Brendan    | Suttor    | Kansas City Missouri  |
      | 5      | kaileymackin@gmail.com  | password       | Kailey     | Mackin    | Minneapolis Minnesota |
      | 6      | megantaylor@yahoo.com   | password       | Megan      | Taylor    | Iowa City Iowa        |
      | 7      | jennamarbles@hotmail.com| password       | Jenna      | Marbles   | Miami Florida         |
      | 8      | aricberryhill@yahoo.com | password       | Aric       | Berryhill |  Austin Texas         |
      | 9      | tiffanitatcher@aol.com  | password       | Tiffani    | Tatcher   | Los Angeles California|

    And I am on the Kibab home page
    Then 10 products should exist