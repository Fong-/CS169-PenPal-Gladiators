Given /^there are several gladiators using the app$/ do
    User.create({:email => "george@email.com", :password => "1234", :username => "George"})
    User.create({:email => "alice@email.com", :password => "1234", :username => "Alice"})
    User.create({:email => "bob@email.com", :password => "1234", :username => "Bob"})
    User.create({:email => "charlie@email.com", :password => "1234", :username => "Charlie"})
    User.create({:email => "david@email.com", :password => "1234", :username => "David"})
    User.create({:email => "edward@email.com", :password => "1234", :username => "Edward"})

    Invite.create :from => User.find_by_email("bob@email.com"), :to => User.find_by_email("george@email.com")
end

Given /^I match with "(.*)"$/ do |name|
    page.find(".user", :text => name).find(".btn").click
end

Then /^I should see "(.*)" in the pending matches dropdown$/ do |name|
    expect(page.find(".pending-matches-container")).to have_text(name)
end

Then /^I should see "(.*)" in the incoming matches dropdown$/ do |name|
    expect(page.find(".incoming-matches-container")).to have_text(name)
end

And /^I accept the invitation from "(.*)"$/ do |name|
    page.find(".user", :text => name).find(".btn", :text => "Accept").click
end
