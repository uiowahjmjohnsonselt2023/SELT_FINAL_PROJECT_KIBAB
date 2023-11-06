Feature: Allow RottenPotatoes user to add a new movie

Scenario:  Add a new movie (Declarative)
  When I have added a movie with title "Men in Black" and rating "PG-13"
  And I am on the RottenPotatoes home page  
  Then I should see a movie list entry with title "Men in Black" and rating "PG-13"
