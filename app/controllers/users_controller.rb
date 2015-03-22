include AccessTokenHelper

class UsersController < ActionController::Base
    ERROR_MESSAGES = {
        :invalid_login => "incorrect credentials",
        :invalid_email => "invalid email",
        :invalid_password => "invalid password",
        :email_exists => "email already exists"
    }

    @@sha256 = Digest::SHA256.new

    def authenticate
        email, password = extract_email_and_encrypted_password(params)
        if email.nil?
            return
        end
        user = User.find_by_email_and_password(email, password)
        if user.nil?
            render :json => {:error => ERROR_MESSAGES[:invalid_login]}
        else
            render :json => {:success => "true", :token => access_token_from_user(user)}
        end
    end

    def login
        email, password = extract_email_and_encrypted_password(params)
        if email.nil?
            return
        end
        if User.exists_with_password(email, password)
            render :json => {:success => "true"}
        else
            render :json => {:error => ERROR_MESSAGES[:invalid_login]}
        end
    end

    # Returns (email, password) from params and renders upon failure.
    def extract_email_and_encrypted_password(params)
        if params_are_invalid(params)
            return nil, nil
        end
        return params[:email], @@sha256.base64digest(params[:password])
    end

    def register
        if can_user_register(params)
            User.create :email => params[:email], :password => @@sha256.base64digest(params[:password])
        end
    end

    def can_register
        can_user_register(params)
    end

    def can_user_register(params)
        if params_are_invalid(params)
            return false
        elsif User.exists(params[:email])
            render :json => {:error => ERROR_MESSAGES[:email_exists]}
            return false
        end

        render :json => {:success => "true"}
        return true
    end

    def params_are_invalid(params)
        if params[:email] == nil or params[:email] == ""
            render :json => { :error => ERROR_MESSAGES[:invalid_email] }
            return true
        elsif params[:password] == nil or params[:password] == ""
            render :json => { :error => ERROR_MESSAGES[:invalid_password] }
            return true
        end
        return false
    end
end
