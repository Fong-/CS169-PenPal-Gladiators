class AddProfileInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :username, :string
    add_column :users, :avatar, :string
    add_column :users, :political_blurb, :text
    add_column :users, :political_hero, :string
    add_column :users, :political_spectrum, :integer
  end
end
