profile = angular.module("Profile",["SharedServices", "ProfilePageServices"])

profile.config(["$routeProvider", ($routeProvider) ->
    $routeProvider.when("/profile/:id", {
        templateUrl: "/assets/profile.html",
        controller: "ProfileController"
    })
]).controller("ProfileController", ["$http", "$location", "$scope", "$routeParams", "API", "ProfilePageData", ($http, $location, $scope, $routeParams, API, ProfilePageData) ->
    # moduleState can be either "view" or "edit"
    $scope.moduleState = "view"

    $scope.loggedInUID = 1 # FIXME Hardcode UID as 1 for now
    $scope.profileUID = $routeParams.id

    $scope.profile = ProfilePageData

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
        return 1==1
        return $scope.loggedInUID == $scope.profileUID

    $scope.edit = () ->
        if $scope.can_edit()
            $scope.moduleState = "edit"

    $scope.save = () ->
        # TODO for "better" security, change profileUID to loggedInUID once
        # tracking who's logged in actually works
        for k, v of $scope.spectrumOptions
            if $scope.profile.spectrum == v.value
                spectrum_id = v.id
        API.updateProfileByUID($scope.profileUID, $scope.profile.username, $scope.profile.avatar, $scope.profile.blurb, $scope.profile.hero, spectrum_id)
        $scope.moduleState = "view"

    load_profile = (userId) ->
        API.requestProfileByUID(userId).success( (profile) ->
            $scope.profile.username = profile.username
            $scope.profile.avatar = profile.avatar
            $scope.profile.blurb = profile.political_blurb
            $scope.profile.hero = profile.political_hero
            $scope.profile.email = profile.email
            for k, v of $scope.spectrumOptions
                if profile.political_spectrum == v.id
                    $scope.profile.spectrum = v.value
        )
    load_profile($scope.profileUID)
])
