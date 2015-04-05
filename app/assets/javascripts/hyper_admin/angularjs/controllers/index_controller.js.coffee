angular.module("hyperadmin")
  .controller "IndexController", ($state, Restangular, resourceClass) ->
    @resource_class = resourceClass
    Restangular.all("admin/#{resourceClass.plural}").getList().then (resources) =>
      @resources = Restangular.stripRestangular resources

    this
