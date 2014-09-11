angular.module("hyperadmin")
  .directive "formActions", ->
    template: """
<div class="form-group">
  <div class="col-sm-offset-2 col-sm-10">
    <button type="submit" class="btn btn-primary">Submit</button>
    <a class="btn btn-danger" ui-sref="{{ cancelState }}">Cancel</a>
  </div>
</div>
    """
    restrict: "E"
    scope:
      cancelState: "=cancelState"
