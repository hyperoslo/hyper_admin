angular.module("hyperadmin")
  .directive "pageHeader", ->
    transclude: true
    template: """
<div class="row">
  <div class="col-xs-12">
    <header class="page-header" ng-transclude>
    </header>
  </div>
</div>
    """
    restrict: "E"
