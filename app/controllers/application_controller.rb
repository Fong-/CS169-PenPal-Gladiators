class ApplicationController < ActionController::Base
    before_filter :check_access_token

    def check_access_token
        token = params[:token]

        begin
            @token_results = User.parse_access_token(token)

            if @token_results.has_key?(:error)
                render :json => { :error => token_results[:error] }
            end
        rescue
            render :json => { :error => :failed }
        end
    end
end
