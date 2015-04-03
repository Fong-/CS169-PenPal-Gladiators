class SurveyResponse < ActiveRecord::Base
    belongs_to :survey_question
    has_many :user_survey_responses
    has_many :users, :through => :user_survey_responses
    attr_accessible :text, :summary_text, :index

    def response_object
        { :id => id, :text => text, :summary_text => summary_text, :index => index }
    end
end
