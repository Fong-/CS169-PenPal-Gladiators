profile = angular.module("Profile",[])

profile.config(["$routeProvider", ($routeProvider) ->
    $routeProvider.when("/profile/:id", {
        templateUrl: "/assets/profile.html",
        controller: "ProfileController"
    })
]).controller("ProfileController", ["$http", "$location", "$scope", "SharedRequests", "ProfilePageData" ($http, $location, $scope, SharedRequests, ProfilePageData) ->
    $scope.moduleState = "view"

    $scope.loggedInUID = 1 # FIXME Hardcode UID as 1 for now
    $scope.profileUID = $routeParams.id
    $scope.username = ""
    $scope.avatar = ""
    $scope.blurb = ""
    $scope.hero = ""
    $scope.spectrum = ""
    $scope.email = ""

    # For eventual use with radio buttons
    # See https://docs.angularjs.org/api/ng/input/input%5Bradio%5D
    $scope.conservative = {
        "id": 1
        "value": "conservative"
    }
    $scope.moderately-conservative = {
        "id": 2
        "value": "moderately-conservative"
    }
    $scope.moderate = {
        "id": 3
        "value": "moderate"
    }
    $scope.moderately-liberal = {
        "id": 4
        "value": "moderately-liberal"
    }
    $scope.liberal = {
        "id": 5
        "value": "liberal"
    }

    $scope.profileModel = ProfilePageData.getProfile[:id]

    $scope.can_edit () ->
        return $scope.loggedInUID == $scope.profileUID

    $scope.edit () ->
        if $scope.can_edit()
            $scope.moduleState = "edit"

    $scope.save () ->
        ProfilePageData.setUsername($scope.username)
        ProfilePageData.setAvatar($scope.avatar)
        ProfilePageData.setBlurb($scope.political_blurb)
        ProfilePageData.setHero($scope.political_hero)
        ProfilePageData.setSpectrum($scope.political_spectrum)
        SharedRequests.updateProfileByUID(id, $scope.username, $scope.avatar, $scope.blurb, $scope.hero, $scope.spectrum)
        $scope.moduleState = "view"

    load_profile = (userId) ->
        SharedRequests.requestProfileByUID(userId).success( (profile) ->
            ProfilePageData.setUsername(profile.username)
            ProfilePageData.setAvatar(profile.avatar)
            ProfilePageData.setBlurb(profile.political_blurb)
            ProfilePageData.setHero(profile.political_hero)
            ProfilePageData.setSpectrum(profile.political_spectrum)
            $scope.username = ProfilePageData.getUsername
            $scope.avatar= ProfilePageData.getUsername
            $scope.blurb= ProfilePageData.getBlurb
            $scope.hero= ProfilePageData.getHero
            $scope.spectrum= ProfilePageData.getSpectrum
        )
    load_profile($scope.profileUID)
])
