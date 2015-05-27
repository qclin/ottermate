angular.module('ionicApp', ['ionic'])
  .controller('MainCtrl', function($scope, $ionicSideMenuDelegate) {
    $scope.toggleLeft = function() {
      $ionicSideMenuDelegate.toggleLeft()   
    }
  })

  .controller("LoginController", function($scope,$state) {
    $scope.login = function() {
      alert('hi?');
      $http.post('/authenticate', {username:$scope.username, password:$scope.password})
        .success(function (data,status,headers,config) {
          $window.sessionStorage.token = data.token;
          $state.go('menu.profile');
        })
        .error(function (data,status,headers,config) {
          delete $window.sessionStorage.token;
          alert(data);
          // alert("Error: Unknown email/password combination");
        });
    };
  })

  .controller("SignUpController", function($scope, $state, $http) {
    $scope.signup = function() {
      var formdata = {
        name: $scope.name,
        password: $scope.password,
        email: $scope.email,
        phone: $scope.phone
      };
      $http.post("http://localhost:3000/users",formdata)
        .success(function (data,status) {
          $state.go("menu.profile");
        })
        .error(function (data,status) {
          // our post got rejected
          alert("bad post! "+JSON.stringify(data) + " status: "+status);
        });
    };
  })

  .controller("PostRoomController", function($scope) {
    $scope.posts = ["here","is","some","dummy","data"];
  })

  .factory('authInterceptor', function($q, $window, $location) {
    return {
      request: function(config) {
        config.headers = config.headers || {};
        if ($window.sessionStorage.token) {
          config.headers.Authorization = 'Bearer ' + $window.sessionStorage.token;
        }
        return config;
      },
      response: function(response) {
        if (response.status === 401) {
          delete $window.sessionStorage.token;
          $location.path('/login');
        }
        return response || $q.when(response);
      }
    };
  })

  .config(function($stateProvider, $urlRouterProvider, $httpProvider) {
    $httpProvider.interceptors.push('authInterceptor');
    $urlRouterProvider.otherwise("/login");

    $stateProvider
      // states that don't have a sidemenu
      .state("login", {
        url: "/login",
        templateUrl: "templates/login.html"
      })
      .state("signup", {
        url: "/signup",
        templateUrl: "templates/signup.html"
      })

      // states that include a sidemenu
      .state("menu", {
        url: "/menu",
        // abstract causes this state to only be accessible through it's child states
        abstract: true,
        templateUrl: "templates/menu.html"
      })
      .state("menu.profile", {
        url: "/profile",
        views: {
          "menuContent": {
            templateUrl: "templates/profile.html"
          }
        }
      })
      .state("menu.chatHistory", {
        url: "/chatHistory",
        views: {
          "menuContent": {
            templateUrl: "templates/chatHistory.html"
          }
        }
      })
      .state("menu.postRoom", {
        url: "/postRoom",
        views: {
          "menuContent": {
            templateUrl: "templates/postRoom.html"
          }
        }
      });
  })