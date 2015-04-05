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
        controller: "IndexCtrl as indexCtrl"
        resolve:
          resourceClass: ($stateParams, Restangular) ->
            Restangular.one("admin/resource_classes", $stateParams.pluralName).get()
        data:
          resource: "resource"
      .state "index.new",
        url: "/new"
        templateUrl: (params) ->
          "/admin/#{params.pluralName}/new.html"
        controller: "NewCtrl as newCtrl"
        data:
          mode: "new"
      .state "index.show",
        url: "/:id"
        templateUrl: (params) ->
          "/admin/#{params.pluralName}/#{params.id}.html"
        controller: "ShowCtrl as showCtrl"
        data:
          resource: "resource"
      .state "index.edit",
        url: "/:id/edit"
        templateUrl: (params) ->
          "/admin/#{params.pluralName}/#{params.id}/edit.html"
        controller: "EditCtrl as editCtrl"
        data:
          resource: "resource"
          mode: "edit"
