angular.module("hyperadmin")
  .factory "Resource", ($location, $rootScope, $state, $urlRouter, Restangular) ->
    Restangular.all("admin/resource_classes").getList().then (resources) =>
      @resources = Restangular.stripRestangular resources

      registerStates()

    registerStates = =>
      @resources.forEach (resource) ->
        stateProvider
          .state "#{resource.plural}",
            url: "/admin/#{resource.plural}"
            templateUrl: -> "/admin/#{resource.plural}.html"
            controller: "IndexCtrl as indexCtrl"
            data:
              resource: resource
          .state "#{resource.plural}.new",
            url: "/new"
            templateUrl: -> "/admin/#{resource.plural}/new.html"
            controller: "NewCtrl as newCtrl"
            data:
              resource: resource
              mode: "new"
          .state "#{resource.plural}.show",
            url: "/:id"
            templateUrl: (params) ->
              "/admin/#{resource.plural}/#{params.id}.html"
            controller: "ShowCtrl as showCtrl"
            data:
              resource: resource
          .state "#{resource.plural}.edit",
            url: "/:id/edit"
            templateUrl: (params) ->
              "/admin/#{resource.plural}/#{params.id}/edit.html"
            controller: "EditCtrl as editCtrl"
            data:
              resource: resource
              mode: "edit"

      $state.get().forEach (state) =>
        return unless !!state.templateUrl
        url = state.templateUrl("nothing").replace(/undefined/, "(\\d+)").replace("\.html", "")
        match = $location.path().match("^#{url}$")

        $state.go state, id: match[1] if match

      $rootScope.$emit "resources:states:registered"

    menuStates = =>
      @resources.map (resource) ->
        list_state: "#{resource.plural}"
        label: resource.menu_label

    menuStates: menuStates
