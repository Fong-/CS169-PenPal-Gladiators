angular.module("SharedServices").service("AppState", ["$cookieStore", ($cookieStore) ->
    user = {}

    theme = $cookieStore.get("theme")

    # User state
    Object.defineProperty(this, "user", {
        get: () -> user
    })

    Object.defineProperty(this, "theme", {
        get: () -> theme
    })

    this.setUserId = (id) -> user.id = id
    this.setUserAvatar = (avatar) -> user.avatar = avatar
    this.setUserName = (name) -> user.username = name

    this.setTheme = (themeName) ->
        theme = themeName
        $cookieStore.put("theme", theme)

    return
])
