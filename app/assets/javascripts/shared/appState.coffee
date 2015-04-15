angular.module("SharedServices").service("AppState", ["$cookieStore", ($cookieStore) ->
    user = {}
    loggedIn = false

    # User state
    Object.defineProperty(this, "user", {
        get: () -> user
    })

    this.setUserId = (id) -> user.id = id
    this.setUserAvatar = (avatar) -> user.avatar = avatar
    this.setUserName = (name) -> user.username = name

    # Login state
    Object.defineProperty(this, "loggedIn", {
        get: () -> loggedIn
    })

    this.login = () -> loggedIn = false

    return
])
