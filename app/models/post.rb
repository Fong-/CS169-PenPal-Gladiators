class Post < ActiveRecord::Base
  belongs_to :conversation
  attr_accessible :author, :text
end
