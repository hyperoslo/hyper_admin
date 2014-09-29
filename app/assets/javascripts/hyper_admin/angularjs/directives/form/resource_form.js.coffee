angular.module("hyperadmin")
  .directive "resourceForm", ->
    template: """
<div class="row">
  <div class="col-xs-12" ng-controller="FormCtrl as formCtrl">
    <form-errors errors="formCtrl.errors"></form-errors> 

    <form class="form-horizontal" name="form" ng-submit="formCtrl.submit()" novalidate>
      <form-input-group ng-repeat="attribute in resourceClass.form_attributes"
        resource="formCtrl.resource"
        attr="attribute.key"
        errors="formCtrl.errors[attribute.key]"
        human="attribute.human"
        type="attribute.type">
      </form-input-group>

      <form-actions form="form" cancel-state="resourceClass.plural"
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