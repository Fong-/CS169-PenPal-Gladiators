require "digest"

############################################################
# Users
############################################################

users = [
    {
    :email => "ben@bitdiddle.com",
    :password => "password",
    :username => "ben",
    :political_blurb => "I like Ron Bitdiddle",
    :political_hero => "Ron Bitdiddle",
    :political_spectrum => 2
    },
    {
    :email => "generic@email.com",
    :password => "password",
    :username => "generic",
    :political_blurb => "Go generic party!",
    :political_hero => "Generic George",
    :political_spectrum => 1
    },
    {
    :email => "bob@schmitt.com",
    :password => "password",
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
    :password => "password",
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
conversation = arena.conversations.create :title => "What are the root problems with the US education system?"
conversation.posts.create :text => "For most of American history, parents could expect that their children would, on average, be much better educated than they were. But that is no longer true. This development has serious consequences for the economy.", :author => ben
conversation.posts.create :text => "Hi Ben! I have a few words to say about education here in the US. Companies pay better-educated people higher wages because they are more productive. The premium that employers pay to a college graduate compared with that to a high school graduate has soared since 1970, because of higher demand for technical and communication skills at the top of the scale and a collapse in demand for unskilled and semiskilled workers at the bottom.", :author => bob
conversation.posts.create :text => "There are numerous causes of the less-than-satisfying economic growth in America: the retirement of the baby boomers, the withdrawal of working-age men from the labor force, the relentless rise in the inequality of the income distribution and, as I have written about elsewhere, a slowdown in technological innovation.", :author => ben
conversation.user_did_edit_resolution bob.id, "The reality is that most children will not play professional sports, sing on Broadway or star in a film. The reality is that the most in-demand, high-paying college degrees are in science, technology, engineering and math (STEM) fields. But to engage our students in STEM, we must spark an early interest in math and science."

arena = ben.arenas.create :user1 => ben, :user2 => wenson
conversation = arena.conversations.create :title => "What is our role in mitigating climate change?"
conversation.posts.create :text => "I believe that if humans are to survive for another century, we must consume less. With millions of households across the country struggling to have enough to eat, and millions of tons of food being tossed in the garbage, food waste is increasingly being seen as a serious environmental and economic issue.", :author => ben
conversation.posts.create :text => "I mainly agree with you, and I'd also like to add that the food discarded by retailers and consumers in the most developed countries would be more than enough to feed all of the world's 870 million hungry people, according to the Food and Agriculture Organization of the United Nations.", :author => wenson
conversation.posts.create :text => "Furthermore, the problem is expected to grow worse as the world's population increases, the report found. By 2030, when the global middle class expands, consumer food waste will cost $600 billion a year, unless actions are taken to reduce the waste, according to the report.", :author => wenson
conversation.user_did_edit_resolution ben.id, "The very idea of thinking about how to adapt to drastic environmental changes was basically considered taboo, an acknowledgment of defeat. 'Earlier on, you wouldn't use the 'A' word in polite conversation,' said Henry D. Jacoby, a professor at the Sloan School of Management at M.I.T. and a climate policy researcher - the 'A' word being 'adaptation.' 'People thought you weren't serious about mitigation. 'Oh, you're giving up.' But climate change defied that playbook. There was no immediate crisis to point to -- no bird eggs laced with DDT, no acid rain corroding city monuments. There was no one industry to target or overwhelming constituency to push legislators."

conversation = arena.conversations.create :title => "Is technology to blame for the housing crisis in SF?"
conversation.posts.create :text => "The locals say they don't like the tech folks pouring into town to work at places like Google. They're insular. They're driving up housing prices. And they fear those newcomers are more like invaders than people trying to fit into their new community. For once, this is not about San Francisco.", :author => wenson
conversation.user_did_edit_resolution wenson.id, "While the technology boom has bred hostility, it has also brought San Francisco undeniable benefits. Mayor Edwin M. Lee credits the technology sector with helping to pull the city out of the recession, creating jobs and nourishing a thriving economy that is the envy of cash-starved cities across the country."

arena = ben.arenas.create :user1 => ben, :user2 => rosenthal
conversation = arena.conversations.create :title => "Can capital punishment be justified on moral or practical grounds?"
conversation.posts.create :text => "When the United States at last abandons the abhorrent practice of capital punishment, the early years of the 21st century will stand out as a peculiar period during which otherwise reasonable people hotly debated how to kill other people while inflicting the least amount of constitutionally acceptable pain.", :author => rosenthal
conversation.user_did_edit_resolution rosenthal.id, "Executions are brutal, savage events, and nothing the state tries to do can mask that reality. Nor should it. If we as a society want to carry out executions, we should be willing to face the fact that the state is committing a horrendous brutality on our behalf."

arena = nick.arenas.create :user1 => nick, :user2 => wenson
conversation = arena.conversations.create :title => "Should public schools be allowed to teach creationism as an alternative to evolution?"
conversation.posts.create :text => "When public-school students enrolled in Texas' largest charter program open their biology workbooks, they will read that the fossil record is \"sketchy.\" That evolution is \"dogma\" and an \"unproved theory\" with no experimental basis. They will be told that leading scientists dispute the mechanisms of evolution and the age of the Earth. These are all lies.", :author => nick
conversation.user_did_edit_resolution wenson.id, "Bringing creationism into a classroom by undermining evolution and \"noting ... competing theories\" is still unconstitutional. What's more, contrary to Gonzalez's statement, teaching about supernatural creation in the section on the origins of life is doing far more than noting competing theories."

arena = wenson.arenas.create :user1 => wenson, :user2 => rosenthal
conversation = arena.conversations.create :title => "Does the US have any moral obligation to accept undocumented immigrants?"
conversation.posts.create :text => "Something happened while the immigration system in the United States got broken, something that should change the way we talk about fixing it. Years went by, and nature took its course. More than 11 million unauthorized immigrants settled into our communities; many formed families and had children. Now at least one of every 15 children living in the United States has an unauthorized parent, and nearly all of those children are native-born United States citizens. Think of that statistic, one in 15, the next time you drive by a school or a playground. Think of those children living with the knowledge that the federal government can take their parents away. Common sense tells you that the threat of a parent's deportation will exact a terrible price.", :author => wenson
conversation.user_did_edit_resolution rosenthal.id, "The American sense of fairness and system of justice have long embraced the notion that the \"sins of the father\" should not be visited on the children. Reasonable minds can debate whether there is blame to attach to the parents. There is no reasonable case to be made for punishing their children, who are citizens of the United States. Yet they are punished every day."

arena = bob.arenas.create :user1 => bob, :user2 => wenson
conversation = arena.conversations.create :title => "Is US military intervention against ISIL justified in the middle east?"
conversation.posts.create :text => "The impulse to create a joint force originates in a yearning for greater Arab unity that has haunted Middle Eastern political culture since the short-lived Arab Kingdom of Syria was crushed by the French in 1920, in the aftermath of World War I. The idea of a united Arab force also promises to bring together the financial resources of the Persian Gulf states with the manpower of Egypt, Jordan and Morocco. This responds to traditional Arab frustrations about the separation of large populations from major oil revenues (except in Iraq).", :author => wenson
conversation.user_did_edit_resolution bob.id, "There will have to be a significant transformation of relations between Arab governments. Otherwise, as wags have already noted, the joint Arab force could be seen as a \"triple oxymoron.\" Not \"joint,\" because of divisions among its members. Not \"Arab,\" because of sectarian differences, as well as significant numbers of Pakistani, Turkish or other non-Arab troops. And not a \"force,\" because it either can't be deployed or proves ineffective. Even if the plan cannot immediately be implemented, however, the fact that key Arab states are pursuing it demonstrates how gravely they view their strategic situation. After becoming over-reliant on the United States, they fear the Middle East is entering a \"post-American\" period. So they must move quickly to try to defend their interests. Several Arab commentators have concluded that since there is \"no alternative,\" military integration is \"inevitable.\" The members of the Arab League are clearly serious about trying. Whether they will prove capable of creating and deploying a joint military force remains to be seen."
