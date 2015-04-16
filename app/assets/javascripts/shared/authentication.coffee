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
                    data = result.data
                    if "error" of data
                        return rejectPromise

                    user = data.user

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
