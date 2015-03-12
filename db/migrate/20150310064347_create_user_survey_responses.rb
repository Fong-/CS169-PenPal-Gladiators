class CreateUserSurveyResponses < ActiveRecord::Migration
  def change
    create_table :user_survey_responses do |t|
      t.belongs_to :user
      t.belongs_to :survey_response

      t.timestamps
    end
    add_index :user_survey_responses, :user_id
    add_index :user_survey_responses, :survey_response_id
  end
end
