angular.module("SharedServices").service("Authentication", ["$cookieStore", "$q", "$window", "API", "AppState", ($cookieStore, $q, $window, API, AppState) ->
    rejectPromise = $q.reject("Invalid authentication")

    this.isLoggedIn = (redirectToLogin = true) ->
        if AppState.loggedIn
            return $q.when(true)

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

                    user = data.user

                    AppState.setUserId(user.id)
                    AppState.setUserName(user.username)
                    AppState.setUserAvatar(user.avatar)
                    AppState.login()

                    return true
                (reason) -> handleFailure()
            )
        else
            return handleFailure()

    return
])
