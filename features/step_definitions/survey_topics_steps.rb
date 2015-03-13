Given /I am on the "Survey Topic Checkboxes" page/ do
    visit '/#topics'
end

When /I click (.*)/ do |topics|
    topics.split(", ").each do |topic_string|
        topic = topic_string[1..-2]
        page.find("##{topic.downcase}").click()
    end
end

Then /the "(.*)" checkbox should( not)? be checked/ do |topic, should_not_be_checked|
    expect(page.find("##{topic.downcase}_checkbox", :visible => false).checked?).to be(!should_not_be_checked)
end

Then /I should( not)? see "(.*)"/ do |should_not_see, content|
    if should_not_see
        expect(page).not_to have_text(content)
    else
        expect(page).to have_text(content)
    end
end

Then /I should( not)? see a button with "(.*)"/ do |should_not_see, content|
    if should_not_see
        expect { page.find_button(content) }.to raise_error(Capybara::ElementNotFound)
    else
        expect { page.find_button(content) }.not_to raise_error(Capybara::ElementNotFound)
    end
end
