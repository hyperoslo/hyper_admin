angular.module("hyperadmin")
  .directive "formErrors", ->
    template: """
<section class="panel panel-danger" ng-if="errors">
  <div class="panel-heading">
    <h3 class="panel-title">Errors occurred</h3>
  </div>

  <div class="panel-body">
    <div ng-repeat="(attr, messages) in errors">
      <h4>{{ attr }}</h4>

      <ul>
        <li ng-repeat="message in messages">{{ message }}</li>
      </ul>
    </div>
  </div>
</section>
    """
    restrict: "E"
    scope:
      errors: "=errors"
