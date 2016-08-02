angular.module('todoApp').controller "DashboardController", ($scope, $routeParams, $location, TaskList) ->

  $scope.init = ->        
    @listsService = new TaskList(serverErrorHandler)
    $scope.lists = @listsService.all()

  $scope.createList = (name) ->
    @listsService.create name: name, (list) ->
        $location.url("/task_lists/#{list.id}")

  $scope.deleteList = (list, index) ->
    @listsService.delete list
    $scope.lists.splice index, 1

  serverErrorHandler = ->
    alert("There was a server error. Please, reload the page and try again.")
