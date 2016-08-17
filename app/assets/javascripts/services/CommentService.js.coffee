angular.module('todoApp').factory 'Comment', ($resource, $http) ->
  class Comment
    constructor: (taskId, listId, errorHandler) ->
      @service = $resource('/api/task_lists/:list_id/tasks/:task_id/comments/:id',
        {list_id: listId, task_id: taskId, id: '@id'},
        {update: {method: 'PATCH'}})
      @errorHandler = errorHandler

      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    create: (attrs) ->
      new @service(comment: attrs).$save ((comment) -> attrs.id = comment.id), @errorHandler
      attrs

    delete: (comment) ->
      new @service().$delete {id: comment.id}, (-> null), @errorHandler

    update: (comment, attrs) ->
      new @service(comment: attrs).$update {id: comment.id}, (-> null), @errorHandler

    all: ->
      @service.query((-> null), @errorHandler)
