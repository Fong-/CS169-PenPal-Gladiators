class Conversation < ActiveRecord::Base
    belongs_to :arena
    has_many :posts
    attr_accessible :title

    def recent_post
        return posts.first
    end

    def timestamp
        return self.updated_at
    end
end
