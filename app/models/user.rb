class User < ActiveRecord::Base
    has_many :user_survey_responses
    has_many :survey_responses, :through => :user_survey_responses
    has_many :posts

    scope :arenas, -> { Arena.where("user1_id = ? OR user2_id = ?", self.id, self.id )  }

    attr_accessible :email, :password, :secret
    attr_accessible :username, :avatar, :political_blurb, :political_hero, :political_spectrum

    include AccessTokenHelper

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

    def update_profile(params)
        self.username = params[:username]
        self.political_blurb = params[:political_blurb]
        self.political_hero = params[:political_hero]
        self.political_spectrum = params[:political_spectrum]
        save
    end
end
