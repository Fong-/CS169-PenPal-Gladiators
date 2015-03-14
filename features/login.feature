@javascript @seed_topics
Feature: Login
    As a new user
    I want to log in to an existing account
    So that I can use PenPal Gladiators.

Background:
    Given a user with email "foo@bar.com" and password "fizzbuzz" in the database
    And I am on the Login/Register page

Scenario: The user logs in with the correct username and password.
    Given I fill in "email" with "foo@bar.com"
    And I fill in "password" with "fizzbuzz"
    And I press "Login"
    Then I should be at the profile page

Scenario: The user logs in with the incorrect username and password.
    Given I fill in "email" with "foo@bar.com"
    And I fill in "password" with "fizzbuzz"
    And I press "Login"
    Then I should see "Incorrect"

Scenario: The user attempts a SQL injection.
    Given I fill in "email" with "; DROP * FROM users;"
    And I fill in "password" with "; DROP * FROM users;"
    And I press "Login"
    Then I should see "Incorrect"