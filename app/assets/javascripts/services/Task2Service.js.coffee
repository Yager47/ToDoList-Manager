angular.module('todoApp').factory 'Task2', ($resource, $http) ->
  class Task2
    constructor: (errorHandler) ->
      @service = $resource('/api/task_lists/:task_list_id/tasks/:id',
        {id: '@id'},
        {update: {method: 'PATCH'}})
      @errorHandler = errorHandler

      defaults = $http.defaults.headers
      defaults.patch = defaults.patch || {}
      defaults.patch['Content-Type'] = 'application/json'

    create: (attrs) ->
      new @service(task: attrs).$save ((task) -> attrs.id = task.id), @errorHandler
      attrs

    delete: (task) ->
      new @service().$delete {id: task.id}, (-> null), @errorHandler

    update: (task, attrs) ->
      new @service(task: attrs).$update {id: task.id}, (-> null), @errorHandler

    all: ->
      @service.query((-> null), @errorHandler)

    find: (id, successHandler) ->
      @service.get(id: id, ((task)-> 
        successHandler?(task)
        task), 
       @errorHandler)
