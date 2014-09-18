angular.module("hyperadmin")
  .controller "EditCtrl", ($state, resourceClass) ->
    @resource_class = resourceClass

    this
