@javascript
Feature: Edit and display a user profile
    As a pseudo-anonymous Gladiator
    So that other Gladiators can learn more about my political ideologies
    I want to create a Gladiator-public user profile for myself

Background: I am on my user profile page
    Given I sign in as "alice@example.com" with password "123456789"
    And I am on the profile page

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
    When I am editing my profile
    And I fill in "hero" with "Foo Bar"
    And I press "Save Changes"
    Then I should see the text "Foo Bar" for "hero"

Scenario: Select a position from liberal to conservative
    When I am editing my profile
    Then I should be able to select that I am "Liberal"
    And I should be able to select that I am "Moderately Liberal"
    And I should be able to select that I am "Moderate"
    And I should be able to select that I am "Moderately Conservative"
    And I should be able to select that I am "Conservative"

Scenario: Write a political blurb
    When I am editing my profile
    And I fill in "blurb" with "I appreciate Foo Bar's dedication to Widgets"
    And I press "Save Changes"
    Then I should see the text "I appreciate Foo Bar's dedication to Widgets" for "blurb"

Scenario: Save changes
    When I am editing my profile
    And I fill in "blurb" with "I hate everyone"
    And I press "Save Changes"
    Then I should see the text "I hate everyone" for "blurb"
    And I follow "Home"
    And I follow "Profile"
    Then I should see the text "I hate everyone" for "blurb"

Scenario: View other Gladiator's profile
    Given "Garply" has a political hero of "Widget"
    And I navigate to the profile page of "Garply"
    Then I should see the text "Widget" for "hero"
#    Uncomment when return 1==1 is removed from profile.coffee and logic exists to figure out who's logged in
#    And I should not see "update-profile"
