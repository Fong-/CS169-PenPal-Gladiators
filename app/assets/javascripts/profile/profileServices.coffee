profilePageServices = angular.module("ProfilePageServices", [])
profilePageServices.service("ProfilePageData", () ->
    profileData = {}
    username = ""
    avatar = ""
    blurb = ""
    hero = ""
    spectrum = -1
    email = ""        

    # Username interface
    this.getUsername = -> username
    this.setUsername = (u) -> username = u
    
    # Avatar interface
    this.getAvatar = -> avatar
    this.setAvatar = (a) -> avatar = a
    
    # Blurb interface
    this.getBlurb = -> blurb 
    this.setBlurb = (b) -> blurb = b

    # Hero interface
    this.getHero = -> hero 
    this.setHero = (h) -> hero = h
        
    # Spectrum interface
    this.getSpectrum = -> spectrum 
    this.setSpectrum = (s) -> spectrum = s
    
    # Email interface
    this.getEmail = -> email 
    this.setEmail = (e) -> email = e

    this.getProfile = (id) ->
        profileData = {}
        profileData[username] = username
        profileData[avatar] = avatar
        profileData[blurb] = blurb
        profileData[hero] = hero
        profileData[spectrum] = spectrum
        profileData[email] = email
        return profileData
    return
)

