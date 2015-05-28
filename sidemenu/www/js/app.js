angular.module('ionicApp', ['ionic'])
  .controller('MainCtrl', function($scope, $ionicSideMenuDelegate, $window, $location) {
    $scope.toggleLeft = function() {
      $ionicSideMenuDelegate.toggleLeft()   
    };
    $scope.logout = function() {
      delete $window.sessionStorage.token;
      $location.path('/login');
    };
  })

  .controller("LoginCtrl", function($scope,$state,$http,$window) {
    $scope.user = {};
    $scope.login = function() {
      $http.post('http://localhost:3000/authenticate', {user:$scope.user})
        .success(function (data,status,headers,config) {
          $window.sessionStorage.token = data.token;
          
          // debugging code
          $http.get('http://localhost:3000/authtest')
            .success(function(data) {
              $state.go('menu.profile');
            })
            .error(function(data) {
              alert("sad "+data);
            });
        })
        .error(function (data,status,headers,config) {
          delete $window.sessionStorage.token;
          // alert(data);
          alert("Error: Unknown email/password combination");
        });
    };
  })

  .controller("SignUpCtrl", function($scope, $state, $http) {
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

  .controller("ProfileCtrl", function($scope, $http) {
    $scope.user = {}
    $http.get("http://localhost:3000/current_user")
      .success(function(resp){
        $scope.user = resp
        console.log(resp)
      })
      .error(function(err){
        console.error('ERR', err);
      });
  })

  .controller("ConversationsCtrl", function($scope, $state, $http) {
    $http.get("http://localhost:3000/chats")
      .success(function(resp){
        $scope.chats = resp.data
        console.log(resp.data)
      })
      .error(function(err) {
        console.error("ERR", err);
      });
  })

  
  .controller("SearchRoomsCtrl", function($scope, $state, $http){
    $scope.search = {};
    $scope.searchRooms = function(){
      $state.go("menu.roomResults", $scope.search);
    };
  })

  .controller("RoomResultsCtrl", function($scope, $state, $http, $stateParams) {
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
   .controller("GetRoomCtrl",function($scope, $state, $http, $stateParams){
    console.log($stateParams.id);
    $http.get("http://localhost:3000/rooms/"+$stateParams.id).then(function(resp){
      console.log(resp.data);
      $scope.room = resp.data;
    }, function(err){
      console.error("ERR", err);
    })
  })


///////////// test out the following two controllers
  .controller("SearchMatesCtrl", function($scope, $state, $http){
    $scope.search = {};
    $scope.searchMates = function(){
      $state.go("menu.mateResults", $scope.search)
    };
  })

  .controller("MateResultsCtrl", function($scope, $state, $http, $stateParams){
    $http.get("http://localhost:3000/users", {params:$stateParams}).then(function(resp){
      console.log(resp.data);
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
  .controller("GetMateCtrl",function($scope, $state, $http, $stateParams){
    console.log($stateParams.id);
    $http.get("http://localhost:3000/users/"+$stateParams.id).then(function(resp){
      console.log(resp.data);
      $scope.mate = resp.data;
    }, function(err){
      console.error("ERR", err);
    })
  })

  .controller("PostRoomCtrl", function($scope, $state, $http) {
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
        // console.log("requesttoken:");
        // console.log($window.sessionStorage.token);
        config.headers = config.headers || {};
        if ($window.sessionStorage.token) {
          config.headers.Authorization = 'Bearer ' + $window.sessionStorage.token;
        }
        return config;
      },
      response: function(response) {
        if (response.status === 401) {
          delete $window.sessionStorage.token;
          alert("unauthorized");
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
      .state("menu.conversations", {
        url: "/conversations",
        views: {
          "menuContent": {
            templateUrl: "templates/conversations.html"
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
            templateUrl: "templates/roomResults.html"
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
            templateUrl: "templates/mateResults.html"
          }
        }
      })
      .state("menu.oneMate", {
        // change the rest of the criterias here 
        url: "/mate?id", 
        views: {
          "menuContent":{
            templateUrl: "templates/oneMate.html"
          }
        }
      });
 })
