Feature: edit an existing movie

Scenario: Edit a movie from the RottenPotatoes App

 Given I have added a movie with title "Ted" and rating "G"
 And I have visited the Details about "Ted" page

 When I have edited the movie "Ted" to change the rating to "R"
 And I am on the RottenPotatoes home page
 Then I should see a movie list entry with title "Ted" and rating "R"
