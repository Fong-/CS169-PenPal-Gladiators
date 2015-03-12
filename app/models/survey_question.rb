class SurveyQuestion < ActiveRecord::Base
    belongs_to :topic
    has_many :survey_responses
    attr_accessible :text, :index
end
