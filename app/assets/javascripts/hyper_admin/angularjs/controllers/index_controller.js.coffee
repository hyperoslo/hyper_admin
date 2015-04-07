angular.module("hyperadmin")
  .controller "IndexController", ($scope, $state, Restangular, resourceClass) ->
    @resource_class = resourceClass
    Restangular.all("admin/#{resourceClass.plural}").getList().then (resources) =>
      @resources = Restangular.stripRestangular resources

      $scope.$on "resource:created", (event, resource) =>
        @resources.push resource

      $scope.$on "resource:updated", (event, resource) =>
        @resources.forEach (res, index) =>
          if res.id == resource.id
            return @resources[index] = resource

    this
