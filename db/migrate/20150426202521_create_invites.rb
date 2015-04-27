class CreateInvites < ActiveRecord::Migration
    def change
        create_table :invites do |t|
            t.integer :from_id
            t.integer :to_id
        end
        add_index :invites, :from_id
        add_index :invites, :to_id
    end
end
