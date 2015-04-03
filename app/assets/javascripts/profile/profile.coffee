profile = angular.module("Profile",[])

profile.config(["$routeProvider", ($routeProvider) ->
    $routeProvider.when("/profile/:id", {
        templateUrl: "/assets/profile.html",
        controller: "ProfileController"
    })
]).controller("ProfileController", ["$http", "$location", "$scope", "SharedRequests", "ProfilePageData" ($http, $location, $scope, SharedRequests, ProfilePageData) ->
    # moduleState can be either "view" or "edit"
    $scope.moduleState = "view"

    $scope.loggedInUID = 1 # FIXME Hardcode UID as 1 for now
    $scope.profileUID = $routeParams.id

    $scope.profile = ProfilePageData

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

    $scope.can_edit = () ->
        return $scope.loggedInUID == $scope.profileUID

    $scope.edit = () ->
        if $scope.can_edit()
            $scope.moduleState = "edit"

    $scope.save = () ->
        SharedRequests.updateProfileByUID($scope.loggedInUID, $scope.username, $scope.avatar, $scope.blurb, $scope.hero, $scope.spectrum)
        $scope.moduleState = "view"

    load_profile = (userId) ->
        SharedRequests.requestProfileByUID(userId).success( (profile) ->
            $scope.profile.username = profile.username
            $scope.profile.avatar = profile.avatar
            $scope.profile.blurb = profile.political_blurb
            $scope.profile.hero = profile.political_hero
            $scope.profile.spectrum = profile.political_spectrum
        )
    load_profile($scope.profileUID)
])
