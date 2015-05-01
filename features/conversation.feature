@javascript
Feature: allow the user to make and read posts in a conversation
    As a registered gladiator
    So that I can debate with another gladiator
    I want to use the conversation page

Background: I am a registered gladiator
    Given an arena is set up with posts containing "First post", "Second post", "Third post", "(and a huge post)", "(and a huge post)"
    And I sign in as "alice@example.com" with password "12345678"

Scenario: the user can see the latest post upon entering the conversation page
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
    And I wait 1 second
    When I fill in "post-textarea" with "Latest post"
    And I click "Submit" in the conversation page
    Then I should not see "post-textarea"
    And I should see "Latest post"

Scenario: the user can edit his/her existing post
    Given I am on the conversation page for "What messages are you posting?"
    Then I should not be able to edit "Second post"
    Then I should be able to edit "Third post"
    When I edit the post "First post"
    And I wait 1 second
    When I fill in "post-textarea" with "I have edited the 1st post!"
    And I click "Submit" in the conversation page
    Then I should not see "post-textarea"
    And I should not see "First post"
    And I should see "I have edited the 1st post!"

Scenario: the user can propose a summary
    Given I am on the conversation page for "What messages are you posting?"
    And I wait 1 second
    And I click "Propose a summary" in the conversation page
    When I fill in "post-textarea" with "Here is a summary of the opposing views"
    And I click "Submit" in the conversation page
    Then I should not see "post-textarea"
    And I wait 1 second
    And the second user's summary is "Here is a summary of the opposing views"

Scenario: the user can approve a proposed summary
    Given the second user wrote a summary "Here is a summary of the opposing views"
    And I am on the conversation page for "What messages are you posting?"
    And I wait 1 second
    And I click "Propose a summary" in the conversation page
    And I approve the summary
    Then I should not see "post-textarea"
    And I wait 1 second
    And I should see "Here is a summary of the opposing views"

Scenario: the user can edit the resolution
    Given I am on the conversation page for "What messages are you posting?"
    And I wait 1 second
    And I click "Edit resolution" in the conversation page
    And I fill in "post-textarea" with "Here is a resolution"
    And I click "Submit" in the conversation page
    Then I should not see "post-textarea"
    And I wait 1 second
    And the resolution should be "Here is a resolution"

Scenario: the user can approve a resolution
    Given the second user edited the resolution to be "Here is my resolution"
    And I am on the conversation page for "What messages are you posting?"
    And I wait 1 second
    And I click "Edit resolution" in the conversation page
    And I approve the resolution
    Then I should not see "post-textarea"
    And I wait 1 second
    And I should see "Here is my resolution"

Scenario: Posts in progress should not disappear after switching to other editors
    Given I am on the conversation page for "What messages are you posting?"
    And I click "Add a post" in the conversation page
    And I wait 1 second
    When I fill in "post-textarea" with "Writing a new post"
    And I click "Propose a summary" in the conversation page
    And I wait 1 second
    And I fill in "post-textarea" with "Writing a summary"
    And I click "Edit resolution" in the conversation page
    And I wait 1 second
    And I fill in "post-textarea" with "Writing a resolution"
    When I click "Add a post" in the conversation page
    And I wait 1 second
    Then I should see the editor filled with "Writing a new post"
    When I click "Propose a summary" in the conversation page
    And I wait 1 second
    Then I should see the editor filled with "Writing a summary"
    When I click "Edit resolution" in the conversation page
    And I wait 1 second
    Then I should see the editor filled with "Writing a resolution"

