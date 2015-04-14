Then /^I should see profile pictures to choose from$/ do
    pending "Unimplemented"
end

Then /^I should be able to select a profile picture$/ do
    pending "Unimplemented"
end

Then /^I should be able to select that I am "(.*?)"$/ do |position|
    choose(position)
end

Then /^I should see the text "(.*?)" for "(.*?)"$/ do |text, id|
    page.find("##{id}").should have_text(text)
end

Given /^there is a series of radio buttons corresponding to a political "(.*?)"$/ do |spectrum|
    page.has_content?(spectrum)
end

Given /^"(.*?)" has a political hero of "(.*?)"$/ do |user, hero|
    User.create({:username => user, :political_hero => hero})
end

Given /^I navigate to the profile page of "(.*?)"$/ do |user|
    visit "/#/profile/#{User.find_by_username(user).id}"
end

