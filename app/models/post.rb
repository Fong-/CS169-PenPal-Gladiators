class Post < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :author, :class_name => "User", :foreign_key => "user_id"
  attr_accessible :author, :text

  default_scope order('created_at DESC')
end
