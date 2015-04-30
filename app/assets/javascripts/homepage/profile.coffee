profile = angular.module("Profile",["SharedServices"])

profile.controller("ProfileController", ["$http", "$location", "$scope", "$stateParams", "API", "AppState", "ProfileData", ($http, $location, $scope, $stateParams, API, AppState, ProfileData) ->
    # moduleState can be either "view" or "edit"
    $scope.moduleState = "view"

    $scope.loggedInUID = AppState.user.id
    $scope.profileUID = $stateParams.id

    $scope.profile = {}

    # For radio buttons
    $scope.spectrumOptions = {
        conservative: {
            "id": 1
            "value": "Conservative"
        },
        moderately_conservative: {
            "id": 2
            "value": "Moderately Conservative"
        },
        moderate: {
            "id": 3
            "value": "Moderate"
        },
        moderately_liberal: {
            "id": 4
            "value": "Moderately Liberal"
        },
        liberal: {
            "id": 5
            "value": "Liberal"
        }
    }

    $scope.can_edit = () ->
        return $scope.loggedInUID == $scope.profileUID

    $scope.edit = () ->
        if $scope.can_edit()
            $scope.moduleState = "edit"

    $scope.save = () ->
        for k, v of $scope.spectrumOptions
            if $scope.profile.spectrum == v.value
                spectrum_id = v.id
        API.updateProfileByUID($scope.loggedInUID, $scope.profile.username, $scope.profile.avatar, $scope.profile.blurb, $scope.profile.hero, spectrum_id)
            .error (result, status) ->
                if result?
                    reason = result.error
                else
                    reason = "status code #{status}"
                console.log "profile updating failed: #{reason}"
        $scope.moduleState = "view"

    load_profile = (userId) ->
        API.requestProfileByUID(userId)
            .success (profile) ->
                parseProfile(profile)
            .error (result, status) ->
                if result?
                    reason = result.error
                else
                    reason = "status code #{status}"
                console.log "profile loading failed: #{reason}"

    parseProfile = (profile) ->
        $scope.profile.username = profile.username
        $scope.profile.avatar = profile.avatar
        $scope.profile.blurb = profile.political_blurb
        $scope.profile.hero = profile.political_hero
        $scope.profile.email = profile.email
        for k, v of $scope.spectrumOptions
            if profile.political_spectrum == v.id
                $scope.profile.spectrum = v.value
    parseProfile(ProfileData.data)
])
