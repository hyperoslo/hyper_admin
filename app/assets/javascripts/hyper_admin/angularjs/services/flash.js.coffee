angular.module("hyperadmin")
  .factory "Flash", ($rootScope) ->
    queue = []
    currentMessage = { }

    $rootScope.$on "$viewContentLoaded", ->
      currentMessage = queue.shift() || { }

    setMessage: (type, message) ->
      queue.push
        type: type
        message: message

    getMessage: ->
      currentMessage
