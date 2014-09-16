angular.module("hyperadmin")
  .directive "tableRow", ->
    template: """
<td ng-repeat="attribute in attributes">
  {{ resource[attribute.key] }}
</td>
<td>
  <a ui-sref="{{ resourceClass.plural }}.show({ id: resource.id })">
    Show
  </a>
  <a ui-sref="{{ resourceClass.plural }}.edit({ id: resource.id })">
    Edit
  </a>
  <a ui-sref="{{ resourceClass.plural }}.show({ id: resource.id })" delete-link>
    Destroy
  </a>
</td>
    """
    restrict: "A"
    scope:
      attributes: "="
      resource: "="
