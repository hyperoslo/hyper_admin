angular.module("hyperadmin")
  .controller "NavbarCtrl", (Resource) ->
    @resources = Resource.states()

    this
