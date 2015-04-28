class ApplicationController < ActionController::Base
    include ErrorHandler

    before_filter :check_access_token

    def check_access_token
        token = params[:token]
        begin
            @token_results = User.parse_access_token(token)

            if @token_results.has_key?(:error)
                error = @token_results[:error]
                render_error(error)
            end
        rescue
            render_error(:invalid_token)
        end
    end

    def get_authenticated_user
        return @token_results[:user]
    end
end
