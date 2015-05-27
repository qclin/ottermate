angular.module('ionicApp', ['ionic'])
  .controller('MainCtrl', function($scope, $ionicSideMenuDelegate) {
    $scope.toggleLeft = function() {
      $ionicSideMenuDelegate.toggleLeft()   
    }
  })

  .controller("LoginController", function($scope,$state) {
    $scope.login = function() {
      $state.go("menu.profile");
      alert('hi?');
      // $http.post('/authenticate', {username:$scope.username, password:$scope.password})
      //   .success(function (data,status,headers,config) {
      //     $window.sessionStorage.token = data.token;
      //     $state.go('menu.profile');
      //   })
      //   .error(function (data,status,headers,config) {
      //     delete $window.sessionStorage.token;
      //     alert(data);
      //     // alert("Error: Unknown email/password combination");
      //   });
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
          alert("bad post! "+ JSON.stringify(data) + " status: "+ status);
        });
    };
  })

  .controller("ProfileController", function($scope, $http) {
    $http.get("http://localhost:3000/users.json").then(function(resp){
      alert(resp)

    }, function(err){
      console.error('ERR', err);
    })
    
      // .success(function(data) {
      //   alert("data retrieved: "+data);
      // })
      // .error(function(data,status) {
      //   alert("error"+data+status);
      // });
  })



  // .controller("ChatController", function($scope, $state, $http) {
  //   $scope.chat = function() {
  //     var convo = {
  //       from_id: $scope.from_id,
  //       to_id: $scope.to_id,
  //       msg: $scope.msg,
  //       read: $scope.read,
  //     };
  //     $http.post
  //   }
  // })




  .controller("PostRoomController", function($scope) {
  })

	.controller("SearchRoomController", function($scope) {
})

	.controller("SearchMatesController", function($scope) {
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

//             .state('menu.profile', {
//                 url: "/profile",
//                 views: {
//                     'menuContent'  :{
//                         templateUrl: "templates/profile.html"
//                     }
//                 }
//         });
// })


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

      })
			.state("menu.searchRoom", {
				url: "/searchRoom",
				views: {
					"menuContent": {
						templateUrl: "templates/searchRoom.html"
					}
				}
		})
			.state("menu.searchmates", {
				url: "/searchMates",
				views: {
					"menuContent": {
						templateUrl: "templates/searchMates.html"
					}
				}
		});
  })
