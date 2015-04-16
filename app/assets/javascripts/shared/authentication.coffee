angular.module("SharedServices").service("Authentication", ["$cookieStore", "$q", "$window", "API", "AppState", ($cookieStore, $q, $window, API, AppState) ->
    rejectPromise = $q.reject("Invalid authentication")
    loggedIn = false

    this.isLoggedIn = () ->
        if loggedIn
            return $q.when(true)

        accessToken = $cookieStore.get("accessToken")
        if accessToken?
            return API.authenticate(accessToken).then(
                    (result) ->
                        user = result.data.user

                        AppState.setUserId(user.id)
                        AppState.setUserName(user.username)
                        AppState.setUserAvatar(user.avatar)

                        loggedIn = true
                        return loggedIn
                    (reason) -> rejectPromise
                )
        else
            return rejectPromise

    return
])
