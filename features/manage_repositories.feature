Feature: manage my repositories
  
  In order to use gitty
  As a user
  I want to manage repositories
  
  Scenario: display my repositories
    
    Given I have repositories titled Gitty, Gitup
    When I go to the dashboard page
    Then I should see Gitty
    And I should see Gitup