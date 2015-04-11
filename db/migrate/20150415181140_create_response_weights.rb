class CreateResponseWeights < ActiveRecord::Migration
  def change
    create_table :response_weights do |t|
      t.integer :response1_id
      t.integer :response2_id
      t.integer :weight

      t.timestamps
    end
  end
end
