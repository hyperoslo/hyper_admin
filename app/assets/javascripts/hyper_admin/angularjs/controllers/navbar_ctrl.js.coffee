angular.module("hyperadmin")
  .controller "NavbarCtrl", (Restangular) ->
    Restangular.all("admin/resource_classes").getList().then (resources) =>
      @resources = resources.map (resource) ->
        list_state: "#{resource.plural}"
        label: resource.menu_label

    this
