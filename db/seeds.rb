require "digest"

############################################################
# Users
############################################################

sha256 = Digest::SHA256.new

users = [
    { :email => "ben@bitdiddle.com", :password => sha256.base64digest("bitsrocks") },
    { :email => "generic@email.com", :password => sha256.base64digest("asdfasdf") },
    { :email => "bob@schmitt.com", :password => sha256.base64digest("imboring") },
    { :email => "genericasiankid@gmail.com", :password => sha256.base64digest("password") },
    { :email => "rosenthal@policy.com", :password => sha256.base64digest("publicpolicy") }
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
        survey_question1.survey_responses.create(r)
        survey_question2.survey_responses.create(r)
    end
end

#More complicated responses
responses = [
 {:text => "Education in the US is the best", :index => 2},
 {:text => "Need to fund education less", :index => 1},
 {:text => "Need more focus on STEM", :index => 0},
 {:text => "Too many college grads, need to raise tuition fee", :index => 3}
]

education = Topic.find_by_name("Education")
survey_question = education.survey_questions.create(:text => "What's your view on US higher education?", :index => 2)
responses.each do |r|
 survey_question.survey_responses.create(r)
end

############################################################
# Users <-> survey responses through user survey responses
############################################################


#ben = User.find_by_email("ben@bitdiddle.com")
#response = Topic.find_by_name("Climate").survey_questions.find_by_index(1).survey_responses.find_by_index(0)
#UserSurveyResponse.create(:user => ben, :survey_response => response)

#nick = User.find_by_email("generic@email.com")
#response = Topic.find_by_name("Philosophy").survey_questions.find_by_index(1).survey_responses.find_by_index(1)
#UserSurveyResponse.create(:user => nick, :survey_response => response)

#bob = User.find_by_email("bob@schmitt.com")
#response = Topic.find_by_name("LGBT Rights").survey_questions.find_by_index(1).survey_responses.find_by_index(0)
#UserSurveyResponse.create(:user => bob, :survey_response => response)

#wenson = User.find_by_email("genericasiankid@gmail.com")
#response = Topic.find_by_name("Education").survey_questions.find_by_index(1).survey_responses.find_by_index(1)
#UserSurveyResponse.create(:user => wenson, :survey_response => response)

#rosenthal = User.find_by_email("rosenthal@policy.com")
#response = Topic.find_by_name("Foreign Policy").survey_questions.find_by_index(1).survey_responses.find_by_index(1)
#UserSurveyResponse.create(:user => rosenthal, :survey_response => response)