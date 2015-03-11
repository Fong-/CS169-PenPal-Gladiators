class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.text :username
      t.text :password
      t.text :profile_picture
      t.text :description

      t.timestamps
    end
  end
end
