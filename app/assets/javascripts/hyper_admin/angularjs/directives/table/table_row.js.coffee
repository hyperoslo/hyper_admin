angular.module("hyperadmin")
  .directive "tableRow", ->
    template: """
<td ng-repeat="attribute in attributes">
  <ng-include src="template(attribute)"></ng-include>
</td>
<td class="actions">
  <md-button class="md-primary" ui-sref=".show({ id: resource.id })">Show</md-button>
  <md-button ui-sref=".edit({ id: resource.id })">Edit</md-button>
  <md-button class="md-warn" ui-sref=".show({ id: resource.id })" delete-link>Delete</md-button>
</td>
    """
    restrict: "A"
    scope:
      attributes: "="
      resource: "="
    link: (scope) ->
      scope.template = (attr) -> "table-#{attr.type}"
