class Topic < ActiveRecord::Base
    has_many :survey_questions
    attr_accessible :icon, :name
end
