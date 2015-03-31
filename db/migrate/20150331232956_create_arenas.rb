class CreateArenas < ActiveRecord::Migration
  def change
    create_table :arenas do |t|
      t.integer :user1_id
      t.integer :user2_id

      t.timestamps
    end
    add_index :arenas, :user1_id
    add_index :arenas, :user2_id
  end
end
