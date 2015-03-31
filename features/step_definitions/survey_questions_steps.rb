Given /the following questions exist/ do |questions_table|
    questions_table.hashes.each do |row|
        topic = Topic.find_by_name(row[:topic])
        topic.survey_questions.create!(:text => row[:text], :index => row[:index])
    end
end

Given /the following responses exist/ do |responses_table|
    responses_table.hashes.each do |row|
        question = SurveyQuestion.find_by_text(row[:question_text])
        question.survey_responses.create!(:text => row[:response_text], :index => row[:index])
    end
end

And /I have selected the topics (.*)/ do |topics|
    step "I am on the Survey Topic Checkboxes page"
    topics.split(", ").each do |topic_string|
        step "I click topics #{topic_string}"
    end
end

Given /^I have navigated to the first survey questions page$/ do
    step "I press \"Continue to Survey Questions\""
end

And /^I answer all the questions$/ do
    page.all("input[type='checkbox']").each do |checkbox|
        checkbox.set(true)
    end
end
