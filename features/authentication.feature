@javascript
Feature: authenticate the user when using the website
    As a user of the site
    So that I can be sure that my information is safe
    I want to be authenticated in order to use the website

Background: I am a user of the site

Scenario: A new user cannot access the home page
    Given I navigate to the home page
    Then I should be on the login page

Scenario: An existing user cannot access the login page
    Given I sign in
    And I navigate to the login page
    Then I should be on the home page
