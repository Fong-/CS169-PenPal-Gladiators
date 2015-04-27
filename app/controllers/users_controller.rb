class UsersController < ApplicationController

    skip_filter :check_access_token, :only => [:can_register, :register, :login]

    def matches
        user = User.find_by_id(params[:id])
        if user.present?
            render :json => user.matches
        else
            render :json => []
        end
    end
    
    def authenticate
        user = @token_results[:user]
        render :json => { :user => user.response_object }
    end

    def login
        if params_are_invalid(params)
            return
        end

        email = params[:email]
        password = params[:password]

        user = User.find_by_credentials(email, password)
        if user.nil?
            render_error(:resource_not_found) and return
        end

        render :json => {:token => user.access_token}
    end

    def logout
        user = User.find_by_id(params[:id])
        if user.nil?
            render_error(:resource_not_found) and return
        end
        user.refresh_secret
        user.save!
        render :json => {}
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
            render_error(:user_exists)
            return false
        end

        return true
    end

    def params_are_invalid(params)
        if params[:email] == nil or params[:email] == ""
            render_error(:invalid_email)
            return true
        elsif params[:password] == nil or params[:password] == ""
            render_error(:invalid_password)
            return true
        end
        return false
    end

    def get_profile_info_by_id
        user = User.find_by_id(params[:id])
        if user.nil?
            render_error(:resource_not_found) and return
        end

        render :json => user.profile_response_object
    end

    def post_profile_info_by_id
        user = User.find_by_id(params[:id])
        if user.nil?
            render_error(:resource_not_found) and return
        end

        user.update_profile(params)
        render :json => {}
    end
end
