angular.module("hyperadmin")
  .directive "formActions", ->
    template: """
<div class="form-group">
  <div class="col-sm-offset-2 col-sm-10">
    <button type="submit" class="btn btn-primary" ng-disabled="form.$invalid">
      Submit
    </button>
    <a class="btn btn-danger" ui-sref="^">Cancel</a>
  </div>
</div>
    """
    restrict: "E"
    scope:
      cancelState: "=cancelState"
      form: "=form"
