class SurveyResponse < ActiveRecord::Base
    belongs_to :survey_question
    has_many :user_survey_responses
    has_many :users, :through => :user_survey_responses
    attr_accessible :text
end
