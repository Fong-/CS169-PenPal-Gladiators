Feature: Edit and display a user profile
    As a pseudo-anonymous Gladiator
    So that other Gladiators can learn more about my political ideologies
    I want to create a Gladiator-public user profile for myself

Background: I am on my user profile page
    Given I am on my user profile page

# Consider using identicons and uploaded photo (a la GitHub)
Scenario: Choose a profile photo
    When I click "Choose Profile Picture"
    And I see profile pictures to choose from
    Then I should be able to select a profile picture

Scenario: Select a political hero
    Given there is a text box called "Political-Hero"
    Then I can write "Foo Bar" in the "Political-Hero" text box.

Scenario: Select a position from liberal to conservative
    Given there is a series of five radio buttons ranging from "liberal" to "moderate" to "conservative"
    Then I should be able to select that I am "liberal"
    And I should be able to select that I am "moderately-liberal"
    And I should be able to select that I am "moderate"
    And I should be able to select that I am "moderately-conservative"
    And I should be able to select that I am "conservative"

Scenario: Write a political blurb
    Given there is a text box called "Political-Blurb"
    Then I can write "I appreciate Foo Bar's dedication to Widgets" in the "Political-Blurb" text box.

Scenario: Decline to complete profile
    Given there is a "Complete Profile Later" button
    Then I should be able to click the button
    And I should be on the home page

Scenario: View other Gladiator's profile
    Given I navigate to the profile of "Garply"
    And "Garply"'s political hero is "Widget"
    Then I should see "Widget" in the "Political-Hero" text box
    And I can not write "Foo Bar" in the "Political-Hero" text box
