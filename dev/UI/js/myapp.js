var myApp = angular.module('myApp', ['ui.router']);

myApp.config(function($stateProvider, $urlRouterProvider) {

  $stateProvider

    .state('dashboard', {
       url: '/dashboard',
       templateUrl: 'dashboard/dashboard.html'
    })

    .state('search', {
       url: '/search',
       templateUrl: 'search/search.html'
    })

    .state('settings', {
       url: '/settings',
       templateUrl: 'settings/settings.html'
    })



    $urlRouterProvider.otherwise('dashboard');

});

myApp.controller('GlobalController', ["$scope", "$state", "$timeout", "$window",

  function($scope, $state, $timeout, $window) {
    console.log("Global") ;
    $scope.gotoDashboard = function() {
      $state.go('dashboard')
    } ;
    $scope.gotoSettings = function() {
      $state.go('settings')
    } ;
    $scope.gotoSearch = function() {
      $state.go('search')
    } ;
  }
]);
