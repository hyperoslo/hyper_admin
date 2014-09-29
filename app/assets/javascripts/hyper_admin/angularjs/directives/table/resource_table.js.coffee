angular.module("hyperadmin")
  .directive "resourceTable", ->
    template: """
<table class="table table-striped">
  <thead>
    <tr>
      <th ng-repeat="attribute in resourceClass.index_attributes">
        {{ attribute.human }}
      </th>
      <th>Actions</th>
    </tr>
  </thead>
  <tbody>
    <tr table-row attributes="resourceClass.index_attributes"
      ng-repeat="resource in resources" resource="resource">
    </tr>
  </tbody>
</table>
    """
    scope:
      resourceClass: "="
      resources: "="
    restrict: "E"
