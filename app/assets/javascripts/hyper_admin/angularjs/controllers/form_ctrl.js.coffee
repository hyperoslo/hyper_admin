angular.module("hyperadmin")
  .controller "FormCtrl", ($scope, $state, Restangular) ->
    @resource = { }
    mode = $state.current.data.mode

    if mode == "new"
      method = "post"
      target = "admin/#{$scope.resourceClass.plural}"
    else
      method = "patch"
      target = "admin/#{$scope.resourceClass.plural}/#{$state.params.id}"

      Restangular.one(target).get().then (resource) =>
        @resource = resource

    @submit = =>
      onError = (response) =>
        @errors = response.data

      onSuccess = (resource) =>
        $state.go "^.show", id: resource.id

      if method == "post"
        Restangular.all(target).post(@resource).then onSuccess, onError
      else if method == "patch"
        Restangular.one(target).patch(@resource).then onSuccess, onError

    this
