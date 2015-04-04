@javascript
Feature: Edit and display a user profile
    As a pseudo-anonymous Gladiator
    So that other Gladiators can learn more about my political ideologies
    I want to create a Gladiator-public user profile for myself

Background: I am on my user profile page
    Given I am on the profile page
    Then I should be on the profile page


# Consider using identicons and uploaded photo (a la GitHub)
#
# TODO: Commented out 2015-04-02 because stretch goal of having avatars working
# is not going to be met for iteration 2
#
#Scenario: Choose an avatar
#    When I press "Choose an Avatar"
#    Then I should see avatars to choose from
#    And I should be able to select an avatar

Scenario: Select a political hero
    When I press "edit-profile"
    And I fill in "Political-Hero" with "Foo Bar"
    And I press "save"
    Then I should see "Foo Bar"

Scenario: Select a position from liberal to conservative
    Given there is a series of five radio buttons ranging from "liberal" to "moderate" to "conservative"
    And I press "edit-profile"
    Then I should be able to select that I am "liberal"
    And I should be able to select that I am "moderately-liberal"
    And I should be able to select that I am "moderate"
    And I should be able to select that I am "moderately-conservative"
    And I should be able to select that I am "conservative"

Scenario: Write a political blurb
    When I press "edit-profile"
    And I fill in "Political-Blurb" with "I appreciate Foo Bar's dedication to Widgets"
    And I press "save"
    Then I should see "I appreciate Foo Bar's dedication to Widgets"

Scenario: View other Gladiator's profile
    Given "Garply" has a political hero of "Widget"
    And I navigate to the profile page of "Garply"
    Then I should see "Widget" in the "Political-Hero" text box
#    And I should not see "update-profile"
