angular.module("hyperadmin")
  .controller "IndexCtrl", ($state, Restangular) ->
    @resource_class = $state.current.data.resource
    Restangular.all("admin/#{@resource_class.plural}").getList().then (resources) =>
      @resources = Restangular.stripRestangular resources

    this
