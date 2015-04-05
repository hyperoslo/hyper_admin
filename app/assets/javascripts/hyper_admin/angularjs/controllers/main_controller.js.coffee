angular.module("hyperadmin")
  .controller "MainController", ($mdMedia, $mdSidenav) ->
    @toggleLeftNavigation = ->
      return if $mdMedia("gt-lg")
      $mdSidenav("leftNav").toggle()

    this
