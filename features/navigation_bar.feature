@javascript
Feature: allow the user to navigate the site using the navigation bar
    As a registered gladiator
    So that I can access parts of the site more efficiently
    I want to use the navigation bar

Background: I am a registered gladiator who is navigating the site
    Given I sign in as "foo@bar.com" with password "fizzbuzz"

Scenario: can navigate to the profile page and back
    Given I am on the home page
    When I press "My Profile"
    Then I should be on the profile page
    When I follow "The Coliseum"
    Then I should be on the home page

Scenario: can navigate to the home page and back
    Given I am on the profile page
    When I follow "The Coliseum"
    Then I should be on the home page
    When I press "My Profile"
    Then I should be on the profile page

@wip
Scenario: can log out of the app
    Given I am on the home page
    When I click on the logout button
    When I visit the home page
    Then I should be on the login page
