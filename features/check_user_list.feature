Feature: display individual users information on their page

  As a customer
  So that I can see my infomation
  I want to see my first and last name, email, and address displayed on my page
#Categories: Home, Entertainment, Clothing, Personal Care, and Office
#Descriptions: Well Worn, Used, Like New, New
#Assumed shopper is shopping in Iowa City Iowa
  Background: products have been added to database
    Given the following users exist:
      | email                   | password_digest                                                      | first_name | last_name | address                                     |
      | johnjones@gmail.com     | $2a$12$86inXQAxCAq5UzGWSPJKGuRBeXRqKdxqrPTFMxIixu1stfHR0XTEC         | John       | Jones     | 7486 West Blackburn Court Cheshire CT 06410 |
      | iankuk@yahoo.com        | $2a$12$TT3ZOAMu.PDPQQQNrX6VqeuIU9zDj5NPORGyvgBXhUbY6oqRK5..S         | Ian        | Kuk       | 70 Meadowbrook Street Ashburn VA 20147      |
      | brandoncano@hotmail.com | $2a$12$lSIV164uVNbxx6niQhGve.wl6NnNN1Iti.M4fll0ne19XJgFXzsB.         | Brandon    | Cano      | 101 Valley Farms Avenue New Bern NC 28560   |
      | angelozamba@aol.com     | $2a$12$OD5qvyvKLk/3JpvShA5eDebhnQ10fOqVM9USH5vDC/D2HcAwKFC3.         | Angelo     | Zamba     | 1 Pilgrim Lane Ringgold GA 30736            |
      | brendansuttor@yahoo.com | $2a$12$EFCOwFO1N530z55J1nguhOtPBXXCPEQ9u6qpYkkb/ooy9EBEHuZGC         | Brendan    | Suttor    | 56 Atlantic Street Muncie IN 47302          |
      | kaileymackin@gmail.com  | $2a$12$2kr/B4mpopTF8eRyp8/np.7tDKp4CicRSttLhuWKeSWGJK/bDMx1a         | Kailey     | Mackin    | 879 East Ryan Court Nashville TN 37205      |
      | megantaylor@yahoo.com   | $2a$12$eFYoJEDSDeKQ/N09NRPevOOwhnenydnx1xmleAbxDs8Z7JDYbo5kG         | Megan      | Taylor    | 797 Plymouth Drive Yonkers NY 10701         |
      | jennamarbles@hotmail.com| $2a$12$Nk.RBlk3lLA3bIuxhcL0zuztUS8e0kZJparQcBVMJyyy2.ZSiImy2         | Jenna      | Marbles   | 998 Marconi Court Spring Valley NY 10977    |

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