angular.module("hyperadmin")
  .controller "EditCtrl", ($state) ->
    @resource_class = $state.current.data.resource

    this
