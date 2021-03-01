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

    .state('login', {
       url: '/login',
       templateUrl: 'login/login.html'
    })

    $urlRouterProvider.otherwise('login');

});

myApp.controller('GlobalController', ["$scope", "$state", "$timeout", "$window",

  function($scope, $state, $timeout, $window) {
    console.log("Global") ;
    $scope.displayheader = true;
    console.log($scope.state) ;

    $scope.gotoDashboard = function() {
      $state.go('dashboard')
    } ;
    $scope.gotoSettings = function() {
      $state.go('settings')
    } ;
    $scope.gotoSearch = function() {
      $state.go('search')
    } ;
    $scope.currState = $state ;
    $scope.$watch('currState.current.name', function(newValue, oldValue) {
      $scope.currStateName = newValue;
      console.log("went to " + $scope.currStateName) ;
      if( newValue == 'login') {
        $scope.displayheader = false;
      }
      else {
        $scope.displayheader = true;
      }
  }) ; }
]);
