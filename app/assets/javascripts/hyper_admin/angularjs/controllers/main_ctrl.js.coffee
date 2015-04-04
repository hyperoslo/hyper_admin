angular.module("hyperadmin")
  .controller "MainCtrl", ($mdMedia, $mdSidenav) ->
    @toggleLeftNavigation = ->
      return if $mdMedia("gt-lg")
      $mdSidenav("leftNav").toggle()

    this
