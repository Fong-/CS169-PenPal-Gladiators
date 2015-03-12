class CreateSurveyQuestions < ActiveRecord::Migration
  def change
    create_table :survey_questions do |t|
      t.string :text
      t.belongs_to :topic

      t.timestamps
    end
    add_index :survey_questions, :topic_id
  end
end
