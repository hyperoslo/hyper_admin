angular.module("hyperadmin", [ "restangular", "ui.router" ])
  .config ($httpProvider) ->
    authToken = $("meta[name=\"csrf-token\"]").attr("content")
    $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken
    $httpProvider.defaults.headers.common["X-Requested-With"] = "XMLHttpRequest"
    $httpProvider.defaults.headers.common["Accept"] = "text/html,application/json"

  .config ($stateProvider) ->
    window.stateProvider = $stateProvider

  .config (RestangularProvider) ->
    RestangularProvider.setRequestSuffix '.json'
