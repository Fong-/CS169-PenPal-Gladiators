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
        if !row.key?(:summary_text)
            row[:summary_text] = "N/A"
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
    pending "Unimplemented"
end

Then /^I should not see any question highlighted$/ do
    pending "Unimplemented"
end

And /^I select response (\d+) for question (\d+)$/ do |response_num, question_num|
    check("response#{question_num}-#{response_num}")
end

And /^I select response (\d+) for every question$/ do |response_num|
    questions = page.all("question-container")
    for question_num in 1..questions.length
        step "I select response #{response_num} for question #{question_num}"
    end
end

# Summary page
And /^I click on the edit button for topic "(.*)"$/ do |topic|
    step "I press \"edit-#{topic}\""
end

