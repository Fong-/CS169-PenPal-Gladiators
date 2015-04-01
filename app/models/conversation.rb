class Conversation < ActiveRecord::Base
  belongs_to :arena
  attr_accessible :title
end
