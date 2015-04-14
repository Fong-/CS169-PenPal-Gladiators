angular.module("SharedServices").service("Authentication", ["$cookieStore", "$q", "$window", "API", ($cookieStore, $q, $window, API) ->
    rejectPromise = $q.reject("Invalid authentication")

    this.isLoggedIn = (redirectToLogin = true) ->
        handleFailure = if redirectToLogin then () -> $window.location.href = "/login" else () -> rejectPromise

        user = $cookieStore.get("user")
        if user? and user.accessToken?
            return API.authenticate(user.accessToken).then(
                (result) ->
                    if error of result
                        return handleFailure()
                    return result
                (reason) ->
                    return handleFailure()
            )
        else
            return handleFailure()

    return
])
