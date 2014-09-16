angular.module("hyperadmin")
  .filter "truncate", ->
    (input, limit = 30) ->
      return ''    unless input
      return input unless input.length > limit

      result = input.substring 0, limit - 1
      result + "…"
