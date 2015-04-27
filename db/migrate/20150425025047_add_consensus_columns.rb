class AddConsensusColumns < ActiveRecord::Migration
    def change
        add_column :conversations, :summary_of_first, :string
        add_column :conversations, :summary_of_second, :string
        add_column :conversations, :resolution, :string
        add_column :conversations, :resolution_state, :string
        add_column :conversations, :resolution_updated_at, :timestamp
        add_column :conversations, :resolution_updated_by_id, :integer
        add_column :posts, :post_type, :string
    end
end
