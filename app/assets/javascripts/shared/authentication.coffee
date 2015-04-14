angular.module("SharedServices").service("Authentication", ["$cookieStore", "$q", "$window", "API", ($cookieStore, $q, $window, API) ->
    rejectPromise = $q.reject("Invalid authentication")

    this.isLoggedIn = (redirectToLogin = true) ->
        if redirectToLogin
            handleFailure = () ->
                $window.location.href = "/login"
                return rejectPromise
        else
            handleFailure = () -> rejectPromise

        user = $cookieStore.get("user")
        if user? and user.accessToken?
            return API.authenticate(user.accessToken).then(
                (result) ->
                    data = result.data
                    if "error" of data
                        return handleFailure()
                    return result
                (reason) -> handleFailure()
            )
        else
            return handleFailure()

    return
])
