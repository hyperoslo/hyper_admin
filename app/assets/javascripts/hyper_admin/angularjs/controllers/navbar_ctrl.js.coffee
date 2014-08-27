angular.module("hyperadmin")
  .controller "NavbarCtrl", ($rootScope, Resource) ->
    $rootScope.$on "resources:states:registered", =>
      @resources = Resource.menuStates()

    this
