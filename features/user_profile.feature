@javascript
Feature: Edit and display a user profile
    As a pseudo-anonymous Gladiator
    So that other Gladiators can learn more about my political ideologies
    I want to create a Gladiator-public user profile for myself

Background: I am on my user profile page
    Given I sign in as "hello@world.net" with password "helloWorld"
    And I am on the profile page
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
    And I fill in "hero" with "Foo Bar"
    And I press "Save Changes"
    Then I should see the text "Foo Bar" for "hero"

Scenario: Select a position from liberal to conservative
    Given there is a series of radio buttons corresponding to a political "spectrum"
    And I press "edit-profile"
    Then I should be able to select that I am "liberal"
    And I should be able to select that I am "moderately-liberal"
    And I should be able to select that I am "moderate"
    And I should be able to select that I am "moderately-conservative"
    And I should be able to select that I am "conservative"

Scenario: Write a political blurb
    When I press "edit-profile"
    And I fill in "blurb" with "I appreciate Foo Bar's dedication to Widgets"
    And I press "Save Changes"
    Then I should see the text "I appreciate Foo Bar's dedication to Widgets" for "blurb"

Scenario: Save changes
    When I press "edit-profile"
    And I fill in "blurb" with "I hate everyone"
    And I press "Save Changes"
    And I follow "Home"
    And I follow "Profile"
    Then I should see the text "I hate everyone" for "blurb"

Scenario: View other Gladiator's profile
    Given "Garply" has a political hero of "Widget"
    And I navigate to the profile page of "Garply"
    Then I should see the text "Widget" for "hero"
#    Uncomment when return 1==1 is removed from profile.coffee and logic exists to figure out who's logged in
#    And I should not see "update-profile"
