module ErrorHandler
    ERROR = {
        :incorrect_credentials => "incorrect credentials",
        :expired_token => "access token expired",
        :invalid_token => "invalid access token",
        :invalid_email => "invalid email",
        :invalid_password => "invalid password",
        :user_exists => "user exists",
        :resource_not_found => "resource not found",
        :cannot_invite => "cannot invite user",
        :cannot_accept_or_reject => "cannot accept or reject invitation",
        :no_such_conversation => "no such conversation",
        :no_such_conversation_or_user => "no such conversation or user",
        :invalid_action => "you are not allowed to do this"
    }

    ERROR_CODE = {
        :incorrect_credentials => 401,
        :expired_token => 401,
        :invalid_token => 401,
        :invalid_email => 400,
        :invalid_password => 400,
        :user_exists => 400,
        :resource_not_found => 404,
        :no_such_conversation => 404,
        :no_such_conversation_or_user => 404,
        :cannot_invite => 400,
        :cannot_accept_or_reject => 400,
        :unauthorized_access => 401
    }

    def render_error(error, args = {})
        render :json => { :error => ERROR[error] }.merge(args), :status => ERROR_CODE[error]
    end

end
