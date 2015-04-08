@javascript
Feature: allow the user to make and read posts in a conversation
    As a registered gladiator
    So that I can debate with another gladiator
    I want to use the conversation page

Background: I am a registered gladiator
    # TODO Authenticate the user?
    Given an arena is set up with posts containing "First post", "Second post", "Third post"

Scenario: the user can see the latest post upon entering the conversation page
    Given I am on the home page
    And I click on "What messages are you posting?"
    Then I should see "What messages are you posting?"
    And I should be at the latest post

Scenario: the user can see the previous posts
    Given I am on the conversation page
    And I should see "First post"
    And I should see "Second post"
    And I should see "Third post"

Scenario: the user can create a new post
    Given I am on the conversation page
    And I click "Respond"
    Then I should see a text area
    When I fill in "New Post" with "Fourth post"
    And I click "Submit"
    Then I should not see a text area
    And I should see "Fourth post"

Scenario: the user can edit his/her existing post
    Given I am on the conversation page
    Then I should not be able to edit the second post
    When I edit the first post
    Then I should see a text area
    When I fill in "Edit Post" with "1st post"
    And I click "Submit"
    Then I should not see a text area
    And I should see "1st post"
    And I should not see "First post"
    And I should see "Edited on"
