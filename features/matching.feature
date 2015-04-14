@javascript
Feature: Provide a Gladiator a list of "compatible" Gladiators so Gladiators can be paired
    As a registered Gladiator
    So that I can engage in political conversations with other Gladiators that have differing views than mine
    I want to be able to match myself with a compatible Gladiator

Background: I am a Gladiator that has completed the on-boarding process
    Given the database is setup

Scenario: Request a list of compatible Gladiators to pair with
    Given I am on the home page
    Then I should see a button with "Match Me with Another Gladiator"

Scenario: Initiate Gladiation
    Given I press "Match Me with Another Gladiator"
    And that the algorithm matches me with "Alice", "Bob", "Charlie", "David", and "Edward"
    Then I should see the option to initiate Gladiation with "Alice"
    And I should see the option to initiate Gladiation with "Edward"

Scenario: Accept an invitation
    Given that "Alice" invited me to Gladiate
    Then I should see a button with "Accept Alice's Invitation"
    And I press "Accept Alice's Invitation"
    And I expand all names in the sidebar
    Then I should see "Alice"
