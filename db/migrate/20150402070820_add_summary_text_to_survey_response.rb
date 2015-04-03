class AddSummaryTextToSurveyResponse < ActiveRecord::Migration
  def change
    add_column :survey_responses, :summary_text, :string
  end
end
