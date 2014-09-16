angular.module("hyperadmin")
  .controller "ShowCtrl", ($state, Restangular) ->
    @resource_class = $state.current.data.resource
    Restangular.one("admin/#{@resource_class.plural}", $state.params.id).get().then (resource) =>
      @resource = Restangular.stripRestangular resource

    @template = (attribute) -> "show-#{attribute.type}"

    this
