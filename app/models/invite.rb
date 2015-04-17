class Invite < ActiveRecord::Base
    belongs_to :from, :class_name => "User", :foreign_key => "from_id"
    belongs_to :to, :class_name => "User", :foreign_key => "to_id"
    attr_accessible :from, :to
end
