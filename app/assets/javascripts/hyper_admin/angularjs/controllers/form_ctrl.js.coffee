angular.module("hyperadmin")
  .controller "FormCtrl", ($scope, $state, Restangular, Flash) ->
    @resource = { }
    mode = $state.current.data.mode

    if mode == "new"
      method = "post"
      target = "admin/#{$scope.resourceClass.plural}"
      successMessage = "#{$scope.resourceClass.singular_human} created successfully."
    else
      method = "patch"
      target = "admin/#{$scope.resourceClass.plural}/#{$state.params.id}"
      successMessage = "#{$scope.resourceClass.singular_human} updated successfully."

      Restangular.one(target).get().then (resource) =>
        @resource = resource

        $scope.resourceClass.attributes.forEach (attr) =>
          if attr.type == "date" or attr.type == "datetime"
            if @resource[attr.key]
              @resource[attr.key] = new Date @resource[attr.key]

    [ "id", "created_at", "updated_at" ].forEach (key) ->
      _.remove $scope.resourceClass.attributes, (attr) ->
        attr.key == key

    prettifyErrors = (errors) ->
      result = { }
      for own attr of errors
        attrSchema = _.find $scope.resourceClass.attributes, (attribute) =>
          attribute.key == attr

        result[attrSchema.human] = errors[attr]

      result

    @submit = =>
      onError = (response) =>
        @errors = prettifyErrors response.data

      onSuccess = (resource) =>
        $state.go "^.show", id: resource.id
        Flash.setMessage "success", successMessage

      if method == "post"
        Restangular.all(target).post(@resource).then onSuccess, onError
      else if method == "patch"
        Restangular.one(target).patch(@resource).then onSuccess, onError

    this
