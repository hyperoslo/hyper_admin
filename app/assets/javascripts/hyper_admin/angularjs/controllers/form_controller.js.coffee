angular.module("hyperadmin")
  .controller "FormController", ($scope, $mdToast, $state, Restangular) ->
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

        $scope.resourceClass.form_attributes.forEach (attr) =>
          if attr.type == "date" or attr.type == "datetime"
            if @resource[attr.key]
              @resource[attr.key] = new Date @resource[attr.key]

    [ "id", "created_at", "updated_at" ].forEach (key) ->
      _.remove $scope.resourceClass.form_attributes, (attr) ->
        attr.key == key

    prettifyErrors = (errors) ->
      result = { }
      for own attr of errors
        attrSchema = _.find $scope.resourceClass.form_attributes, (attribute) =>
          attribute.key == attr

        result[attrSchema.human] = errors[attr]

      result

    @submit = =>
      onError = (response) =>
        @errors = prettifyErrors response.data

      onSuccess = (resource) =>
        switch mode
          when "new"
            $mdToast.showSimple "Saved successfully!"
            $scope.$emit "resource:created", resource
          when "edit"
            $mdToast.showSimple "Updated successfully!"
            $scope.$emit "resource:updated", resource

        $state.go "^.show", id: resource.id

      if method == "post"
        Restangular.all(target).post(@resource).then onSuccess, onError
      else if method == "patch"
        Restangular.one(target).patch(@resource).then onSuccess, onError

    this
