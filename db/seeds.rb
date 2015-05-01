require "digest"

############################################################
# Users
############################################################

users = [
    {
    :email => "ben@bitdiddle.com",
    :password => "bitsrocks",
    :username => "ben",
    :political_blurb => "I like Ron Bitdiddle",
    :political_hero => "Ron Bitdiddle",
    :political_spectrum => 2
    },
    {
    :email => "generic@email.com",
    :password => "asdfasdf",
    :username => "generic",
    :political_blurb => "Go generic party!",
    :political_hero => "Generic George",
    :political_spectrum => 1
    },
    {
    :email => "bob@schmitt.com",
    :password => "imboring",
    :username => "bob",
    :political_blurb => "Bob for county clerk!",
    :political_hero => "ME!",
    :political_spectrum => 3
    },
    {
    :email => "genericasiankid@gmail.com",
    :password => "password",
    :username => "generickid",
    :political_blurb => "Bob embezzles from widget farmers!",
    :political_hero => "Not Bob!",
    :political_spectrum => 1
    },
    {
    :email => "rosenthal@policy.com",
    :password => "publicpolicy",
    :username => "rosenthal",
    :political_blurb => "Discuss your view on PenPal Gladiators!",
    :political_hero => "Thomas Jefferson",
    :political_spectrum => 2
    }
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
end
# Climate question 1
climate = Topic.find_by_name("Climate")
climate_question = climate.survey_questions.create(:text => "What is your view on climate change?", :index => 0)
responses = [
    {
    :index => 0,
    :text => "It is happening and is caused directly by humans",
    :summary_text => "Climate change is happening and is caused directly by humans."
    },
    {
    :index => 1,
    :text => "It is happening but is not being caused by humans",
    :summary_text => "Climate change is happening but is not being caused by humans."
    },
    {
    :index => 2,
    :text => "It is happening but it is part of a natural cycle",
    :summary_text => "Climate change is happening but it is part of a natural cycle."
    },
    {
    :index => 3,
    :text => "It is not happening",
    :summary_text => "Climate change is not happening."
    }
].map { |data| climate_question.survey_responses.create data }
ResponseWeight.create :response1_id => responses[0].id, :response2_id => responses[1].id, :weight => 0.75
ResponseWeight.create :response1_id => responses[0].id, :response2_id => responses[2].id, :weight => 0.75
ResponseWeight.create :response1_id => responses[0].id, :response2_id => responses[3].id, :weight => 0.25
ResponseWeight.create :response1_id => responses[1].id, :response2_id => responses[2].id, :weight => 0.75
ResponseWeight.create :response1_id => responses[1].id, :response2_id => responses[3].id, :weight => 1.25
ResponseWeight.create :response1_id => responses[2].id, :response2_id => responses[3].id, :weight => 1.5

# Climate question 2
climate_question = climate.survey_questions.create(:text => "What is the best way to prevent climate change in the long term?", :index => 1)
responses = [
    {
    :index => 0,
    :text => "It is not a threat",
    :summary_text => "Climate change is not a threat."
    },
    {
    :index => 1,
    :text => "We must consume fewer resources to reduce our ecological footprint",
    :summary_text => "We must consume fewer resources to reduce our ecological footprint."
    },
    {
    :index => 2,
    :text => "New, sustainable technology is vital to preventing environmental damage",
    :summary_text => "New, sustainable technology is vital to preventing environmental damage."
    }
].map { |data| climate_question.survey_responses.create data }
ResponseWeight.create :response1_id => responses[0].id, :response2_id => responses[1].id, :weight => 1
ResponseWeight.create :response1_id => responses[0].id, :response2_id => responses[2].id, :weight => 1
ResponseWeight.create :response1_id => responses[1].id, :response2_id => responses[2].id, :weight => 1.5

# Seed education survey questions.

topic = Topic.find_by_name "Education"

survey_question = topic.survey_questions.create :text => "Should higher education be free for everyone?", :index => 0
survey_responses = [{
    :text => "Yes",
    :summary_text => "I think higher education should not be free for everyone.",
    :index => 0
},
{
    :text => "No",
    :summary_text => "I think higher education should be free for everyone.",
    :index => 1
}].map { |data| survey_question.survey_responses.create data }

ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[1].id, :weight => 1

survey_question = topic.survey_questions.create :text => "Which of the following do you agree most strongly with?", :index => 1
survey_responses = [{
    :text => "Teachers should dedicate their time to helping struggling students catch up if it means neglecting and possibly impeding advancing students' learning",
    :summary_text => "I think teachers should dedicate their time to helping struggling students catch up if it means neglecting and possibly impeding advancing students' learning.",
    :index => 0
},
{
    :text => "Teachers should dedicate their time to helping advancing students excel even if it means neglecting and possibly leaving behind struggling students",
    :summary_text => "I think teachers should dedicate their time to helping advancing students excel even if it means neglecting and possibly leaving behind struggling students.",
    :index => 1
},
{
    :text => "Teachers should ensure that all their students are on the same page so that this problem isn't a problem",
    :summary_text => "I think teachers should ensure that all their students are on the same page so that this problem isn't a problem.",
    :index => 2
},
{
    :text => "Students should be taught at a rate in which they do not fall behind and can excel if they desire to, even if this means sometimes splitting up classes for parts of the day",
    :summary_text => "I think students should be taught at a rate in which they do not fall behind and can excel if they desire to, even if this means sometimes splitting up classes for parts of the day.",
    :index => 3
}].map { |data| survey_question.survey_responses.create data }

ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[1].id, :weight => 1
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[2].id, :weight => 0.5
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[3].id, :weight => 0.25
ResponseWeight.create :response1_id => survey_responses[1].id, :response2_id => survey_responses[2].id, :weight => 1
ResponseWeight.create :response1_id => survey_responses[1].id, :response2_id => survey_responses[3].id, :weight => 0.5
ResponseWeight.create :response1_id => survey_responses[2].id, :response2_id => survey_responses[3].id, :weight => 1

# economy question 1
economy = Topic.find_by_name("Economy")
economy_question = economy.survey_questions.create(:text => "What should be done to fix the financial crisis?", :index => 0)
responses = [
    {
    :index => 0,
    :text => "Raise taxes",
    :summary_text => "More taxes are needed to balance the economy."
    },
    {
    :index => 1,
    :text => "Increase Federal Reserve production",
    :summary_text => "We can fix the financial crisis by printing more money."
    },
    {
    :index => 2,
    :text => "What financial crisis?",
    :summary_text => "I don't believe that we are in a financial crisis."
    }
].map { |data| economy_question.survey_responses.create data }
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[1].id, :weight => 1
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[2].id, :weight => 1
ResponseWeight.create :response1_id => survey_responses[1].id, :response2_id => survey_responses[2].id, :weight => 1.5

# economy question 2
economy_question = economy.survey_questions.create(:text => "Which of the following should we do?", :index => 1)
responses = [
    {
    :index => 0,
    :text => "Invest in renewable energy (spend more now but becoming less reliant on foreign fuel later)",
    :summary_text => "I believe we should invest in renewable energy now so that we are less reliant on foreign oil later.."
    },
    {
    :index => 1,
    :text => "Invest in the cheap procurement of non-renewable energy (spend less now and perhaps have to invest in renewable fuel later)",
    :summary_text => "I believe that we should invest in cheap sources of energy now, even if it means looking for alternatives when we desperately need them later."
    }
].map { |data| economy_question.survey_responses.create data }
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[1].id, :weight => 1

# technology question 1
technology = Topic.find_by_name("Technology")
technology_question = technology.survey_questions.create(:text => "What is your view on being forced to give up passwords encrypting personal data?", :index => 0)
responses = [
    {
    :index => 0,
    :text => "It should be legal for anyone to guard and protect their sensitive information; encrypting my financial information is no different than keeping a ledger in code",
    :summary_text => "People have the right to making their data private by encrypting it and the government should not be able to compel a user to decrypt their data."
    },
    {
    :index => 1,
    :text => "The government needs to have the ability to read electronic communications and documents for the sake of national security",
    :summary_text => "The government should be able to compel people to decrypt their personal data in the name of national security."
    }
].map { |data| technology_question.survey_responses.create data }
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[1].id, :weight => 1

# technology question 2
technology_question = technology.survey_questions.create(:text => "What is your view on privacy in the age of social networking?", :index => 1)
responses = [
    {
    :index => 0,
    :text => "Companies like Facebook, Twitter, and Google need to harvest their users' data to survive: it is their business model",
    :summary_text => "Companies like Facebook, Twitter, and Google need to harvest their users' data to survive: it is their business model."
    },
    {
    :index => 1,
    :text => "Companies need to make their use of their users' data more transparent and give users a way to opt out of data harvesting and selling, even if companies begin charging their users for services",
    :summary_text => "Companies need to make their use of their users' data more transparent and give users a way to opt out of data harvesting and selling, even if companies begin charging their users for services."
    },
    {
    :index => 2,
    :text => "Tech companies have a duty to their users to keep their users' interests first.  Selling users' information to advertisers and other organizations is immoral",
    :summary_text => "Tech companies have a duty to their users to keep their users' interests first.  Selling users' information to advertisers and other organizations is immoral."
    }
].map { |data| technology_question.survey_responses.create data }
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[1].id, :weight => 1
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[2].id, :weight => 1
ResponseWeight.create :response1_id => survey_responses[1].id, :response2_id => survey_responses[2].id, :weight => 1.5

# LGBT Rights question 1
lgbt = Topic.find_by_name("LGBT Rights")
lgbt_question = lgbt.survey_questions.create(:text => "Do you support LGBT rights?", :index => 0)
responses = [
    {
    :index => 0,
    :text => "Yes",
    :summary_text => "I support LGBT rights."
    },
    {
    :index => 1,
    :text => "No",
    :summary_text => "I do not support LGBT rights."
    }
].map { |data| lgbt_question.survey_responses.create data }
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[1].id, :weight => 1
# LGBT Rights question 2
lgbt_question = lgbt.survey_questions.create(:text => "What level of government should decide the legality of same-sex marriage?", :index => 1)
responses = [
    {
    :index => 0,
    :text => "City/Local",
    :summary_text => "City/Local government should decide the legality of same-sex marriage."
    },
    {
    :index => 1,
    :text => "State",
    :summary_text => "State government should decide the legality of same-sex marriage."
    },
    {
    :index => 2,
    :text => "National",
    :summary_text => "National government should decide the legality of same-sex marriage."
    },
    {
    :index => 3,
    :text => "International",
    :summary_text => "International law should decide the legality of same-sex marriage."
    }
].map { |data| lgbt_question.survey_responses.create data }
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[1].id, :weight => 0.75
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[2].id, :weight => 0.75
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[3].id, :weight => 0.25
ResponseWeight.create :response1_id => survey_responses[1].id, :response2_id => survey_responses[2].id, :weight => 0.75
ResponseWeight.create :response1_id => survey_responses[1].id, :response2_id => survey_responses[3].id, :weight => 1.25
ResponseWeight.create :response1_id => survey_responses[2].id, :response2_id => survey_responses[3].id, :weight => 1.5
# LGBT Rights question 3
lgbt_question = lgbt.survey_questions.create(:text => "What rights should married same-sex couples have?", :index => 2)
responses = [
    {
    :index => 0,
    :text => "The same rights as heterosexual married couples",
    :summary_text => "Married same-sex couples should have the same rights as heterosexual married couples."
    },
    {
    :index => 1,
    :text => "The rights granted in a civil union",
    :summary_text => "Married same-sex couples should have the rights granted in a civil union."
    },
    {
    :index => 2,
    :text => "No rights, as they should not be allowed to get married",
    :summary_text => "Married same-sex couples should have no rights, as they should not be allowed to get married."
    }
].map { |data| lgbt_question.survey_responses.create data }
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[1].id, :weight => 1
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[2].id, :weight => 1
ResponseWeight.create :response1_id => survey_responses[1].id, :response2_id => survey_responses[2].id, :weight => 1.5

# immigration question 1
immigration = Topic.find_by_name("Immigration")
immigration_question = immigration.survey_questions.create(:text => "What best describes your views about the immigration process (for general-case immigrants) into the United States? ", :index => 0)
responses = [
    {
    :index => 0,
    :text => "All immigrants should be allowed, no questions asked",
    :summary_text => "All immigrants should be allowed, no questions asked."
    },
    {
    :index => 1,
    :text => "Immigrants should go through a screening process and then be allowed or denied entry to the United States",
    :summary_text => "Immigrants should go through a screening process and then be allowed or denied entry to the United States."
    },
    {
    :index => 2,
    :text => "No immigrants should be allowed, no questions asked",
    :summary_text => "No immigrants should be allowed, no questions asked."
    }
].map { |data| immigration_question.survey_responses.create data }
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[1].id, :weight => 1
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[2].id, :weight => 1
ResponseWeight.create :response1_id => survey_responses[1].id, :response2_id => survey_responses[2].id, :weight => 1.5

immigration_question = immigration.survey_questions.create(:text => "What best describes your views about how to deal with the influx of immigrants from Mexico and other second and third-world countries? ", :index => 1)
responses = [
    {
    :index => 0,
    :text => "Close the borders",
    :summary_text => "Close the borders."
    },
    {
    :index => 1,
    :text => "Allow only immigrants who can show that they have a job lined up in the United States",
    :summary_text => "Allow only immigrants who can show that they have a job lined up in the United States."
    },
    {
    :index => 2,
    :text => "Allow only a certain number of immigrants per unit time",
    :summary_text => "Allow only a certain number of immigrants per unit time."
    },
    {
    :index => 3,
    :text => "Allow all immigrants who have no criminal history",
    :summary_text => "Allow all immigrants who have no criminal history"
    },
    {
    :index => 4,
    :text => "Allow all immigrants, no questions asked",
    :summary_text => "Allow all immigrants, no questions asked"
    }
].map { |data| immigration_question.survey_responses.create data }
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[1].id, :weight => 1
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[2].id, :weight => 0.5
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[3].id, :weight => 0.25
ResponseWeight.create :response1_id => survey_responses[1].id, :response2_id => survey_responses[2].id, :weight => 1
ResponseWeight.create :response1_id => survey_responses[1].id, :response2_id => survey_responses[3].id, :weight => 0.5
ResponseWeight.create :response1_id => survey_responses[2].id, :response2_id => survey_responses[3].id, :weight => 1

# Seed foreign policy survey questions -- done
foreign = Topic.find_by_name("Foreign Policy")
foreign_question = foreign.survey_questions.create(:text => "What best describes your view on the United States' relations with the Middle East?", :index => 0)
responses = [
    {
    :index => 0,
    :text => "The United States should be responsible for bringing democracy to the world",
    :summary_text => "The United States should be responsible for bringing democracy to the world."
    },
    {
    :index => 1,
    :text => "The United States has a vested interest in the stability of the Middle East for economic reasons, so the United States should do its best to stabilize Middle Eastern countries' governments",
    :summary_text => "The United States has a vested interest in the stability of the Middle East for economic reasons, so the United States should do its best to stabilize Middle Eastern countries' governments."
    },
    {
    :index => 2,
    :text => "The United States has no business getting involved in another country's affairs",
    :summary_text => "The United States has no business getting involved in another country's affairs"
    }
].map { |data| foreign_question.survey_responses.create data }
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[1].id, :weight => 1
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[2].id, :weight => 1
ResponseWeight.create :response1_id => survey_responses[1].id, :response2_id => survey_responses[2].id, :weight => 1.5

# Seed religion survey questions.

topic = Topic.find_by_name "Religion"

survey_question = topic.survey_questions.create :text => "Are your beliefs aligned with any mainstream religion (e.g. Christianity, Judaism, Buddhism, Islam, Hinduism, etc.)", :index => 1
survey_responses = [{
    :text => "Yes",
    :summary_text => "I am religious.",
    :index => 0
},
{
    :text => "No",
    :summary_text => "I am not religious.",
    :index => 1
},
{
    :text => "I don't know; I'm agnostic",
    :summary_text => "I am agnostic.",
    :index => 2
}].map { |data| survey_question.survey_responses.create data }

ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[1].id, :weight => 1
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[2].id, :weight => 1
ResponseWeight.create :response1_id => survey_responses[1].id, :response2_id => survey_responses[2].id, :weight => 1.5


survey_question = topic.survey_questions.create :text => "How much control should the government have over religious institutions?", :index => 2
survey_responses = [{
    :text => "No control",
    :summary_text => "Government should have no control over religious institutions.",
    :index => 0
},
{
    :text => "Some control over religious events taking place on public property",
    :summary_text => "Government should have some control over religious events taking place on public property.",
    :index => 1
},
{
    :text => "Control over events where the public has access",
    :summary_text => "Government should have control over events where the public has access.",
    :index => 2
},
{
    :text => "Control over all religious events",
    :summary_text => "Government should have control over all religious events.",
    :index => 3
}].map { |data| survey_question.survey_responses.create data }

ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[1].id, :weight => 0.75
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[2].id, :weight => 0.75
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[3].id, :weight => 0.25
ResponseWeight.create :response1_id => survey_responses[1].id, :response2_id => survey_responses[2].id, :weight => 0.75
ResponseWeight.create :response1_id => survey_responses[1].id, :response2_id => survey_responses[3].id, :weight => 1.25
ResponseWeight.create :response1_id => survey_responses[2].id, :response2_id => survey_responses[3].id, :weight => 1.5

# Philosophy question 1
philosophy = Topic.find_by_name("Philosophy")
philosophy_question = philosophy.survey_questions.create(:text => "Do you believe that all lives have a higher purpose/calling?", :index => 0)
responses = [
    {
    :index => 0,
    :text => "Yes",
    :summary_text => "I believe that all lives have a higher purpose/calling"
    },
    {
    :index => 1,
    :text => "No",
    :summary_text => "I do not believe that all lives have a higher purpose/calling"
    }
].map { |data| philosophy_question.survey_responses.create data }
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[1].id, :weight => 0.5

# philosophy question 2
philosophy = Topic.find_by_name("Philosophy")
philosophy_question = philosophy.survey_questions.create(:text => "How much control do people have over their own lives?", :index => 1)
responses = [
    {
    :index => 0,
    :text => "Everyone has free will.",
    :summary_text => "Everyone has free will."
    },
    {
    :index => 1,
    :text => "Everything is deterministic.",
    :summary_text => "Everything is deterministic."
    },
    {
    :index => 2,
    :text => "While some things are in the our control, other aspects may be out of our control.",
    :summary_text => "While some things are in the our control, other aspects may be out of our control."
    }
].map { |data| philosophy_question.survey_responses.create data }
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[1].id, :weight => 1
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[2].id, :weight => 1
ResponseWeight.create :response1_id => survey_responses[1].id, :response2_id => survey_responses[2].id, :weight => 1.5

# Criminal Law Seed
criminallaw = Topic.find_by_name("Criminal Law")
criminallaw_question = criminallaw.survey_questions.create(:text => "Do you believe in the death penalty as a form of criminal justice?", :index => 0)
responses = [
    {
    :index => 0,
    :text => "Yes",
    :summary_text => "I believe in the death penalty as a form of criminal justice."
    },
    {
    :index => 1,
    :text => "No",
    :summary_text => "I do not believe in the death penalty as a form of criminal justice."
    }
].map { |data| criminallaw_question.survey_responses.create data }
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[1].id, :weight => 0.5

criminallaw_question = criminallaw.survey_questions.create(:text => "Which of the following best describes your opinion of the American prison system?", :index => 1)
responses = [
    {
    :index => 0,
    :text => "Private, for-profit prisons are necessary",
    :summary_text => "Private, for-profit prisons are necessary."
    },
    {
    :index => 1,
    :text => "Non-violent offenders should not be imprisoned",
    :summary_text => "Non-violent offenders should not be imprisoned."
    },
    {
    :index => 2,
    :text => "The US needs to focus on rehabilitation over incarceration",
    :summary_text => "The US needs to focus on rehabilitation over incarceration."
    },
    {
    :index => 3,
    :text => "The US prison system is in dire need of overhaul",
    :summary_text => "The US prison system is in dire need of overhaul."
    }
].map { |data| criminallaw_question.survey_responses.create data }
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[1].id, :weight => 0.75
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[2].id, :weight => 0.75
ResponseWeight.create :response1_id => survey_responses[0].id, :response2_id => survey_responses[3].id, :weight => 0.25
ResponseWeight.create :response1_id => survey_responses[1].id, :response2_id => survey_responses[2].id, :weight => 0.75
ResponseWeight.create :response1_id => survey_responses[1].id, :response2_id => survey_responses[3].id, :weight => 1.25
ResponseWeight.create :response1_id => survey_responses[2].id, :response2_id => survey_responses[3].id, :weight => 1.5

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
response = Topic.find_by_name("Philosophy").survey_questions.find_by_index(1).survey_responses.find_by_index(0)
UserSurveyResponse.create(:user => bob, :survey_response => response)

wenson = User.find_by_email("genericasiankid@gmail.com")
response = Topic.find_by_name("Education").survey_questions.find_by_index(1).survey_responses.find_by_index(1)
UserSurveyResponse.create(:user => wenson, :survey_response => response)

rosenthal = User.find_by_email("rosenthal@policy.com")
response = Topic.find_by_name("Climate").survey_questions.find_by_index(1).survey_responses.find_by_index(1)
UserSurveyResponse.create(:user => rosenthal, :survey_response => response)

####################################################
# Create new test arenas, conversations, and posts
####################################################

arena = ben.arenas.create :user1 => ben, :user2 => bob
conversation = arena.conversations.create :title => "Why is the US education system terrible?"
conversation.posts.create :text => "It all starts in the home. If the parents don't care, no one will.", :author => ben
conversation.posts.create :text => "No, it's actually because the unions have too much power.", :author => bob
conversation.posts.create :text => "You, sir, are an idiot. This is really why the education system sucks. Because people like you go on and on about unions and never do anything to address the real problems at hand. Damnit Bob, get it together.", :author => ben
conversation.user_did_edit_resolution bob.id, "The reality is that most children will not play professional sports, sing on Broadway or star in a film. The reality is that the most in-demand, high-paying college degrees are in science, technology, engineering and math (STEM) fields. But to engage our students in STEM, we must spark an early interest in math and science."

arena = ben.arenas.create :user1 => ben, :user2 => wenson
conversation = arena.conversations.create :title => "What is our role in mitigating climate change?"
conversation.posts.create :text => "I believe everyone should go back to living in caves.", :author => ben
conversation.posts.create :text => "No you.", :author => wenson
conversation.user_did_edit_resolution ben.id, "The very idea of thinking about how to adapt to drastic environmental changes was basically considered taboo, an acknowledgment of defeat. 'Earlier on, you wouldn't use the 'A' word in polite conversation,' said Henry D. Jacoby, a professor at the Sloan School of Management at M.I.T. and a climate policy researcher - the 'A' word being 'adaptation.' 'People thought you weren't serious about mitigation. 'Oh, you're giving up.' But climate change defied that playbook. There was no immediate crisis to point to -- no bird eggs laced with DDT, no acid rain corroding city monuments. There was no one industry to target or overwhelming constituency to push legislators."

conversation = arena.conversations.create :title => "Is technology to blame for the housing crisis in SF?"
conversation.posts.create :text => "What housing crisis?", :author => wenson
conversation.user_did_edit_resolution wenson.id, "While the technology boom has bred hostility, it has also brought San Francisco undeniable benefits. Mayor Edwin M. Lee credits the technology sector with helping to pull the city out of the recession, creating jobs and nourishing a thriving economy that is the envy of cash-starved cities across the country."

arena = ben.arenas.create :user1 => ben, :user2 => rosenthal
conversation = arena.conversations.create :title => "This conversation should be blank!"
