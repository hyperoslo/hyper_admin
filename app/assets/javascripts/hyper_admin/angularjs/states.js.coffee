angular.module("hyperadmin")
  .config ($locationProvider, $stateProvider, $urlRouterProvider) ->
    $locationProvider.html5Mode true

    $stateProvider
      .state "list_articles",
        url: "/admin/articles"
        templateUrl: "/admin/articles.html"
      .state "new_article",
        url: "/admin/articles/new"
        templateUrl: "/admin/articles/new.html"
      .state "show_article",
        url: "/admin/articles/:id"
        templateUrl: (params) ->
          "/admin/articles/#{params.id}.html"
      .state "edit_article",
        url: "/admin/articles/:id/edit"
        templateUrl: (params) ->
          "/admin/articles/#{params.id}/edit.html"

      .state "list_people",
        url: "/admin/people"
        templateUrl: "/admin/people.html"
      .state "new_person",
        url: "/admin/people/new"
        templateUrl: "/admin/people/new.html"
      .state "show_person",
        url: "/admin/people/:id"
        templateUrl: (params) ->
          "/admin/people/#{params.id}.html"
      .state "edit_person",
        url: "/admin/people/:id/edit"
        templateUrl: (params) ->
          "/admin/people/#{params.id}/edit.html"

    $urlRouterProvider.otherwise "/"
