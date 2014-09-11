angular.module("hyperadmin")
  .directive "resourceForm", ->
    template: """
<div class="row">
  <div class="col-xs-12" ng-controller="FormCtrl as formCtrl">
    <form-errors errors="formCtrl.errors"></form-errors> 

    <form class="form-horizontal" name="form" ng-submit="formCtrl.submit()" novalidate>
      <form-input-group ng-repeat="(attr, human) in resourceClass.attributes"
        attr="attr"
        errors="formCtrl.errors[attr]"
        human="human"
        model="formCtrl.resource[attr]">
      </form-input-group>

      <form-actions cancel-state="resourceClass.plural"
    </form>
  </div>
</div>
    """
    restrict: "E"
    scope:
      resourceClass: "=resourceClass"
    controller: ($scope) ->
      [ "id", "created_at", "updated_at" ].forEach (attr) ->
        delete $scope.resourceClass.attributes[attr]
