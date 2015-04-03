When /I (.*) a response/ do |status|
    pending "unimplemented"
end

Then /the progress bar should be (.*)/ do |progress|
    step "Then I should see '0 questions left'"
end

Then /the progress bar should move (.*)/ do |progress|
    step "Then I should see '1' questions left"
end

And /the progress bar should not move (.*)/ do |progress|
    step "Then I should not see '2' questions left"
end

# Temporary steps
Then /I(?: should)?( not)? see '(.*)' questions left/ do |content|
    if should_not_see
        expect(page).not_to_have_text(content)
    else
        expect(page).to have_text(content)
    end
end
