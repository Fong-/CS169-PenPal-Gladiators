class UsersController < ActionController::Base
    def login
        if not check_params_for_authentication(params)
            return
        end
        email = params[:email]
        password = params[:password]
        if user_exists(email)
            render :json => {:success => "true"}
            return
        else
            render :json => {:error => "Invalid email or password."}
            return
        end
    end

    def register
        if not check_params_for_authentication(params)
            return
        end
        email = params[:email]
        password = params[:password]
        if user_exists(email)
            render :json => {:error => "Username already taken."}
            return
        else
            User.create(:email => email, :password => password)
            render :json => {:success => "true"}
            return
        end
    end

    def check_params_for_authentication(hash)
        if hash[:email] == nil or hash[:password] == nil or hash[:email] == "" or hash[:password] == ""
            render :json => {:error => "Invalid parameters."}
            return false
        end
        return true
    end

    def user_exists(email)
        return !User.find_by_email(email).nil?
    end
end
