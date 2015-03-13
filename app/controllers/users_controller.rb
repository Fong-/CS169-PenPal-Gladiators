class UsersController < ActionController::Base
    ERROR_MESSAGES = {
        :invalid_login => "incorrect credentials",
        :invalid_email => "invalid email",
        :invalid_password => "invalid password",
        :email_exists => "email already exists"
    }

    @@sha256 = Digest::SHA256.new

    def login
        return if is_params_invalid(params)

        email = params[:email]
        password = @@sha256.base64digest(params[:password])

        if User.exists_with_password(email, password)
            render :json => {:success => "true"}
            return
        else
            render :json => {:error => ERROR_MESSAGES[:invalid_login]}
            return
        end
    end

    def register
        return if is_params_invalid(params)

        email = params[:email]
        password = @@sha256.base64digest(params[:password])

        if User.exists(email)
            render :json => {:error => ERROR_MESSAGES[:email_exists]}
            return
        else
            User.create(:email => email, :password => password)
            render :json => {:success => "true"}
            return
        end
    end

    def is_params_invalid(params)
        if params[:email] == nil or params[:password] == nil or params[:email] == "" or params[:password] == ""
            render :json => {:error => "Invalid parameters."}
            return true
        end
        return false
    end
end
