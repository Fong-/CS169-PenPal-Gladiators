Given /^a user with email "(.*)" and password "(.*)" in the database$/ do |email, password|
    User.create({:email => email, :password => password})
end

Then /^I should be at the survey page$/ do
end

Then /^I should be at the profile page$/ do
end
