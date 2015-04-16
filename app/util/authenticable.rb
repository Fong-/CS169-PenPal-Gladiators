module Authenticable
    TIME_CRYPT_BASE = 36
    USER_ID_SEPARATOR = ":"

    def self.included base
        base.send :include, AccessTokenInstanceMethods
        base.extend AccessTokenClassMethods
    end

    module AccessTokenInstanceMethods
        def access_token(duration = 3.days)
            expiration_time = Time.now.to_i + duration.to_i
            encrypted_expiration_time = self.encrypt_expiration_time(expiration_time)
            return "#{self.id}#{USER_ID_SEPARATOR}#{encrypted_expiration_time}"
        end

        def message_encryptor_from_user()
            ActiveSupport::MessageEncryptor.new(self.secret + Rails.configuration.secret_token)
        end

        def encrypt_expiration_time(expiration_time)
            crypt = self.message_encryptor_from_user
            return crypt.encrypt_and_sign(expiration_time.to_s(TIME_CRYPT_BASE))
        end

        def decrypt_expiration_time(encrypted_expiration_time)
            crypt = self.message_encryptor_from_user
            return crypt.decrypt_and_verify(encrypted_expiration_time).to_i(TIME_CRYPT_BASE)
        end
    end

    module AccessTokenClassMethods
        def parse_access_token(token)
            user_id_string, encrypted_expiration_time = split_token_into_id_time(token)
            user_id = user_id_string.to_i
            user = User.find_by_id(user_id)
            if user.nil?
                return :error => :resource_not_found
            end
            begin
                expiration_time = user.decrypt_expiration_time(encrypted_expiration_time)
            rescue
                return :user => user, :error => :invalid_token
            end
            if Time.now.to_i >= expiration_time
                return :user => user, :error => :expired_token
            else
                return :user => user, :expiration_time => Time.at(expiration_time)
            end
        end

        def split_token_into_id_time(token)
            index_of_separator = token.index(USER_ID_SEPARATOR)
            return index_of_separator <= 0 ? nil : token.slice(0, index_of_separator), token.slice(index_of_separator + 1, token.length)
        end
    end

end
