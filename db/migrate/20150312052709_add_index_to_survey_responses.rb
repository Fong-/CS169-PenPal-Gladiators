class AddIndexToSurveyResponses < ActiveRecord::Migration
  def change
    add_column :survey_responses, :index, :integer
  end
end
