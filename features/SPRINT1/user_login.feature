Feature: display individual users information on their page

  As a customer
  So that I can see my infomation
  I want to see my first and last name, email, and address displayed on my page
#Categories: Home, Entertainment, Clothing, Personal Care, and Office
#Descriptions: Well Worn, Used, Like New, New
#Assumed shopper is shopping in Iowa City Iowa
  Background: products have been added to database
    Given the following users exist:
      | email                   | password | password_confirmation | first_name | last_name | address                                       |
      | johnjones@gmail.com     | password | password              | John       | Jones     | 7486 West Blackburn Court, Cheshire CT, 06410 |
      | iankuk@yahoo.com        | password | password              | Ian        | Kuk       | 70 Meadowbrook Street, Ashburn VA, 20147      |
      | brandoncano@hotmail.com | password | password              | Brandon    | Cano      | 101 Valley Farms Avenue, New Bern NC, 28560   |
      | angelozamba@aol.com     | password | password              | Angelo     | Zamba     | 1 Pilgrim Lane, Ringgold GA, 30736            |
      | brendansuttor@yahoo.com | password | password              | Brendan    | Suttor    | 56 Atlantic Street, Muncie IN, 47302          |
      | kaileymackin@gmail.com  | password | password              | Kailey     | Mackin    | 879 East Ryan Court, Nashville TN, 37205      |
      | megantaylor@yahoo.com   | password | password              | Megan      | Taylor    | 797 Plymouth Drive, Yonkers NY, 10701         |
      | jennamarbles@hotmail.com| password | password              | Jenna      | Marbles   | 998 Marconi Court, Spring Valley NY, 10977    |
      | aricberryhill@yahoo.com | password | password              | Aric       | Berryhill | 7635 Fairground Avenue, Hollis NY, 11423      |
      | tiffanitatcher@aol.com  | password | password              | Tiffani    | Tatcher   | 42 Clark Street, Little Falls NJ, 07424       |

Scenario: I should be able to log in
  And I am on the Kibab login page
  And I have input email "kaileymackin@gmail.com" and password "password"
  Then I should see the user page for "kaileymackin@gmail.com" and password "password"

Scenario: I should be not be able to see other user information
  And I am on the Kibab login page
  And I have input email "kaileymackin@gmail.com" and password "password"
  Then I should not see the user page for "johnjones@gmail.com" with "kaileymackin@gmail.com" and password "password"