class SurveyQuestion < ActiveRecord::Base
    belongs_to :topic
    has_many :survey_responses
    attr_accessible :text, :index

    def response_object
        { :id => id, :text => text, :index => index, 
            :survey_responses => survey_responses.each do |r| r.response_object end }
    end
end
