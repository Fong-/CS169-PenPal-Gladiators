class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.string :title
      t.belongs_to :arena

      t.timestamps
    end
    add_index :conversations, :arena_id
  end
end
