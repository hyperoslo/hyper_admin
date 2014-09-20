angular.module("hyperadmin")
  .directive "formInputGroup", ->
    template: """
<div class="form-group has-feedback"
  ng-class="{ 'field_with_errors': !!errors }">
  <label class="col-sm-2 control-label" for="{{ attr }}">
    {{ human }}
  </label>

  <form-input attr="attr" human="human"
    resource="resource" errors="errors"
    type="type">
  </form-input>
</div>
    """
    restrict: "E"
    scope:
      resource: "=resource"
      attribute: "=attribute"
      attr: "=attr"
      errors: "=errors"
      human: "=human"
      type: "=type"
