profile = angular.module("Profile",[])

profile.config(["$routeProvider", ($routeProvider) ->
    $routeProvider.when("/profile/:id", {
        templateUrl: "/assets/profile.html",
        controller: "ProfileController"
    })
]).controller("ProfileController", ["$http", "$location", "$scope", "SharedRequests", "ProfilePageData" ($http, $location, $scope, SharedRequests, ProfilePageData) ->
    $scope.loggedInUID = 1 # FIXME Hardcode UID as 1 for now
    $scope.profileUID = $routeParams.id
    $scope.username = ""
    $scope.avatar = ""
    $scope.blurb = ""
    $scope.hero = ""
    $scope.spectrum = ""
    $scope.email = ""

    $scope.profileModel = ProfilePageData.getProfile[:id]

    $scope.can_edit () ->
        return $scope.loggedInUID == $scope.profileUID

    $scope.edit () ->
        $location.path("/profile/:id/edit")

    $scope.save () ->
        ProfilePageData.setUsername($scope.username)
        ProfilePageData.setAvatar($scope.avatar)
        ProfilePageData.setBlurb($scope.political_blurb)
        ProfilePageData.setHero($scope.political_hero)
        ProfilePageData.setSpectrum($scope.political_spectrum)
        SharedRequests.updateProfileByUID(id, $scope.username, $scope.avatar, $scope.blurb, $scope.hero, $scope.spectrum)
        $location.path("/profile/:id")

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
