angular.module("hyperadmin")
  .factory "Resource", ($location, $rootScope, $state, Restangular) ->
    Restangular.all("admin/resource_classes").getList().then (resources) =>
      @resources = Restangular.stripRestangular resources

      registerStates()

    registerStates = =>
      @resources.forEach (resource) ->
        stateProvider
          .state "list_#{resource.plural}",
            url: "/admin/#{resource.plural}"
            templateUrl: "/admin/#{resource.plural}.html"
            controller: "IndexCtrl as indexCtrl"
            data:
              resource: resource
          .state "new_#{resource.singular}",
            url: "/admin/#{resource.plural}/new"
            templateUrl: "/admin/#{resource.plural}/new.html"
            data:
              resource: resource
              mode: "new"
          .state "show_#{resource.singular}",
            url: "/admin/#{resource.plural}/:id"
            templateUrl: (params) ->
              "/admin/#{resource.plural}/#{params.id}.html"
            controller: "ShowCtrl as showCtrl"
            data:
              resource: resource
          .state "edit_#{resource.singular}",
            url: "/admin/#{resource.plural}/:id/edit"
            templateUrl: (params) ->
              "/admin/#{resource.plural}/#{params.id}/edit.html"
            data:
              resource: resource
              mode: "edit"

      $state.get().forEach (state) =>
        url = state.url.replace /:id/, "(\\d+)"
        match = $location.path().match("^#{url}$")

        $state.go state, id: match[1] if match

      $rootScope.$emit "resources:states:registered"

    menuStates = =>
      @resources.map (resource) ->
        list_state: "list_#{resource.plural}"
        label: resource.menu_label

    menuStates: menuStates
