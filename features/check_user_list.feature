Feature: display individual users information on their page

  As a customer
  So that I can see my infomation
  I want to see my first and last name, email, and address displayed on my page
#Categories: Home, Entertainment, Clothing, Personal Care, and Office
#Descriptions: Well Worn, Used, Like New, New
#Assumed shopper is shopping in Iowa City Iowa
  Background: products have been added to database
    Given the following users exist:
      | session_token| email                   | password_digest | first_name | last_name | address                                     |
      | 0            | johnjones@gmail.com     | password        | John       | Jones     | 7486 West Blackburn Court Cheshire CT 06410 |
      | 1            | iankuk@yahoo.com        | password        | Ian        | Kuk       | 70 Meadowbrook Street Ashburn VA 20147      |
      | 2            | brandoncano@hotmail.com | password        | Brandon    | Cano      | 101 Valley Farms Avenue New Bern NC 28560   |
      | 3            | angelozamba@aol.com     | password        | Angelo     | Zamba     | 1 Pilgrim Lane Ringgold GA 30736            |
      | 4            | brendansuttor@yahoo.com | password        | Brendan    | Suttor    | 56 Atlantic Street Muncie IN 47302          |
      | 5            | kaileymackin@gmail.com  | password        | Kailey     | Mackin    | 879 East Ryan Court Nashville TN 37205      |
      | 6            | megantaylor@yahoo.com   | password        | Megan      | Taylor    | 797 Plymouth Drive Yonkers NY 10701         |
      | 7            | jennamarbles@hotmail.com| password        | Jenna      | Marbles   | 998 Marconi Court Spring Valley NY 10977    |
      | 8            | aricberryhill@yahoo.com | password        | Aric       | Berryhill | 7635 Fairground Avenue Hollis NY 11423      |
      | 9            | tiffanitatcher@aol.com  | password        | Tiffani    | Tatcher   | 42 Clark Street Little Falls NJ 07424       |

    And I am on the Kibab user page
    And I am logged in as: "kaileymackin@gmail.com"
    Then 1 person should exist

  Scenario: comparing user information when logged in as specific user
    When I am on the Kibab user page
    And I am logged in as: "iankuk@yahoo.com"
    Then The following data shall be displayed: iankuk@yahoo.com, Ian, Kuk, 70 Meadowbrook Street Ashburn VA 20147
  Scenario: comparing user information when logged in as specific user
    When I am on the Kibab user page
    And I am logged in as: "brandoncano@hotmail.com"
    Then The following data shall be displayed: "brandoncano@yahoo.com", "Brandon", "Cano", "101 Valley Farms Avenue New Bern NC 28560"

  Scenario: comparing user information when not logged in
    When I am on the Kibab user page
    And I am not logged in as: "anyone"
    Then No data shall be displayed