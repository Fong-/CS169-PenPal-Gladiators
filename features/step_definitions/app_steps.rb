# Database setup

Given /^I am a user with email "(.*)" and password "(.*)"$/ do |email, password|
    User.create({:email => email, :password => password})
end

Given /^the database is setup$/ do
    # Also "database" is not really a term to be used as a feature word. Probably reword.
    pending "Unimplemented"
end

Given /^I selected (.*?) topics$/ do |num_topics|
    pending "Unimplemented"
end

Given /^I am a new user$/ do
    # What is this...I am a new user doing what...?
    pending "Unimplemented"
end

Given /^an arena is set up with posts from (.*) ago$/ do |age_strings|
    age_strings = age_strings.split(",").map {|c| c.strip}
    users = [
        User.create(:email => "a@b.com", :password => "asdfasdf"),
        User.create(:email => "u@v.com", :password => "qwerqwer")
    ]
    arena = users[0].arenas.create :user1 => users[0], :user2 => users[1]
    conversation = arena.conversations.create :title => "From how long ago are you posting?"
    age_strings.each_with_index do |age, index|
        value, units = age.split()
        age = Integer(value).send(units).ago
        author = users[index % 2]
        Timecop.freeze age
        conversation.posts.create :text => "Hello world!", :author => author
        Timecop.return
    end
end

Given /^an arena is set up with posts containing (.*)$/ do |messages|
    messages = messages.split(",").map do |c|
        c.strip!
        c[1...c.length - 1]
    end
    users = [
        User.create(:email => "w@x.com", :password => "tyuityui"),
        User.create(:email => "y@z.com", :password => "zxcvzxcv")
    ]
    arena = users[0].arenas.create :user1 => users[0], :user2 => users[1]
    conversation = arena.conversations.create :title => "What messages are you posting?"
    messages.each_with_index do |message, index|
        conversation.posts.create :text => message, :author => users[index % 2]
    end
end

Given /^an empty arena is set up$/ do
    first = User.create(:email => "p@q.com", :password => "tyuityui")
    second = User.create(:email => "m@n.com", :password => "uiopuiop")
    arena = first.arenas.create :user1 => first, :user2 => second
    conversation = arena.conversations.create :title => "Why do you never post in here?"
end

# Navigating to page

Given /^I am on (?:the|a|my) (.*?) page$/ do |page_name|
    visit case(page_name)
        when "Login/Register" then "/#/"
        when "Survey Topic Checkboxes" then "/#topics"
        when "survey" then pending "No route here!"
        when "home" then "/home"
        when "profile" then "/home/#/profile/1"
        else raise "Could not navigate to the #{page_name} page."
    end
end

When /^I expand all names in the sidebar$/ do
    find(".gladiator-heading-container").click
end

Given /^I am signed in with "(.*)"$/ do |email|

end

# Checking page identity

Then /I should be on the (.*?) page/ do |page_name|
    case page_name
    when "survey"
        pending "no check for survey!"
    when "profile"
        page.should have_content "My Position on the Political Spectrum"
    when "home"
        pending "Check that I am on the home page."
    else
        raise "No check for the #{page_name} page."
    end
end
