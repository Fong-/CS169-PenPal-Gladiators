class UsersController < ActionController::Base
    ERROR_MESSAGES = {
        :invalid_login => "incorrect credentials",
        :invalid_email => "invalid email",
        :invalid_password => "invalid password",
        :email_exists => "email already exists"
    }

    def login
        if params_are_invalid(params)
            return
        end

        email = params[:email]
        password = params[:password]

        if User.exists_with_password(email, password)
            render :json => {:success => "true"}
            return
        else
            render :json => {:error => ERROR_MESSAGES[:invalid_login]}
            return
        end
    end

    def register
        if can_user_register(params)
            User.create :email => params[:email], :password => params[:password]
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
