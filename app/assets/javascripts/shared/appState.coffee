angular.module("SharedServices").service("AppState", ["$cookieStore", ($cookieStore) ->
    user = {}

    # User state
    Object.defineProperty(this, "user", {
        get: () -> user
    })

    this.setUserId = (id) -> user.id = id
    this.setUserAvatar = (avatar) -> user.avatar = avatar
    this.setUserName = (name) -> user.username = name

    return
])
