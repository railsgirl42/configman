
Feature: Manage Users
  In order to manage user details
  As a security enthusiast
  I want to manage user profiles only when authorized

  Background:
    Given the following user records:
    |id| username |password|
    |1 | tutor    |secret  |
    |2 | admin    |secret  |
    |3 | metaadmin|secret  |

@javascript
Scenario: List users as admin
  Given I am logged in as "metaadmin" with password "secret"
  When I go to the list of users
  Then I should see the following users:
      |Username |
      |admin    |
      |metaadmin|
      |tutor    |
  When I sort by "Username"
  Then I should see the following users:
      |Username |
      |tutor    |
      |metaadmin|
      |admin    |

@javascript
 Scenario Outline: Create valid and invalid users
  Given I am logged in as "metaadmin" with password "secret"
  And  I am on the list of users
  When I follow "Add new User"
  And I fill in "Username" with "<username>"
  And I fill in "Email" with "<email>"
  And I fill in "Password" with "<password>"
  And I fill in "Confirm Password" with "<confirmation>"
  And I press "Sign up"
  Then I should <action>
  And I should have <count> users

    Examples:
    |username|email            |password|confirmation|action                                                                   |count|
    |test1   |test1@example.com|password|password    |see "Thank you for signing up! You are now logged in."                   |4    |
    |test2   |test2@example.com|password|different   |see "Password doesn't match confirmation" within ".ui-dialog"            |3    |
    |test3   |test3@example.com|password|password    |see "Thank you for signing up! You are now logged in."                   |4    |
    |t       |test4@example.com|password|password    |see "Username is too short (minimum is 3 characters)" within ".ui-dialog"|3    |
    |        |test5@example.com|password|password    |see "Username is too short (minimum is 3 characters)" within ".ui-dialog"|3    |

@javascript
  Scenario: Edit user as metaadmin
    Given I am logged in as "metaadmin" with password "secret"
    And I am on the list of users
    When I edit the 2nd user
    When I fill in "Email" with "newemail@example.com"
    And I press "Update"
    And I wait for the ajax to complete
    Then I should see the following users:
      |Username |
      |admin    |
      |metaadmin|
      |tutor    |

@javascript
  Scenario: Delete User as metaadmin
    Given I am logged in as "metaadmin" with password "secret"
    And I am on the list of users
    And I should see the following users:
      |Username |
      |admin    |
      |metaadmin|
      |tutor    |
    When I delete the 3rd user
    And I confirm popup
    Then I should see the following users:
      |Username |
      |admin    |
      |metaadmin|

@javascript
  Scenario: Fail to delete User currently logged in
    Given I am logged in as "metaadmin" with password "secret"
    And I am on the list of users
    And I should see the following users:
      |Username |
      |admin    |
      |metaadmin|
      |tutor    |
    When I delete the 2nd user
    And I confirm popup
    Then I should see "Unable to delete currently logged in user"
    And I should see the following users:
      |Username |
      |admin    |
      |metaadmin|
      |tutor    |

