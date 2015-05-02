@javascript
Feature: Provide a Gladiator a list of "compatible" Gladiators so Gladiators can be paired
    As a registered Gladiator
    So that I can engage in political conversations with other Gladiators that have differing views than mine
    I want to be able to match myself with a compatible Gladiator

Background: I am a Gladiator that has completed the on-boarding process
    Given there are several gladiators using the app
    And I sign in as "george@email.com" with password "1234"
    And I am on the home page

Scenario: Presented with a list of matches
    Given I expand the matches dropdown in the sidebar
    Then I should see "Alice"
    And I should see "Bob"
    And I should see "Charlie"
    And I should see "David"
    And I should see "Edward"

Scenario: Initiate gladiation
    Given I expand the matches dropdown in the sidebar
    And I match with "Alice"
    And I expand the pending matches dropdown in the sidebar
    Then I should see "Alice" in the pending matches dropdown

Scenario: Accept an invitation
    Given I expand the incoming matches dropdown in the sidebar
    Then I should see "Bob" in the incoming matches dropdown
    And I accept the invitation from "Bob"
    And I wait 1 second
    And I expand all names in the sidebar
    Then I should see "There don't seem to be any conversations yet. Check back later!"
