Feature: manage my repositories
  
  In order to use gitty
  As a user
  I want to see my repositories
  
  Scenario: display my repositories
    
    Given I have a repository title gitnub
    When I go to the dashboard page
    Then I should see gitnub