class UserSurveyResponse < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey_response
  # attr_accessible :title, :body
end
