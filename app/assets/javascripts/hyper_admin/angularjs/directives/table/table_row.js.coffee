angular.module("hyperadmin")
  .directive "tableRow", ->
    template: """
<td ng-repeat="attribute in attributes">
  <ng-include src="template(attribute)"></ng-include>
</td>
<td class="actions">
  <md-button class="md-primary" ui-sref=".show({ id: resource.id })">
    <md-icon md-svg-icon="navigation:ic_arrow_forward_24px" aria-label="Show">
    </md-icon>
  </md-button>

  <md-button ui-sref=".edit({ id: resource.id })">
    <md-icon md-svg-icon="editor:ic_mode_edit_24px" aria-label="Edit"></md-icon>
  </md-button>

  <md-button class="md-warn" ui-sref=".show({ id: resource.id })" delete-link>
    <md-icon md-svg-icon="action:ic_delete_24px" aria-label="Delete"></md-icon>
  </md-button>
</td>
    """
    restrict: "A"
    scope:
      attributes: "="
      resource: "="
    link: (scope) ->
      scope.template = (attr) -> "table-#{attr.type}"
