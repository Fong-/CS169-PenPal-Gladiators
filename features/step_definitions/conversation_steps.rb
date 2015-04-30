
And /^the (.*) user's summary is "(.*)"$/ do |userNum, summaryText|
    conversation = Conversation.find_by_title("What messages are you posting?")
    if userNum == "first"
        expect(conversation.summary_of_first).to eq summaryText
    elsif userNum == "second"
        expect(conversation.summary_of_second).to eq summaryText
    else
        raise "Expected user to be 'first' or 'second' instead of '#{userNum}'"
    end
end

And /^the resolution should be "(.*)"$/ do |resolutionText|
    conversation = Conversation.find_by_title("What messages are you posting?")
    expect(conversation.resolution).to eq resolutionText
end

Given /^the (.*) user wrote a summary "(.*)"$/ do |userNum, summaryText|
    conversation = Conversation.find_by_title("What messages are you posting?")
    if userNum == "first"
        conversation.summary_of_second = summaryText
    elsif userNum == "second"
        conversation.summary_of_first = summaryText
    end
    conversation.save
end

Given /^the (.*) user edited the resolution to be "(.*)"$/ do |userNum, resolutionText|
    conversation = Conversation.find_by_title("What messages are you posting?")
    if userNum == "first"
        user = conversation.arena.user1
    elsif userNum == "second"
        user = conversation.arena.user2
    end
    expect(conversation.user_did_edit_resolution(user.id, resolutionText)).to eq true
    conversation.save
end

When /^I approve the (.*)$/ do |summary_or_resolution|
    find("#approve-#{summary_or_resolution}").trigger("click")
end

When /^I click "(.*)" in the conversation page$/ do |element_name|
    case element_name
    when "Add a post" then
        find("#add-post-button").click
    when "Propose a summary" then
        find("#propose-summary-button").click
    when "Submit" then
        find("#submit-post-button").click
    when "Edit resolution" then
        find("#edit-resolution-button").click
    else raise "No check for clicking the #{element_name} element in the conversation page."
    end
end
