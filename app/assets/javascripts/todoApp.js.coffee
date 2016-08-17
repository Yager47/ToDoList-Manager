todoApp = angular.module('todoApp', ['ngResource', 'ngRoute', 'mk.editablespan', 'ui.sortable', 'ngFileUpload'])

todoApp.config ($httpProvider) ->
  authToken = $("meta[name=\"csrf-token\"]").attr("content")
  $httpProvider.defaults.headers.common["X-CSRF-TOKEN"] = authToken

todoApp.config ($routeProvider, $locationProvider) ->
  $locationProvider.html5Mode true
  $routeProvider.when '/', redirectTo: '/dashboard'
  $routeProvider.when '/dashboard', templateUrl: '/templates/dashboard.html', controller: 'DashboardController'
  $routeProvider.when '/task_lists/:list_id', templateUrl: '/templates/task_list.html', controller: 'TodoListController'  
  $routeProvider.when '/task_lists/:list_id/tasks/:id', templateUrl: '/templates/task.html', controller: 'TaskController' 

# for angularjs to work with turbolinks
$(document).on 'page:load', ->
  $('[ng-app]').each ->
    module = $(this).attr('ng-app')
    angular.bootstrap(this, [module])
