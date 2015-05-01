When /^I am editing my profile$/ do
    step "I press \"Edit\""
    step "I wait 3 seconds"
end

Then /^I should see profile pictures to choose from$/ do
    pending "Unimplemented"
end

Then /^I should be able to select a profile picture$/ do
    pending "Unimplemented"
end

Then /^I should be able to select that I am "(.*?)"$/ do |position|
    expect(page).to have_selector("input[type=radio][value='#{position}']")
end

Then /^I should see the text "(.*?)" for "(.*?)"$/ do |text, id|
    page.find("##{id}").should have_text(text)
end

Given /^"(.*?)" has a political hero of "(.*?)"$/ do |user, hero|
    User.create({:username => user, :political_hero => hero})
end

Given /^I navigate to the profile page of "(.*?)"$/ do |user|
    visit "/home#/profile/#{User.find_by_username(user).id}"
end

