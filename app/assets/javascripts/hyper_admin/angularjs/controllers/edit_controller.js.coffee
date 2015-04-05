angular.module("hyperadmin")
  .controller "EditController", ($state, resourceClass) ->
    @resource_class = resourceClass

    this
