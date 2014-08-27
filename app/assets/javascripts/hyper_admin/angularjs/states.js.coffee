angular.module("hyperadmin")
  .config ($locationProvider, $stateProvider, $urlRouterProvider) ->
    $locationProvider.html5Mode true

    $urlRouterProvider.otherwise "/"
