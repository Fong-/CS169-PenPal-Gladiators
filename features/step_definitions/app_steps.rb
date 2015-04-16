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
        conversation.posts.create :text => message, :author => users[index % 2]
    end
end

# Navigating to page

Given /^I am on (?:the|a|my) (.*?) page$/ do |page_name|
    case (page_name)
        when "Login/Register"
            visit "/login"
        when "Survey Topic Checkboxes"
            visit "/login"
            step 'I fill in "email" with "alice@example.com"'
            step 'I fill in "password" with "12345678"'
            step 'I press "Start Registration"'
            step "I wait 2 seconds"
        when "survey"
            pending "No survey route."
        when "home"
            visit "/"
            step "I wait 2 seconds"
        when "profile"
            visit "/#/profile/1"
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
    visit "/login"
    step "I fill in \"email\" with \"#{email}\""
    step "I fill in \"password\" with \"#{password}\""
    step 'I press "Login"'
    step "I should be on the home page"
end

# Checking page identity

Then /I should be on the (.*?) page/ do |page_name|
    case page_name
    when "topics"
        page.should have_content "Which topics interest you?"
    when "profile"
        page.should have_content "My Position on the Political Spectrum"
    when "home"
        page.should have_content "News"
    else
        raise "No check for the #{page_name} page."
    end
end
