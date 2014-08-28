angular.module("hyperadmin")
  .controller "FormCtrl", ($scope, Restangular) ->
    @submit = =>
      target = @meta.target
      method = @meta.method

      onError = (response) =>
        @errors = response.data

      onSuccess = (resource) =>
        # Do nothing yet

      if method == "post"
        Restangular.all(target).post(@resource).then onSuccess, onError
      else if method == "patch"
        Restangular.one(target).patch(@resource).then onSuccess, onError

    this
