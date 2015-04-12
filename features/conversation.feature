@javascript
Feature: allow the user to make and read posts in a conversation
    As a registered gladiator
    So that I can debate with another gladiator
    I want to use the conversation page

Background: I am a registered gladiator
    # TODO Authenticate the user?
    Given an arena is set up with posts containing "First post", "Second post", "Third post", "(and a huge post)", "(and a huge post)"

Scenario: the user can see the latest post upon entering the conversation page
    Given I am on the home page
    And I expand all names in the sidebar
    And I click "What messages are you posting?" in the sidebar
    Then I should see "What messages are you posting?"
    And I should see the latest post

Scenario: the user can see the previous posts
    Given I am on the conversation page for "What messages are you posting?"
    And I should see "First post"
    And I should see "Second post"
    And I should see "Third post"

Scenario: the user can create a new post
    Given I am on the conversation page for "What messages are you posting?"
    And I click "Add a post" in the conversation page
    When I fill in "post-textarea" with "Latest post"
    And I click "Submit" in the conversation page
    Then I should not see "post-textarea"
    And I should see "Latest post"

Scenario: the user can edit his/her existing post
    Given I am on the conversation page for "What messages are you posting?"
    Then I should not be able to edit "Second post"
    Then I should be able to edit "Third post"
    When I edit the post "First post"
    When I fill in "post-textarea" with "I have edited the 1st post!"
    And I click "Submit" in the conversation page
    Then I should not see "post-textarea"
    And I should not see "First post"
    And I should see "I have edited the 1st post!"
