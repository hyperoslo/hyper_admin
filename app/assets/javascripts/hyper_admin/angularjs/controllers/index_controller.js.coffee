angular.module("hyperadmin")
  .controller "IndexController", ($scope, $location, $state, Restangular, resourceClass) ->
    @pagination =
      buttonsDisabled: false
      page: ($location.search().page || 1)
      pages: [ 1, 2, 3, 4, 5 ]

    @resource_class = resourceClass

    $scope.$on "resource:created", (event, resource) =>
      @resources.push resource

    $scope.$on "resource:updated", (event, resource) =>
      @resources.forEach (res, index) =>
        if res.id == resource.id
          return @resources[index] = resource

    @loadPage = (callback) =>
      $location.search 'page', @pagination.page

      Restangular.all("admin/#{resourceClass.plural}")
        .getList(page: @pagination.page).then (resources) =>
          @resources = Restangular.stripRestangular resources

          callback() if callback?

    @gotoPrevPage = =>
      @pagination.buttonsDisabled = true

      @pagination.page--
      @loadPage => @pagination.buttonsDisabled = false

    @gotoNextPage = =>
      @pagination.buttonsDisabled = true

      @pagination.page++
      @loadPage => @pagination.buttonsDisabled = false

    @gotoPage = (page) =>
      @pagination.buttonsDisabled = true

      @pagination.page = page
      @loadPage => @pagination.buttonsDisabled = false

    @loadPage()

    this
