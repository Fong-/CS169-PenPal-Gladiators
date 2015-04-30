# Database setup

Given /^I am a user with email "(.*)" and password "(.*)"$/ do |email, password|
    User.create({:email => email, :password => password})
end

Given /^the database is setup$/ do
    # Also "database" is not really a term to be used as a feature word. Probably reword.
    pending "Unimplemented"
end

Given /^an arena is set up with posts containing (.*)$/ do |messages|
    messages = messages.split(",").map do |c|
        c.strip!
        c[1...c.length - 1]
    end
    users = [
        User.create(:email => "alice@example.com", :password => "12345678"),
        User.create(:email => "bob@example.com", :password => "12345678")
    ]
    arena = users[0].arenas.create :user1 => users[0], :user2 => users[1]
    conversation = arena.conversations.create :title => "What messages are you posting?"
    messages.each_with_index do |message, index|
        if message == "(and a huge post)"
            message = "bacon strips & " * 40
        end
        conversation.posts.create :text => message, :author => users[index % 2]
    end
end

# Navigating to page

Given /^I am on (?:the|a|my) (.*?) page$/ do |page_name|
    case (page_name)
        when "Login/Register"
            visit "/login"
            step "I wait 2 seconds"
        when "Survey Topic Checkboxes"
            visit "/login"
            step 'I fill in "email" with "alice@example.com"'
            step 'I fill in "password" with "12345678"'
            step 'I press "Start Registration"'
            step "I wait 2 seconds"
        when "survey"
            pending "No survey route."
        when "home"
            visit "/home"
            step "I wait 2 seconds"
        when "profile"
            visit "/home#/profile/1"
            step "I wait 2 seconds"
        when "conversation"
            pending "No conversation route."
        else
            raise "Could not navigate to the #{page_name} page."
    end
end

When /^I expand all names in the sidebar$/ do
    find(".gladiator-heading-container").click
end

Given /^I sign in$/ do
    step 'I sign in as "alice@example.com" with password "12345678"'
end

Given /^I sign in as "(.*)" with password "(.*)"$/ do |email, password|
    unless User.exists_with_credentials(email, password)
        User.create({:email => email, :password => password})
    end
    visit "/home"
    step "I fill in \"email\" with \"#{email}\""
    step "I fill in \"password\" with \"#{password}\""
    step 'I press "Login"'
    step "I should be on the home page"
end

# Checking page identity

Then /I should be on the (.*?) page/ do |page_name|
    case page_name
    when "login"
        page.should have_content "The Coliseum"
        page.should have_content "Login"
        page.should have_content "Registration"
    when "topics"
        page.should have_content "Which topics interest you?"
    when "profile"
        page.should have_content "My Position on the Political Spectrum"
    when "home"
        page.should have_content "Trending Resolutions"
    else
        raise "No check for the #{page_name} page."
    end
end

# HACK This is probably worthy of some award. Not the good kind.
And /^I should see the latest post$/ do
    sleep 2
    page.execute_script [
        "test_container = document.getElementById('posts-container');",
        "test_oldScrollTop = test_container.scrollTop;",
        "test_container.scrollTop += 1;",
        "if (test_oldScrollTop < test_container.scrollTop) document.body.appendChild(document.createTextNode('Test failed.'));",
    ].join(" ")
    expect(page).to_not have_content("Test failed.")
end

And /^I am on the conversation page for "(.*)"$/ do |title|
    conversation = Conversation.find_by_title(title)
    visit "/home#/conversation/#{conversation.id}"
end

When /^I click "(.*)" in the sidebar$/ do |element_name|
    find(".conversation-preview", :text => element_name, :exact => true).click
end

When /^I click on the logout button$/ do
    page.find("#logout_nav").click
end

Then /^I should( not)? be able to edit "(.*)"$/ do |should_not, post_text|
    element = find(".post-content-panel", :text => post_text, :exact => true)
    if should_not
        element.should_not have_content("Edit")
    else
        element.should have_content("Edit")
    end
end

When /^I edit the post "(.*)"$/ do |post_text|
    element = find(".post-content-panel", :text => post_text, :exact => true)
    element.should have_content("Edit")
    element.find("a", :text => "Edit", :exact => true).click
end

And /I click a delete button/ do
    find(".glyphicon-remove").click
end
