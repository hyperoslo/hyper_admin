angular.module("hyperadmin")
  .directive "formInput", ->
    template: """
<div>
  <ng-include src="type"></ng-include>
</div>
    """
    restrict: "E"
    scope:
      resource: "=resource"
      name: "=attr"
      placeholder: "=human"
      errors: "=errors"
      type: "=type"
