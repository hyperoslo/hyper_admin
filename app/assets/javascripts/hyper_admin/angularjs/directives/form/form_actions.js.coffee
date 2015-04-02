angular.module("hyperadmin")
  .directive "formActions", ->
    template: """
<div class="form-group">
  <div class="col-sm-offset-2 col-sm-10">
    <md-button type="submit" class="md-primary md-raised"
      ng-disabled="form.$invalid">Submit</md-button>
    <md-button class="md-warn" ui-sref="^">Cancel</a>
  </div>
</div>
    """
    restrict: "E"
    scope:
      cancelState: "=cancelState"
      form: "=form"
