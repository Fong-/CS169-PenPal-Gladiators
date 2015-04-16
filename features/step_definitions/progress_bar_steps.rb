When /I login and select topics/ do
    visit "/login"
    step 'I fill in "email" with "alice@example.com"'
    step 'I fill in "password" with "12345678"'
    step 'I press "Start Registration"'
    step 'I wait 2 seconds'
    step 'I have selected the topics "Education", "Climate", "Philosophy", "Technology", "Religion"'
end

Given /^I am on the topic (.*)/ do |topic|
    step 'I login and select topics'
    step 'I press "Continue to Survey Questions"'
    topicIter = 0
    case (topic)
        when "Climate"
            topicIter = 0
        when "Education"
            topicIter = 1
        when "Economy"
            topicIter = 2
        when "Technology"
            topicIter = 3
        when "LGBT Rights"
            topicIter = 4
        when "Immigration"
            topicIter = 5
        when "Foreign Policy"
            topicIter = 6
        when "Religion"
            topicIter = 7
        when "Philosophy"
            topicIter = 8
        when "Criminal Law"
            topicIter = 9
    end
    while (topicIter != 0)
        step 'I answer all the questions'
        step 'I press "Next"'
        topicId -= 1
    end
end

When /I answer a question/ do
    step 'I select response 1 for question 1'
end

Then /the progress bar should be at (.*)/ do |progress|
    page.has_xpath?("//div[@style='width:#{progress}' and @id='progress-bar-percent']")
end

