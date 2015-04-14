class UsersController < ActionController::Base
    ERROR_MESSAGES = {
        :invalid_login => "incorrect credentials",
        :invalid_email => "invalid email",
        :invalid_password => "invalid password",
        :email_exists => "email already exists",
        :user_not_found => "user not found"
    }

    def authenticate
        token = params[:token]

        begin
            token_results = User.parse_access_token(token)
        rescue
            render :json => { :error => :failed }
            return
        end

        if token_results.has_key?(:error)
            render :json => { :error => :failed }
        else
            user = token_results[:user]
            render :json => { :user => user.profile_response_object }
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
            user = User.create :email => params[:email], :password => params[:password]
            render :json => {:token => user.access_token}
        end
    end

    def can_register
        if can_user_register(params)
            render :json => {}
        end
    end

    def can_user_register(params)
        if params_are_invalid(params)
            return false
        elsif User.exists(params[:email])
            render :json => {:error => ERROR_MESSAGES[:email_exists]}
            return false
        end

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
        user = User.find_by_id(params[:id])
        if user.present?
            render :json => user.profile_response_object
        else
            render :json => { :error => ERROR_MESSAGES[:user_not_found] }
        end
    end

    def post_profile_info_by_id
        user = User.find_by_id(params[:id])
        if user.present?
            user.update_profile(params)
            render :json => {}
        else
            render :json => { :error => ERROR_MESSAGES[:user_not_found] }
        end
    end
end
