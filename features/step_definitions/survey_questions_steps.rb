Given /the following responses exist/ do |responses_table|
    table_hash = responses_table.hashes
    table_hash.each do |response|
        SurveyResponse.create!(response)
    end
end

Given /the following questions exist/ do |questions_table|
    table_hash = questions_table.hashes
    table_hash.each do |question|
        SurveyQuestion.create!(question)
    end
end

Given /I have selected (.*) for Survey Topic/ do |topic|
    visit '/#/topics' # go to topics page
    page.find("##{topic.downcase}").click() #click topic
end

And /I am on the survey questions page/ do
    current_path = URI.parse(current_url).path
    until current_path # == something, IMPLEMENT - need to check description of page
    click_button('next')
    end
    # visit '/#/questions/#{topicID}'
end

Then /I should( not)? see (.*)/ do |should_not_see, content|
    if should_not_see
        expect(page).not_to have_text(content)
    else
        expect(page).to have_text(content)
    end
end

Then /^I should be able to check the response: "(.*?)"$/ do |response|
    expect(page).to have_text(response)
end
