class User < ActiveRecord::Base
    has_many :user_survey_responses
    has_many :survey_responses, :through => :user_survey_responses
    attr_accessible :email, :password

    @@sha256 = Digest::SHA256.new

    def password=(s)
        super @@sha256.base64digest(s)
    end

    def self.exists(email)
        return User.find_by_email(email).present?
    end

    def self.exists_with_password(email, password)
        return User.find_by_email_and_password(email, @@sha256.base64digest(password)).present?
    end
end
