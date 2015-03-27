When /I click topics (.*)/ do |topics|
    topics.split(", ").each do |topic_string|
        topic = topic_string[1..-2]
        topic.gsub!("\"", "")
        topic.gsub!(" ", "_")
        page.find("##{topic.downcase}").click()
    end
end
