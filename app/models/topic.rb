class Topic < ActiveRecord::Base
    has_many :survey_questions
    attr_accessible :icon, :name

    def response_object
        { :id => id, :icon => icon, :name => name }
    end
end
