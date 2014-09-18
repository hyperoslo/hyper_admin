angular.module("hyperadmin")
  .controller "NewCtrl", ($state, resourceClass) ->
    @resource_class = resourceClass

    this
