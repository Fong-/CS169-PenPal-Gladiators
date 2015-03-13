Before("@seed_topics") do
    topics = [
        { :name => "Climate", :icon => "/assets/topic_icons/climate.png" },
        { :name => "Education", :icon => "/assets/topic_icons/education.png" },
        { :name => "Economy", :icon => "/assets/topic_icons/money.png" },
        { :name => "Technology", :icon => "/assets/topic_icons/technology.png" },
        { :name => "LGBT Rights", :icon => "/assets/topic_icons/lgbt.png" },
        { :name => "Immigration Law", :icon => "/assets/topic_icons/immigration.png" },
        { :name => "Foreign Policy", :icon => "/assets/topic_icons/international.png" },
        { :name => "Religion", :icon => "/assets/topic_icons/religion.png" },
        { :name => "Philosophy", :icon => "/assets/topic_icons/philosophy.png" },
        { :name => "Criminal Law", :icon => "/assets/topic_icons/justice.png" },
    ]

    topics.each do |t|
        topic = Topic.create!(t)
    end
end
