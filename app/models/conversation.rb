class Conversation < ActiveRecord::Base
  belongs_to :arena
  has_many :posts
  attr_accessible :title
end
