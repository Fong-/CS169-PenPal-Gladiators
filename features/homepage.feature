@javascript
Feature: display interesting content in the homepage
    As a registered gladiator
    So that I will have something to read when I visit the homepage
    I want to see interesting content

Background: I am a registered gladiator
    Given an arena is set up with posts containing "First post", "Second post", "Third post", "(and a huge post)", "(and a huge post)"
    And I sign in as "alice@example.com" with password "12345678"

Scenario: the user can see posts with resolutions
    Then I should not see "What messages are you posting?"
    Given the second user edited the resolution to be "Here is my resolution"
    And I am on the home page
    Then I should see "What messages are you posting?"
    Then I should see "Here is my resolution"
