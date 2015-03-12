class CreateSurveyResponses < ActiveRecord::Migration
  def change
    create_table :survey_responses do |t|
      t.string :text
      t.belongs_to :survey_question

      t.timestamps
    end
    add_index :survey_responses, :survey_question_id
  end
end
