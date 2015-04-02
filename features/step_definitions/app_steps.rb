# Database setup

Given /^I am a user with email "(.*)" and password "(.*)"$/ do |email, password|
    User.create({:email => email, :password => password})
end

Given /^the database is setup$/ do
    # Also "database" is not really a term to be used as a feature word. Probably reword.
    pending "Unimplemented"
end

Given /^I selected (.*?) topics$/ do |num_topics|
    pending "Unimplemented"
end

Given /^I am a new user$/ do
    # What is this...I am a new user doing what...?
    pending "Unimplemented"
end

# Navigating to page

Given /^I am on (?:the|a|my) (.*?) page$/ do |page_name|
    visit case(page_name)
        when "Login/Register" then "/#/"
        when "Survey Topic Checkboxes" then "/#topics"
        when "survey" then pending "No route here!"
        when "user profile" then pending "no check for user profile!"
        when "home" then "/home"
        when "profile" then "/home/#/profile"
        else raise "Could not navigate to the #{page_name} page."
        end
end

Given /^I am signed in with "(.*)"$/ do |email|

end

# Checking page identity

Then /I should be on the (.*?) page/ do |page_name|
    case page_name
    when "survey" then pending "no check for survey!"
    when "profile" then pending "Check that I am on the profile page."
    when "home" then pending "Check that I am on the home page."
    else raise "No check for the #{page_name} page."
    end
end
