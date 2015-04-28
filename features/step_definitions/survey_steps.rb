# Database setup
Given /the following questions exist/ do |questions_table|
    questions_table.hashes.each do |row|
        topic = Topic.find_by_name(row[:topic])
        topic.survey_questions.create!(:text => row[:text], :index => row[:index])
    end
end

Given /the following responses exist/ do |responses_table|
    responses_table.hashes.each do |row|
        question = SurveyQuestion.find_by_text(row[:question_text])
        question.survey_responses.create!(:text => row[:response_text], :index => row[:index], :summary_text => row[:summary_text])
    end
end

# Topic selection page
When /I click topics (.*)/ do |topics|
    topics.split(", ").each do |topic_string|
        topic = topic_string[1..-2]
        topic.gsub!("\"", "")
        topic.gsub!(" ", "_")
        page.find("##{topic.downcase}").click()
    end
end

And /I have selected the topics (.*)/ do |topics|
    step "I am on the Survey Topic Checkboxes page"
    topics.split(", ").each do |topic_string|
        step "I click topics #{topic_string}"
    end
end

# Question page
Given /^I have navigated to the first survey questions page$/ do
    step "I press \"Continue to Survey Questions\""
end

And /^I answer all the questions$/ do
    page.all("input[type='checkbox']").each do |checkbox|
        checkbox.set(true)
    end
end

Then /^I should( not)? see question (\d+) highlighted$/ do |should_not_see, question_num|
    selector = "#question#{question_num}.highlighter"
    if should_not_see
        expect(page).not_to have_css(selector)
    else
        expect(page).to have_css(selector)
    end
end

Then /^I should not see any question highlighted$/ do
    # Use find so Capybara will wait for site to load questions
    find("#question1")
    questions = all(".question-container")
    (1..questions.length).each do |question_num|
        step "I should not see question #{question_num} highlighted"
    end
end

And /^I select response (\d+) for question (\d+)$/ do |response_num, question_num|
    check("response#{question_num}-#{response_num}")
end

And /^I select response (\d+) for every question$/ do |response_num|
    # Use find so Capybara will wait for site to load questions
    find("#question1")
    questions = all(".question-container")
    (1..questions.length).each do |question_num|
        step "I select response #{response_num} for question #{question_num}"
    end
end

# Summary page
And /^I click on the edit button for topic "(.*)"$/ do |topic|
    step "I press \"edit-#{topic}\""
end

And /^I click on the Next button$/ do
    step 'I should see a button with "Next"'
    expect(page.find("#continue-button").value).to eq "Next"
    page.find("#continue-button").click
    #step 'I press "Next"'
end

Given /^I have navigated to the summary page$/ do
    step 'I have selected the topics "Climate", "Education", "Economy", "Technology", "LGBT Rights"'
    step 'I have navigated to the first survey questions page'
    step 'I should see "Climate"'
    step "I select response 1 for every question"
    step 'I click on the Next button'
    step 'I should see "Education"'
    step "I select response 1 for every question"
    step 'I click on the Next button'
    step 'I should see "Economy"'
    step "I select response 1 for every question"
    step 'I click on the Next button'
    step 'I should see "Technology"'
    step "I select response 1 for every question"
    step 'I click on the Next button'
    step 'I should see "LGBT Rights"'
    step "I select response 1 for every question"
    step 'I click on the Next button'
end
