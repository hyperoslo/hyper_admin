angular.module("hyperadmin")
  .factory "Resource", ->
    generateStates = =>
      @resources.forEach (resource) ->
        stateProvider
          .state "list_#{resource.plural}",
            url: "/admin/#{resource.plural}"
            templateUrl: "/admin/#{resource.plural}.html"
          .state "new_#{resource.singular}",
            url: "/admin/#{resource.plural}/new"
            templateUrl: "/admin/#{resource.plural}/new.html"
          .state "show_#{resource.singular}",
            url: "/admin/#{resource.plural}/:id"
            templateUrl: (params) ->
              "/admin/#{resource.plural}/#{params.id}.html"
          .state "edit_#{resource.singular}",
            url: "/admin/#{resource.plural}/:id/edit"
            templateUrl: (params) ->
              "/admin/#{resource.plural}/#{params.id}/edit.html"

    getResources = =>
     @resources = [
      {
        label: "Blog posts"
        singular: "article"
        plural: "articles"
      }, {
        label: "People"
        singular: "person"
        plural: "people"
      }
    ]

    states = =>
      @resources.map (resource) ->
        list_state: "list_#{resource.plural}"
        label: resource.label

    generateStates: generateStates
    getResources: getResources
    states: states
