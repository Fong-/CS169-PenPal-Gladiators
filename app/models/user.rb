class User < ActiveRecord::Base
    has_many :user_survey_responses
    has_many :survey_responses, :through => :user_survey_responses
    attr_accessible :email, :password
end
