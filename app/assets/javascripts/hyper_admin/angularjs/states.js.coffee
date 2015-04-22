angular.module("hyperadmin")
  .config ($locationProvider, $stateProvider, $urlRouterProvider) ->
    $locationProvider.html5Mode true

    $stateProvider
      .state "dashboard",
        url: "/admin"
        templateUrl: "/admin?format=html"
        controller: ->
      .state "index",
        url: "/admin/:pluralName"
        templateUrl: (params) ->
          "/admin/#{params.pluralName}.html"
        controller: "IndexController as indexController"
        resolve:
          resourceClass: ($stateParams, Restangular) ->
            Restangular.one("admin/resource_classes", $stateParams.pluralName).get()
          resourcePages: ($http, $q, $stateParams) ->
            deferred = $q.defer()

            $http.get("admin/resource_classes/#{$stateParams.pluralName}/count.json")
              .success (data) -> deferred.resolve(data.pages)

            deferred.promise
        data:
          resource: "resource"
      .state "index.new",
        url: "/new"
        templateUrl: (params) ->
          "/admin/#{params.pluralName}/new.html"
        controller: "NewController as newController"
        data:
          mode: "new"
      .state "index.show",
        url: "/:id"
        templateUrl: (params) ->
          "/admin/#{params.pluralName}/#{params.id}.html"
        controller: "ShowController as showController"
        data:
          resource: "resource"
      .state "index.edit",
        url: "/:id/edit"
        templateUrl: (params) ->
          "/admin/#{params.pluralName}/#{params.id}/edit.html"
        controller: "EditController as editController"
        data:
          resource: "resource"
          mode: "edit"
