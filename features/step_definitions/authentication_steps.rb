Given /^I navigate to the home page$/ do
    visit "/"
    step "I wait 2 seconds"
end

Given /^I navigate to the login page$/ do
    visit "/login"
    step "I wait 2 seconds"
end
