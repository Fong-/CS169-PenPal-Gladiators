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
        :cannot_accept_or_reject => "cannot accept or reject invitation"
    }

    ERROR_CODE = {
        :incorrect_credentials => 401,
        :expired_token => 401,
        :invalid_token => 401,
        :invalid_email => 400,
        :invalid_password => 400,
        :user_exists => 400,
        :resource_not_found => 404,
        :cannot_invite => 400,
        :cannot_accept_or_reject => 400
    }

    def render_error(error)
        render :json => { :error => ERROR[error] }, :status => ERROR_CODE[error]
    end

end
