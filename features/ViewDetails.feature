Feature: view the "More about" page for a movie

Scenario:  Click on the "More about " link for a movie to view additional info

Given I have added a movie with title "Argo" and rating "R"

When I have visited the Details about "Argo" page
Then I should see "Details about Argo"
