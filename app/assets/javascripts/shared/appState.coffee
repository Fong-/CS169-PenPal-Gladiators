angular.module("SharedServices").service("AppState", ["$cookieStore", ($cookieStore) ->
    user = {}

    Object.defineProperty(this, "user", {
        get: () -> user
    })
])
