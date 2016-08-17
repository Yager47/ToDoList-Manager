angular.module('todoApp').controller "TaskController", ($scope, $timeout, $routeParams, Upload, Comment, Task) ->
  
  $scope.init = () ->
    @commentService = new Comment($routeParams.id, $routeParams.list_id, serverErrorHandler)
    @taskService = new Task($routeParams.list_id, serverErrorHandler)

    $scope.task = @taskService.find $routeParams.id
    $scope.comments = @commentService.all()
    $scope.file = null
    
  $scope.addComment = (file) ->
    if file
      $scope.upload = Upload.upload({
        url: '/api/task_lists/' + $routeParams.list_id + '/tasks/' + $routeParams.id + '/comments'
        method: 'POST',
        file: file,
        data: {
          comment: {
            text: $scope.commentText
          }
        },
        fileFormDataName: 'comment[attach]'
      })

      $scope.upload.then( (response) ->        
        $scope.comments.unshift(response.data)
        $scope.commentText = ""  
        $scope.file = null
      )      

    else
      comment = @commentService.create(text: $scope.commentText)
      $scope.comments.unshift(comment)
      $scope.commentText = ""

  $scope.deleteComment = (comment) ->
    @commentService.delete(comment)
    $scope.comments.splice($scope.comments.indexOf(comment), 1)

  $scope.taskEdited = (taskDesc) ->
    @taskService.update($scope.task, description: taskDesc)

  $scope.commentEdited = (comment) ->
    @commentService.update(comment, text: comment.text)  

  $scope.attachName = (url) ->
    url.split("/").pop()

  serverErrorHandler = ->
    alert("There was a server error. Please, reload the page and try again.")