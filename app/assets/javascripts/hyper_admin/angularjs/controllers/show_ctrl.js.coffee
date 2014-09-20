angular.module("hyperadmin")
  .controller "ShowCtrl", ($state, Restangular, resourceClass) ->
    @resource_class = resourceClass
    Restangular.one("admin/#{resourceClass.plural}", $state.params.id).get().then (resource) =>
      @resource = Restangular.stripRestangular resource

    @template = (attribute) -> "show-#{attribute.type}"

    this
