angular.module("hyperadmin")
  .controller "IndexController", ($scope, $location, $state, Restangular, resourceClass, resourcePages) ->
    allPages = resourcePages

    @resourceUrl = "/admin/#{resourceClass.plural}.json"

    @resource_class = resourceClass

    this
