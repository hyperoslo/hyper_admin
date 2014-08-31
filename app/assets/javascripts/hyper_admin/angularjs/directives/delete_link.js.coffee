angular.module("hyperadmin")
  .directive "deleteLink", ($http) ->
    link: (scope, element, attributes) ->
      element.off("click").on "click", (event) ->
        event.preventDefault()

        href = element.attr("href")
        $http(method: "DELETE", url: href) if href
