angular.module("hyperadmin")
  .controller "NewCtrl", ($state) ->
    @resource_class = $state.current.data.resource

    this
