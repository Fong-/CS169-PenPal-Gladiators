module AccessTokenHelper
    TIME_CRYPT_BASE = 36
    USER_ID_SEPARATOR = ":"

    def access_token_from_user(user, duration = 3.days)
        expiration_time = Time.now.to_i + duration.to_i
        encrypted_expiration_time = encrypt_expiration_time(user, expiration_time)
        return "#{user.id}#{USER_ID_SEPARATOR}#{encrypted_expiration_time}"
    end

    def data_from_access_token(token)
        user_id_string, encrypted_expiration_time = split_token_into_id_time(token)
        user_id = user_id_string.to_i
        user = User.find_by_id(user_id)
        if user.nil?
            return :error => :no_such_user
        end
        expiration_time = decrypt_expiration_time(user, encrypted_expiration_time)
        if Time.now.to_i >= expiration_time
            return :user => user, :error => :expired_token
        else
            return :user => user, :expiration_time => Time.at(expiration_time)
        end
    end

    private

    def encrypt_expiration_time(user, expiration_time)
        crypt = message_encryptor_from_user(user)
        return crypt.encrypt_and_sign(expiration_time.to_s(TIME_CRYPT_BASE))
    end

    def decrypt_expiration_time(user, encrypted_expiration_time)
        crypt = message_encryptor_from_user(user)
        return crypt.decrypt_and_verify(encrypted_expiration_time).to_i(TIME_CRYPT_BASE)
    end

    def split_token_into_id_time(token)
        index_of_separator = token.index(USER_ID_SEPARATOR)
        return index_of_separator <= 0 ? nil : token.slice(0, index_of_separator), token.slice(index_of_separator + 1, token.length)
    end

    def message_encryptor_from_user(user)
        ActiveSupport::MessageEncryptor.new(user.secret + Rails.configuration.secret_token)
    end
end
