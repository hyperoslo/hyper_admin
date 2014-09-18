angular.module("hyperadmin")
  .directive "tableRow", ->
    template: """
<td ng-repeat="attribute in attributes">
  <ng-include src="template(attribute)"></ng-include>
</td>
<td>
  <a ui-sref=".show({ id: resource.id })">Show</a>
  <a ui-sref=".edit({ id: resource.id })">Edit</a>
  <a ui-sref=".show({ id: resource.id })" delete-link>Destroy</a>
</td>
    """
    restrict: "A"
    scope:
      attributes: "="
      resource: "="
    link: (scope) ->
      scope.template = (attr) -> "table-#{attr.type}"
