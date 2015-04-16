Given /^an arena is set up with posts from (.*) ago$/ do |age_strings|
    age_strings = age_strings.split(",").map {|c| c.strip}
    users = [
        User.create(:email => "alice@example.com", :password => "12345678"),
        User.create(:email => "bob@example.com", :password => "12345678")
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


Given /^an empty arena is set up$/ do
    first = User.create(:email => "alice@example.com", :password => "12345678")
    second = User.create(:email => "bob@example.com", :password => "12345678")
    arena = first.arenas.create :user1 => first, :user2 => second
    conversation = arena.conversations.create :title => "Why do you never post in here?"
end
