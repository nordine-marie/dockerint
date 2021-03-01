myApp.controller('DashboardController', ["$scope", "$state", "$window", "$http",

  function($scope, $state, $window, $http) {
    console.log("DockerINT") ;
    const progress = document.querySelector('.progress-done');
    console.log(progress) ;
    progress.style.width = progress.getAttribute('data-done') + '%';
    progress.style.opacity = 1;



  }
]);
