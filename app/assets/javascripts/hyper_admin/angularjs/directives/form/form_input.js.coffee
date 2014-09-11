angular.module("hyperadmin")
  .directive "formInput", ->
    template: """
<div class="col-sm-10" ng-class="{ field_with_errors: !!errors }">
  <input class="form-control" name="{{ name }}" type="{{ type }}"
    placeholder="{{ placeholder }}" ng-model="model">
  <span class="glyphicon glyphicon-remove form-control-feedback"></span>
  <span class="help-block error" ng-show="!!errors" ng-repeat="error in errors">
    {{ placeholder }} {{ error }}
  </span>
</div>
    """
    restrict: "E"
    scope:
      name: "=attr"
      placeholder: "=human"
      model: "=model"
      errors: "=errors"
    controller: ($scope) ->
      $scope.type = "text"
