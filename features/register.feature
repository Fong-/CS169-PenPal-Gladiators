@javascript @seed_topics
Feature: Register
  As a new user
  I want to create an account.
  So that I can use PenPal Gladiators

Background:
    Given I am a user with email "foo@bar.com" and password "fizzbuzz"
    And I am on the Login/Register page

Scenario: The user registers with an existing username.
    Given I fill in "email" with "foo@bar.com"
    And I fill in "password" with "password"
    And I press "Register"
    Then I should see "exists"

Scenario: The user registers with a non-existant username.
    Given I fill in "email" with "user@bar.com"
    And I fill in "password" with "fizzbuzz"
    And I press "Register"
    Then I should be on the survey page
