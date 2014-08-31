angular.module("hyperadmin")
  .factory "Resource", ($rootScope, $state, Restangular) ->
    Restangular.all("admin/resource_classes").getList().then (resources) =>
      @resources = resources

      registerStates()

    registerStates = =>
      @resources.forEach (resource) ->
        stateProvider
          .state "list_#{resource.plural}",
            url: "/admin/#{resource.plural}"
            templateUrl: "/admin/#{resource.plural}.html"
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
            data:
              resource: resource
          .state "edit_#{resource.singular}",
            url: "/admin/#{resource.plural}/:id/edit"
            templateUrl: (params) ->
              "/admin/#{resource.plural}/#{params.id}/edit.html"
            data:
              resource: resource
              mode: "edit"

      # TODO :: Find a better way to navigate to the current state
      $state.go "list_#{@resources[0].plural}"

      $rootScope.$emit "resources:states:registered"

    menuStates = =>
      @resources.map (resource) ->
        list_state: "list_#{resource.plural}"
        label: resource.menu_label

    menuStates: menuStates
