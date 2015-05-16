angular.module("hyperadmin")
  .controller "IndexController", ($scope, $location, $state, Restangular, resourceClass) ->
    @resourceUrl = "/admin/#{resourceClass.plural}.json"

    @resource_class = resourceClass

    this
