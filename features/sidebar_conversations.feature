@javascript
Feature: allow the user to start conversations from the sidebar
    As a registered gladiator
    So that I can begin debating with my fellow gladiators
    I want to be able to start a conversation from the sidebar

Background: I am a registered gladiator ready to start a conversation
    Given an empty arena is set up
    And I sign in
    And I expand all names in the sidebar

@wip
Scenario: I should be able to start new conversations
    Given I see a button with "Start a conversation"
    And I press "Start a conversation"
    Then I should see "Conversation Title"
