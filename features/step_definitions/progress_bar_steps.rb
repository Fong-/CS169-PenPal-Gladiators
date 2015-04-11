When /I answer a question/ do
    step "I select response 1 for question 1"
end

Then /the progress bar should be at (.*)/ do |progress|
    page.has_xpath?("//div[@style='width:#{progress}' and @id='progress-bar-percent']")
end

