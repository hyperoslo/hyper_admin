angular.module("hyperadmin")
  .directive "deleteLink", ($http, $mdDialog) ->
    link: (scope, element, attributes) ->
      element.off("click").on "click", (event) ->
        event.preventDefault()

        $mdDialog.show
          template: """
            <md-dialog>
              <md-dialog-content>
                <h3>Confirm</h3>
                <p>Are you sure you want to delete this?</p>
              </md-dialog-content>
              <div class="md-actions">
                <md-button ng-click="delete()" class="md-warn">
                  Delete
                </md-button>
                <md-button ng-click="close()" class="">
                  Cancel
                </md-button>
              </div>
            </md-dialog>
          """

          controller: ($rootScope, $scope, $mdDialog, $mdToast, $state) ->
            href = element.attr("href")
            $scope.delete = ->
              $http(method: "DELETE", url: href).then (response) ->
                $mdDialog.hide()

                $mdToast.showSimple "Deleted successfully!"

                $state.go "index"

            $scope.close = ->
              $mdDialog.hide()
