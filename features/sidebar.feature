@javascript
Feature: allow the user to see arenas and recent posts using the sidebar
    As a registered gladiator
    So that I can quickly view my arenas and recent posts on each conversation
    I want to use the sidebar

Background: I am a gladiator who is a part of ongoing arenas with other gladiators
    # TODO Authenticate the user?

Scenario: the user knows when a thread was just posted
    Given an arena is set up with posts from 2 seconds, 10 years ago
    And I am on the home page
    And I expand all names in the sidebar
    Then I should see "A moment ago"

Scenario: the user knows when a thread is a few months old
    Given an arena is set up with posts from 10 years, 90 days ago
    And I am on the home page
    And I expand all names in the sidebar
    Then I should see "3 months ago"

Scenario: the user knows when a thread is really old
    Given an arena is set up with posts from 10 years, 50 years ago
    And I am on the home page
    And I expand all names in the sidebar
    Then I should see "An eternity ago"

Scenario: the user sees the latest message
    Given an arena is set up with posts containing "This text should show----------------------------------------------------------------------------------------------------This text should not show"
    And I am on the home page
    And I expand all names in the sidebar
    Then I should see "This text should show"
    Then I should see "..."
    Then I should not see "This text should not show"

Scenario: the user should not see conversation previews in an empty arena
    Given an empty arena is set up
    And I am on the home page
    And I expand all names in the sidebar
    Then I should see "Looks like no one has made any posts. Be the first to write something!"
    Then I should not see " said: "

Scenario: the user should be alerted to unread posts
    Given an arena is set up with posts containing "Hello world this is the first post"
    And I am on the home page
    And I expand all names in the sidebar
    Then I should see an unread post

Scenario: read posts should not be marked as unread
    Given an arena is set up with posts containing "Hello world this is the first post"
    And I am on the home page
    And I click on an unread post
    And I am on the home page
    Then I should not see an unread post
