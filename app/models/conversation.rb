class Conversation < ActiveRecord::Base
    belongs_to :arena
    has_many :posts
    attr_accessible :title
    after_initialize :default_values

    def recent_post
        return posts.first
    end

    def has_posts
        return !posts.empty?
    end

    def timestamp
        return has_posts ? recent_post.updated_at : updated_at
    end

    # Grabs a list of conversations which have recently updated resolutions. Does not include
    # conversations that do not have resolutions. Returns at most max_num_conversation
    # conversations.
    def self.recent_with_resolutions(max_num_conversations)
        return Conversation.order(:resolution_updated_at).reverse_order.limit(max_num_conversations).reject { |conversation|
            conversation.resolution_state == "unstarted"
        }
    end

    def public_content(user1_name = "The first gladiator", user2_name = "The second gladiator")
        user1_id = arena.user1_id
        user2_id = arena.user2_id
        content = posts.map { |post|
            {
                :name => post.author.id == user1_id ? user1_name : user2_name,
                :text => post.text
            }
        }
        content.reverse!
        if resolution_state.to_s == "in_progress"
            content.append({
                :name => resolution_updated_by_id == user1_id ? user1_name : user2_name,
                :text => resolution
            })
        end
        return {
            :title => title,
            :posts => content
        }
    end

    # The columns summary_of_first and summary_of_second respectively refer to the summaries of
    # the viewpoints of the first and second gladiator, i.e. the summary_of_first is the summary
    # of user1's view written by user2.
    def response_object
        arena = self.arena
        return {
            :id => id,
            :title => title,
            :summaries => [
                {
                    :author => arena.user2.response_object,
                    :text => self.summary_of_first
                },
                {
                    :author => arena.user1.response_object,
                    :text => self.summary_of_second
                }
            ],
            :resolution => {
                :text => self.resolution,
                :state => self.resolution_state,
                :updated_time => self.resolution_updated_at,
                :updated_by_id => self.resolution_updated_by_id
            },
            :posts => posts.map { |post|
                post.response_object
            },
        }
    end

    def user_did_edit_summary(user_id, text)
        arena = self.arena
        if arena.is_first_user(user_id)
            self.summary_of_second = text
        elsif arena.is_second_user(user_id)
            self.summary_of_first = text
        else
            return false
        end
        save
        return true
    end

    def user_did_approve_summary(user_id)
        arena = self.arena
        if !summary_of_first.empty? && arena.is_first_user(user_id)
            posts.create :author => arena.user2, :text => summary_of_first, :post_type => :summary
            self.summary_of_first = ""
        elsif !summary_of_second.empty? && arena.is_second_user(user_id)
            posts.create :author => arena.user1, :text => summary_of_second, :post_type => :summary
            self.summary_of_second = ""
        else
            return false
        end
        save
        return true
    end

    def user_did_edit_resolution(user_id, text)
        # TODO Check that user_id is one of the two users in the conversation.
        # TODO Also, implement a way of storing edit history so users don't stomp each other.
        if self.resolution_state == :consensus_reached
            return false
        end
        self.resolution = text
        self.resolution_state = :in_progress
        self.resolution_updated_at = Time.now
        self.resolution_updated_by_id = user_id
        save
        return true
    end

    def user_did_approve_resolution(user_id)
        if allow_user_to_approve_consensus user_id
            self.resolution_state = :consensus_reached
            posts.create :author => arena.user1, :text => resolution, :post_type => :resolution
            save
            return true
        end
        return false
    end

    private
    def default_values
        self.summary_of_first ||= ""
        self.summary_of_second ||= ""
        self.resolution ||= ""
        self.resolution_state ||= :unstarted
    end

    def allow_user_to_approve_consensus(user_id)
        self.resolution_state != :consensus_reached && ![user_id, nil].include?(self.resolution_updated_by_id)
    end
end
