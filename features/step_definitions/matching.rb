Given(/^that the algorithm matches me with "(.*?)", "(.*?)", "(.*?)", "(.*?)", and "(.*?)"$/) do |match1, match2, match3, match4, match5|
  pending
end

Then(/^I should see the option to initiate Gladiation with "(.*?)"$/) do |user|
    step "I should see #{user}"
end

Given(/^that "(.*?)" invited me to Gladiate$/) do |user|
    step "I should see #{user}"
end

And(/^I press the button to match me with another Gladiator$/) do
    find("#match-button").click
    step "I wait 3 seconds"
end
