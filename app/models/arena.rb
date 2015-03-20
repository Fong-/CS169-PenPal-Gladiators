class Arena < ActiveRecord::Base
    belongs_to :user1, :class_name => "User", :foreign_key => "user1_id"
    belongs_to :user2, :class_name => "User", :foreign_key => "user2_id"
    has_many :conversations
    attr_accessible :user1, :user2

    def response_object
        conversations_response = []
        conversations.each do |conversation|
            conversations_response.push({
                :id => conversation.id,
                :timestamp => conversation.timestamp,
                :recent_post => {
                    :author_id => conversation.recent_post.author.id,
                    :text => conversation.recent_post.text
                }
            })
        end

        response = {
            :user1 => { :id => user1.id, :name => user1.email },
            :user2 => { :id => user2.id, :name => user2.email },
            :conversations => conversations_response
        }
        return response
    end
end