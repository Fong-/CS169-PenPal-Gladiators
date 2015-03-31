Feature: Edit and display a user profile
    As a pseudo-anonymous Gladiator
    So that other Gladiators can learn more about my political ideologies
    I want to create a Gladiator-public user profile for myself

Background: I am on my user profile page
    Given I am on my user profile page

# Consider using identicons and uploaded photo (a la GitHub)
Scenario: Choose a profile photo
    When I press "Choose Profile Picture"
    Then I should see profile pictures to choose from
    And I should be able to select a profile picture

Scenario: Select a political hero
    When I fill in "Political-Hero" with "Foo Bar"
    Then I should see "Foo Bar"

Scenario: Select a position from liberal to conservative
    Given there is a series of five radio buttons ranging from "liberal" to "moderate" to "conservative"
    Then I should be able to select that I am "liberal"
    And I should be able to select that I am "moderately-liberal"
    And I should be able to select that I am "moderate"
    And I should be able to select that I am "moderately-conservative"
    And I should be able to select that I am "conservative"

Scenario: Write a political blurb
    When I fill in "Political-Blurb" with "I appreciate Foo Bar's dedication to Widgets"
    Then I should see "I appreciate Foo Bar's dedication to Widgets"

Scenario: Decline to complete profile
    Given I press "Complete Profile Later"
    Then I should be on the home page

Scenario: View other Gladiator's profile
    Given "Garply" has a political hero of "Widget"
    And I navigate to the profile page of "Garply"
    Then I should see "Widget" in the "Political-Hero" text box
    And I cannot fill in "Political-Hero" with "Foo Bar"
