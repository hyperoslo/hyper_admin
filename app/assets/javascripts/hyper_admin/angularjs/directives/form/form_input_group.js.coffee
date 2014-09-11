angular.module("hyperadmin")
  .directive "formInputGroup", ->
    template: """
<div class="form-group has-feedback"
  ng-class="{ 'field_with_errors': !!errors }">
  <label class="col-sm-2 control-label" for="{{ attr }}">
    {{ human }}
  </label>

  <form-input attr="attr" human="human"
    errors="errors" model="model">
  </form-input>
</div>
    """
    restrict: "E"
    scope:
      attr: "=attr"
      errors: "=errors"
      human: "=human"
      model: "=model"
