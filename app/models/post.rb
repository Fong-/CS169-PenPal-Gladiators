class Post < ActiveRecord::Base
    belongs_to :conversation
    belongs_to :author, :class_name => "User", :foreign_key => "user_id"
    attr_accessible :author, :text, :conversation

    default_scope order("created_at DESC")

    def response_object
        return {
            :id => id,
            :author => author.post_author_response_object,
            :text => text,
            :timestamp => updated_at
        }
    end
end
