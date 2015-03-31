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
        when "Home" then "/home"
        when "Profile" then "/home/#/profile"
        else raise "Could not navigate to the #{page_name} page."
        end
end

Given /^I am signed in with "(.*)"$/ do |email|

end

# Checking page identity

Then /I should be on the (.*?) page/ do |page_name|
    case page_name
    when "Profile" then expect(current_url.index("/home/#/profile")).to_not eq(nil)
    when "Home" then expect(current_url.index("/home")).to_not eq(nil)
    else raise "No check for the #{page_name} page."
    end
end
