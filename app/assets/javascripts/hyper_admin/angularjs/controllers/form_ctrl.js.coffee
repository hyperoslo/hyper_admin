angular.module("hyperadmin")
  .controller "FormCtrl", ($state, Restangular) ->
    @resource_class = $state.current.data.resource
    delete @resource_class.attributes.id
    delete @resource_class.attributes.created_at
    delete @resource_class.attributes.updated_at

    @resource = { }
    mode = $state.current.data.mode

    if mode == "new"
      method = "post"
      target = "admin/#{@resource_class.plural}"
    else
      method = "patch"
      target = "admin/#{@resource_class.plural}/#{$state.params.id}"

      Restangular.one(target).get().then (resource) =>
        @resource = resource

    @submit = =>
      onError = (response) =>
        @errors = response.data

      onSuccess = (resource) =>
        # Do nothing yet

      if method == "post"
        Restangular.all(target).post(@resource).then onSuccess, onError
      else if method == "patch"
        Restangular.one(target).patch(@resource).then onSuccess, onError

    this
