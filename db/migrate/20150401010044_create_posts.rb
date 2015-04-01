class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :text
      t.belongs_to :user
      t.belongs_to :conversation

      t.timestamps
    end
    add_index :posts, :user_id
    add_index :posts, :conversation_id
  end
end
