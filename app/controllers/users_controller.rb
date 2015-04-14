class UsersController < ActionController::Base
    ERROR_MESSAGES = {
        :invalid_login => "incorrect credentials",
        :invalid_email => "invalid email",
        :invalid_password => "invalid password",
        :email_exists => "email already exists",
    }

    def authenticate
        token = params[:access_token]

        token_results = User.parse_access_token(token)

        if token_results.has_key?(:error)
            render :json => { :error => :failed }
        else
            render :json => {}
        end
    end

    def login
        if params_are_invalid(params)
            return
        end

        email = params[:email]
        password = params[:password]

        user = User.find_by_credentials(email, password)
        if user.present?
            render :json => {:token => user.access_token}
        else
            render :json => {:error => ERROR_MESSAGES[:invalid_login]}
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

        render :json => {}
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

    def get_profile_info_by_id
        render :json => User.find(params[:id]).profile_response_object
    end

    def post_profile_info_by_id
        User.find(params[:id]).update_profile(params)
        render :json => {}
    end
end
