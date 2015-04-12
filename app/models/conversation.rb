class Conversation < ActiveRecord::Base
    belongs_to :arena
    has_many :posts
    attr_accessible :title

    def recent_post
        return posts.first
    end

    def has_posts
        return !posts.empty?
    end

    def timestamp
        return has_posts ? recent_post.updated_at : updated_at
    end

    def response_object
        return {
            :id => id,
            :title => title,
            :posts => posts.map { |post|
                post.response_object
            }
        }
    end
end
