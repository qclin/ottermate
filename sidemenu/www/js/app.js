angular.module('ionicApp', ['ionic'])
  .controller('MainCtrl', function($scope, $ionicSideMenuDelegate) {
    $scope.toggleLeft = function() {
      $ionicSideMenuDelegate.toggleLeft()   
    }
  })

  .controller("LoginController", function($scope,$state) {
    $scope.login = function() {
      $state.go("menu.profile");
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
      $scope.users = resp.data
      console.log(resp.data)
    }, function(err){
      console.error('ERR', err);
    })
  })

  .controller("ChatsController", function($scope, $state, $http) {
    $http.get("http://localhost:3000/chats.json").then(function(resp){
      $scope.chats = resp.data
      console.log(resp.data)
    }, function(err) {
      console.error("ERR", err);
    })
  })
  
  .controller("SearchRoomsController", function($scope, $state, $http){
    $scope.search = {};
    $scope.searchRooms = function(){
      $state.go("menu.roomResults", $scope.search);
    };
  })

  .controller("RoomResultsController", function($scope, $state, $http, $stateParams) {
    // $scope.search is now pass in as $stateParams in the Url
    console.log($stateParams);

    //// *******petfriendly values are not being pass as boolean but are strings . . . need fixing

    $http.get("http://localhost:3000/rooms", {params: $stateParams}).then(function(resp){
      if(resp.data.length === 0){
        // maybe there's a better way for empty results
        $scope.msg = "no results match your criteria"
      }else{
        $scope.msg = "your search has return the following matches~!!"
        $scope.rooms = resp.data;
      }
      console.log(resp.data);
    }, function(err){
      console.error("ERR", err);
    })
  })
///////////// test out the following two controllers
  .controller("SearchMatesController", function($scope, $state, $http){
    $scope.search = {};
    $scope.searchMates = function(){
      state.go("menu.mateResults", $scope.search)
    };
  })

  .controller("MateResultsController", function($scope, $state, $http, $stateParams){
    $http.get("http://localhost:3000/users", {params:$stateParams}).then(function(resp){
      if(resp.data.length === 0){
        $scope.msg = "no mates are in your range"
      }else{
        $scope.msg = "looks like these folks are on the same vibe as you ~~~"
        $scope.mates = resp.data;
      }
      console.log(resp.data);
    }, function(err){
      console.error("ERR", err);
    })
  })

  .controller("PostRoomController", function($scope, $state, $http) {
    $scope.room = {};
    $scope.postRoom = function() {
    $scope.room.owner_id = 1;
      $http.post("http://localhost:3000/rooms", {room: $scope.room})
        .success(function (data,status) {
          $state.go("menu.profile");
        })
        .error(function (data,status) {
          // our post got rejected
          console.log("bad post! "+ JSON.stringify(data) + " status: "+ status);
        });
    };
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
            controller: "ProfileController",
            templateUrl: "templates/profile.html"
          }
        }
      })
      .state("menu.chatHistory", {
        url: "/chatHistory",
        views: {
          "menuContent": {
            controller: "ChatsController",
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
      .state("menu.searchRooms", {
        url: "/searchRooms",
        views: {
          "menuContent": {
            templateUrl: "templates/searchRoom.html"
          }
        }
      })
      .state("menu.roomResults", {
        url: "/roomresults?neighborhood&price_min&price_max&pet_friendly",
        views: {
          "menuContent": {
            templateUrl: "templates/allRooms.html"
          }
        }
      })
      /// these need to be test 
      .state("menu.searchMates", {
        url: "/searchMates",
        views: {
          "menuContent": {
            templateUrl: "templates/searchMates.html"
          }
        }
      })
      .state("menu.mateResults", {
        // change the rest of the criterias here 
        url: "/materesults?gender&description", 
        views: {
          "menuContent":{
            templateUrl: "templates/allMates.html"
          }
        }
      })
 		})
