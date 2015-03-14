When /I click (.*)/ do |topics|
    topics.split(", ").each do |topic_string|
        topic = topic_string[1..-2]
        topic.gsub!(" ", "_")
        page.find("##{topic.downcase}").click()
    end
end

Then /I should( not)? see a button with "(.*)"/ do |should_not_see, content|
    if should_not_see
        expect { page.find_button(content) }.to raise_error(Capybara::ElementNotFound)
    else
        expect { page.find_button(content) }.not_to raise_error(Capybara::ElementNotFound)
    end
end
