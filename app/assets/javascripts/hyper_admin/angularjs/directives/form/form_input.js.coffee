angular.module("hyperadmin")
  .directive "formInput", ->
    template: """
<div class="col-sm-10" ng-class="{ field_with_errors: !!errors }">
  <ng-include src="type"></ng-include>
  <span class="glyphicon glyphicon-remove form-control-feedback"></span>
  <span class="help-block error" ng-show="!!errors" ng-repeat="error in errors">
    {{ placeholder }} {{ error }}
  </span>
</div>
    """
    restrict: "E"
    scope:
      resource: "=resource"
      name: "=attr"
      placeholder: "=human"
      errors: "=errors"
      type: "=type"
