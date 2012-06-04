
Feature: Control Access
  In order to control user access
  As a security enthusiast
  I want to only allow access when authorized


  Scenario Outline: Ensure user can logout
    Given I am logged in as "admin"
    When I go to logout page
    Then I should see "You have been logged out"
    And I should be on login page


