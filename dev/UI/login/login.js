myApp.controller('LoginController', ["$scope", "$state", "$window", "$http",

  function($scope, $state, $window, $http) {
    $scope.statelogin = true ;
    console.log("DockerINT") ;
    console.log($scope.statelogin) ;
  }
]);
