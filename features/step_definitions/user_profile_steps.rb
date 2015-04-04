Then /^I should see profile pictures to choose from$/ do
    pending "Unimplemented"
end

Then /^I should be able to select a profile picture$/ do
    pending "Unimplemented"
end

Then /^I should be able to select that I am "(.*?)"$/ do |position|
    choose(position)
end

Given /^there is a series of five radio buttons ranging from "(.*?)" to "(.*?)" to "(.*?)"$/ do |liberal, moderate, conservative|
    page.should have_content liberal
    page.should have_content moderate
    page.should have_content conservative
end

Given /^"(.*?)" has a political hero of "(.*?)"$/ do |user, hero|
    User.create({:username => user, :political_hero => hero})
end

Given /^I navigate to the profile page of "(.*?)"$/ do |user|
    visit "/home#profile/#{User.find_by_username(user).id}"
end
