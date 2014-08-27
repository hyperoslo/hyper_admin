angular.module("hyperadmin")
  .controller "MainCtrl", (Resource) ->
    Resource.getResources()
    Resource.generateStates()

    this
