require "digest"

############################################################
# Users
############################################################

users = [
    { :email => "ben@bitdiddle.com", :password => "bitsrocks" },
    { :email => "generic@email.com", :password => "asdfasdf" },
    { :email => "bob@schmitt.com", :password => "imboring" },
    { :email => "genericasiankid@gmail.com", :password => "password" },
    { :email => "rosenthal@policy.com", :password => "publicpolicy" }
]

users.each do |u|
    User.create!(u)
end

############################################################
# Survey Topics, Questions, and Responses
############################################################

responses = [
    { :text => "Yes", :index => 0 },
    { :text => "No", :index => 1}
]

topics = [
    { :name => "Climate", :icon => "/assets/topic_icons/climate.png"},
    { :name => "Education", :icon => "/assets/topic_icons/education.png"},
    { :name => "Economy", :icon => "/assets/topic_icons/money.png"},
    { :name => "Technology", :icon => "/assets/topic_icons/technology.png"},
    { :name => "LGBT Rights", :icon => "/assets/topic_icons/lgbt.png"},
    { :name => "Immigration", :icon => "/assets/topic_icons/immigration.png"},
    { :name => "Foreign Policy", :icon => "/assets/topic_icons/international.png"},
    { :name => "Religion", :icon => "/assets/topic_icons/religion.png"},
    { :name => "Philosophy", :icon => "/assets/topic_icons/philosophy.png"},
    { :name => "Criminal Law", :icon => "/assets/topic_icons/justice.png"},
]

topics.each do |t|
    topic = Topic.create!(t)

    survey_question1 = topic.survey_questions.create(:text => "Do you hate #{topic.name}?", :index => 1)
    survey_question2 = topic.survey_questions.create(:text => "Do you care about #{topic.name}?", :index => 3)

    responses.each do |r|
        verb1 = r[:text] == "Yes" ? "hate" : "don't hate"
        verb2 = r[:text] == "Yes" ? "care" : "don't care"
        actual_response1 = r.clone
        actual_response2 = r.clone
        actual_response1[:summary_text] = "I #{verb1} #{topic.name}."
        actual_response2[:summary_text] = "I #{verb2} about #{topic.name}."
        survey_question1.survey_responses.create(actual_response1)
        survey_question2.survey_responses.create(actual_response2)
    end
end

#More complicated responses
responses = [
    {
        :text => "Education in the US is the best",
        :summary_text => "I believe that education in the US is the best.",
        :index => 2
    },
    {
        :text => "Need to fund education less",
        :summary_text => "I believe that we need to fund education less.",
        :index => 1
    },
    {
        :text => "Need more focus on STEM",
        :summary_text => "I believe that there needs to be more focus on STEM.",
        :index => 0
    },
    {
        :text => "Too many college grads, need to raise tuition fee",
        :summary_text => "I believe that there are too many college gradudates, therefore, we need to raise the tuition fees.",
        :index => 3
    }
]

education = Topic.find_by_name("Education")
survey_question = education.survey_questions.create(:text => "What's your view on US higher education?", :index => 2)
responses.each do |r|
    survey_question.survey_responses.create(r)
end

############################################################
# Users <-> survey responses through user survey responses
############################################################


ben = User.find_by_email("ben@bitdiddle.com")
response = Topic.find_by_name("Climate").survey_questions.find_by_index(1).survey_responses.find_by_index(0)
UserSurveyResponse.create(:user => ben, :survey_response => response)

nick = User.find_by_email("generic@email.com")
response = Topic.find_by_name("Philosophy").survey_questions.find_by_index(1).survey_responses.find_by_index(1)
UserSurveyResponse.create(:user => nick, :survey_response => response)

bob = User.find_by_email("bob@schmitt.com")
response = Topic.find_by_name("LGBT Rights").survey_questions.find_by_index(1).survey_responses.find_by_index(0)
UserSurveyResponse.create(:user => bob, :survey_response => response)

wenson = User.find_by_email("genericasiankid@gmail.com")
response = Topic.find_by_name("Education").survey_questions.find_by_index(1).survey_responses.find_by_index(1)
UserSurveyResponse.create(:user => wenson, :survey_response => response)

rosenthal = User.find_by_email("rosenthal@policy.com")
response = Topic.find_by_name("Foreign Policy").survey_questions.find_by_index(1).survey_responses.find_by_index(1)
UserSurveyResponse.create(:user => rosenthal, :survey_response => response)
