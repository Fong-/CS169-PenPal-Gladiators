Given /I am on the Login\/Register page/ do
    visit '/#/'
end

Given /I fill in "(.*)" with "(.*)"/ do |field, value|
    fill_in(field, :with => value)
end

And /I press "(.*)"/ do |button|
    click_button(button)
end

Then /I should see "(.*)"/ do |content|
    expect(page.text).to include(content)
end

Given /^a user with email "(.*)" and password "(.*)" in the database$/ do |email, password|
    User.create({:email => email, :password => password})
end

Then /^I should be at the survey page$/ do
end

Then /^I should be at the profile page$/ do
end
