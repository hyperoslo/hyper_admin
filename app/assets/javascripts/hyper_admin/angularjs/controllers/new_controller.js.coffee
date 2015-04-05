angular.module("hyperadmin")
  .controller "NewController", ($state, resourceClass) ->
    @resource_class = resourceClass

    this
