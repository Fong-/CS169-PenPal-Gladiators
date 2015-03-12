class AddIndexToSurveyQuestions < ActiveRecord::Migration
  def change
    add_column :survey_questions, :index, :integer
  end
end
