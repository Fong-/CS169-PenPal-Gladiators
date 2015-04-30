class ChangeStringColumnsToText < ActiveRecord::Migration
    def change
        change_column :users, :avatar, :text, :limit => 1024
        change_column :posts, :text, :text, :limit => nil
        change_column :conversations, :summary_of_first, :text, :limit => nil
        change_column :conversations, :summary_of_second, :text, :limit => nil
        change_column :conversations, :resolution, :text, :limit => nil
    end
end
