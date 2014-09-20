angular.module("hyperadmin")
  .directive "flashMessages", (Flash) ->
    template: """
<aside class="alert alert-{{ flash.getMessage().type }}"
  ng-show="!!flash.getMessage().type">
  <p>{{ flash.getMessage().message }}</p>
</aside>
    """
    restrict: "E"
    link: (scope) ->
      scope.flash = Flash
