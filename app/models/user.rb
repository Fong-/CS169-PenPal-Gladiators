class User < ActiveRecord::Base
    include Authenticable

    has_many :user_survey_responses
    has_many :survey_responses, :through => :user_survey_responses
    has_many :posts

    scope :arenas, -> { Arena.where("user1_id = ? OR user2_id = ?", self.id, self.id )  }

    attr_accessible :email, :password, :secret
    attr_accessible :username, :avatar, :political_blurb, :political_hero, :political_spectrum

    after_initialize do
        self.secret ||= SecureRandom.base64(24)
        self.username ||= UsernameGenerator.new
    end

    @@sha256 = Digest::SHA256.new

    def arenas
        Arena.where "user1_id = ? OR user2_id = ?", self.id, self.id
    end

    def password=(s)
        super @@sha256.base64digest(s)
    end

    def self.exists(email)
        return User.find_by_email(email).present?
    end

    def self.exists_with_credentials(email, password)
        return User.find_by_credentials(email, password).present?
    end

    def self.find_by_credentials(email, password)
        return User.find_by_email_and_password(email, @@sha256.base64digest(password))
    end

    def response_object
        return {
            :id => id,
            :username => username,
            :avatar => avatar
        }
    end

    def profile_response_object
        return {
            :username => username,
            :avatar => avatar,
            :political_blurb => political_blurb,
            :political_hero => political_hero,
            :political_spectrum => political_spectrum
        }
    end

    def post_author_response_object
        return {
            :username => username,
            :avatar => avatar,
            :id => id
        }
    end

    def update_profile(params)
        self.username = params[:username]
        self.political_blurb = params[:political_blurb]
        self.political_hero = params[:political_hero]
        self.political_spectrum = params[:political_spectrum]
        save
    end

    def matches
        all_users = User.all
        sorted_list = []
        for other_user in all_users
            if other_user.id != self.id
                match_data = self.score_user(other_user)
                sorted_list.push({:user => other_user, :match_data => match_data})
            end
        end
        return sorted_list.sort { |e1, e2| e1[:match_data][:score] <=> e2[:match_data][:score] } .reverse.last(5)
    end

    def score_user(other_user)
        max = 0
        max_topic = nil

        common_topics = self.find_common_topics(other_user)
        for topic in common_topics
            topic_score = self.find_topic_score(other_user, topic)
            if max < topic_score
                max = topic_score
                max_topic = topic
            end
        end
        return {:score => max, :topic => max_topic }
    end

    def find_common_topics(other_user)
        my_topics = self.find_topics().to_set
        other_user_topics = other_user.find_topics().to_set
        return my_topics & other_user_topics
    end

    def find_topics()
        topics = []
        responses = UserSurveyResponse.where({:user_id => self.id})
        for response in responses
            topics.push(response.survey_response.survey_question.topic.id)
        end
        return topics
    end

    def find_topic_score(other_user, topic)
        sum = 0
        my_responses_hash = self.build_hash()

        other_responses = UserSurveyResponse.where({:user_id => other_user.id})
        for other_response in other_responses
            if other_response.survey_response.survey_question.topic.id == topic
                sum += ResponseWeight.find_weight(other_response.survey_response.id, my_responses_hash[other_response.survey_response.survey_question.id.to_s])
            end
        end
        return sum
    end

    def build_hash()
        my_responses_hash = {}
        my_responses = UserSurveyResponse.where({:user_id => self.id})
        for my_response in my_responses
            my_responses_hash[my_response.survey_response.survey_question.id.to_s] = my_response.survey_response.id
        end
        return my_responses_hash
    end
end
