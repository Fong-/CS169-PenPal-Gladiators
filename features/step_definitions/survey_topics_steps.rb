Given /I am on the "Survey Topic Checkboxes" page/ do
    visit '/#topics'
end

When /I check "(.*)"/ do |topic|
    page.find("##{topic.downcase}").click()
end

Then /the "(.*)" checkbox should be checked/ do |topic|
    expect(page.find("##{topic.downcase}_checkbox", :visible => false).checked?).to be(true)
end
