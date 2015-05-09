angular.module("SharedServices").service("AppState", ["$cookieStore", ($cookieStore) ->
    user = {}

    theme = $cookieStore.get("theme")
    if !theme
        theme = "dark"

    # User state
    Object.defineProperty(this, "user", {
        get: () -> user
    })

    Object.defineProperty(this, "theme", {
        get: () -> theme
    })

    this.refreshCSS = () ->
        css = document.getElementsByTagName('html')[0].getAttribute('data-css')

        cssElement = document.getElementById("injected-css")
        if(cssElement)
            cssElement.href = "/assets/themes/" + theme + "/" + css
            return

        link = document.createElement("link")
        link.href = "/assets/themes/" + theme + "/" + css
        link.type = "text/css"
        link.rel = "stylesheet"
        link.id = "injected-css"
        document.getElementsByTagName("head")[0].appendChild(link)

    this.setUserId = (id) -> user.id = id
    this.setUserAvatar = (avatar) -> user.avatar = avatar
    this.setUserName = (name) -> user.username = name

    this.setTheme = (themeName) ->
        theme = themeName
        $cookieStore.put("theme", theme)
        this.refreshCSS()

    return
])
