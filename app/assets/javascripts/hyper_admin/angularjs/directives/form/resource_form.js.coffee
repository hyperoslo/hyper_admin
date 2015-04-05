angular.module("hyperadmin")
  .directive "resourceForm", ->
    template: """
<div class="row">
  <div ng-controller="FormController as formController">
    <form-errors errors="formController.errors"></form-errors> 

    <form name="form" ng-submit="formController.submit()" novalidate>
      <div ng-repeat="attr in resourceClass.form_attributes">
        <ng-include src='attr.type'></ng-include>
      </div>

      <form-actions form="form" cancel-state="resourceClass.plural">
      </form-actions>
    </form>
  </div>
</div>
    """
    restrict: "E"
    scope:
      resourceClass: "=resourceClass"
    controller: ($scope) ->
      [ "id", "created_at", "updated_at" ].forEach (attr) ->
        delete $scope.resourceClass.form_attributes[attr]
