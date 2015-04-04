Then /^I should see profile pictures to choose from$/ do
    pending "Unimplemented"
end

Then /^I should be able to select a profile picture$/ do
    pending "Unimplemented"
end

Then /^I should be able to select that I am "(.*?)"$/ do |position|
    choose(position)
end

Then /^I should see the text "(.*?)"$/ do |text|
    expect(page.html).to have_text(text)
end

#Given /^there is a series of five radio buttons ranging from "(.*?)" to "(.*?)" to "(.*?)"$/ do |liberal, moderate, conservative|
Given /^there is a series of radio buttons corresponding to a political "(.*?)"$/ do |spectrum|
#    page.should have_content liberal
#    page.should have_content moderate
#    page.should have_content conservative
    page.should have_selector(spectrum)
#    page.should have_selector(liberal)
#    page.should have_selector(moderate)
#    page.should have_selector(conservative)
end

Given /^"(.*?)" has a political hero of "(.*?)"$/ do |user, hero|
    User.create({:username => user, :political_hero => hero})
end

Given /^I navigate to the profile page of "(.*?)"$/ do |user|
    visit "/home#profile/#{User.find_by_username(user).id}"
end
