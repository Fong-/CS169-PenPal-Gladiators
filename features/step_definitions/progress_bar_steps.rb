When /I (.*) a response/ do |status|
    pending "unimplemented"
end

Then /the progress bar should be at (.*)/ do |progress|
    page.has_xpath?("//div[@style='width:#{progress}' and @id='progress-bar-percent']")
end

# Temporary steps
Then /I(?: should)?( not)? see '(.*)' questions left/ do |content|
    if should_not_see
        expect(page).not_to_have_text(content)
    else
        expect(page).to have_text(content)
    end
end
