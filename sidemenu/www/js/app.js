var ottermate = angular.module('ionicApp', ['ionic','apiSettings','ngCordova'])
  .controller('MainCtrl', function($rootScope, $ionicModal, $state, $scope, $ionicSideMenuDelegate, $window, $location) {
    $rootScope.$on('$stateChangeStart', function(event, toState, toParams, fromState, fromParams) {
      // when we switch state, check if we have a valid token
      if (typeof $window.sessionStorage.token === 'undefined') {
        // no valid token, so block transition unless it's the login or signup pages
        if (toState.name !== 'login' && toState.name !== 'signup' ) {
          event.preventDefault();
        }
      }
    });
	
		$ionicModal.fromTemplateUrl('templates/searchModal.html', {
			scope: $scope,
			animation: 'slide-in-up'
		}).then(function(modal) {
			$scope.modal = modal;
		});
		$scope.closeModal = function() {
			$scope.modal.hide();
		};
		//Cleanup the modal when we're done with it!
		$scope.$on('$destroy', function() {
			$scope.modal.remove();
		});
		
		$scope.searchModal = function() {
			$scope.modal.show();
			return $state.is('contact.details.item');
		}
		
    $scope.toggleLeft = function() {
      $ionicSideMenuDelegate.toggleLeft()   
    };
    $scope.logout = function() {
      delete $window.sessionStorage.token;
      $location.path('/login');
    };
  })

  .controller("LoginCtrl", function($scope,$state,$window,$http,apiSettings) {
    $scope.user = {}
    $scope.login = function() {
      $http.post(apiSettings.baseUrl+'authenticate', {user:$scope.user})
        .success(function (data,status,headers,config) {
          $window.sessionStorage.token = data.token;
          $state.go('menu.profile');
        })
        .error(function (data,status,headers,config) {
          console.log('bad password');
          delete $window.sessionStorage.token;
          // alert(data);
          alert("Error: Unknown email/password combination");
        });
    };
  })

  .controller("SignUpCtrl", function($scope, $state, $http, apiSettings, $window) {
    $scope.user = {}
    $scope.signup = function() {
      $http.post(apiSettings.baseUrl+"users", {user: $scope.user})
        .success(function (data,status) {
         $window.sessionStorage.token = data.token;
         $state.go("menu.login");
        })
        .error(function (data,status) {
          // our post got rejected
          alert("bad post! "+ JSON.stringify(data) + " status: "+ status);
        });
      };
  })

  .controller("ProfileCtrl", function($scope, $http, apiSettings) {
    $scope.user = {}
    $http.get(apiSettings.baseUrl+"current_user")
      .success(function(resp){
        $scope.user = resp
      })
      .error(function(err){
        console.error('ERR', err);
      });
  })

  .controller("EditProfileCtrl", function($scope, $http, apiSettings, $state){
    $scope.user = {}
    $http.get(apiSettings.baseUrl+"current_user")
      .success(function(resp){
        console.log(resp);
        $scope.user = resp;
      })
      .error(function(err){
        console.error('ERR', err);
      });
    $scope.updateProfile = function(){
      console.log($scope.user)
       $http.put(apiSettings.baseUrl+"current_user", {user: $scope.user})
        .success(function (data,status) {
          console.log(data);
         $state.go("menu.profile");
        })
        .error(function (data,status) {
          alert("bad post! "+ JSON.stringify(data) + " status: "+ status);
        });
    };
  })
    .controller("EditRoomCtrl", function($scope, $http, apiSettings, $state){
      $scope.room = {}
      $http.get(apiSettings.baseUrl+"rooms/") //+$stateParams.id).then(function(resp){
      .success(function(resp){
        $scope.room = resp
      })
      .error(function(err){
        console.error('ERR', err);
      });
      $scope.editRoom = function(){
      $http.put(apiSettings.baseUrl+"rooms", {room: $scope.room})
        .success(function (data,status) {
          console.log(data);
          $state.go("menu.oneRoom", {id:data.id});
        })
        .error(function (data,status){
          // our post got rejected
          console.log("bad post! "+ JSON.stringify(data) + " status: "+ status);
        });
    }
  })

  .controller("ConversationsCtrl", function($scope, $state, $http, apiSettings) {
    // get list of usernames that we've chatted with
    $http.get(apiSettings.baseUrl+"chats")
      .success(function(data){
        $scope.usernames = data
      })
      .error(function(err) {
        console.error("ERR", err);
      });
  })

  .controller("ChatCtrl", function($scope, $state, $http, apiSettings, $stateParams) {
    $scope.chat = {}
    $scope.user2 = $stateParams.username;
    loadChat();

    function loadChat() {
      $http.get(apiSettings.baseUrl+"chats/"+$stateParams.username)
        .success(function(data) {
          $scope.messages = data;
        })
        .error(function(data) {
          console.log(data);
        });
    }

    $scope.sendMessage = function() {
      $http.post(apiSettings.baseUrl+"chats/",{message: $scope.chat.message, to_username: $scope.user2})
        .success(function(data) {
          $scope.chat.message = "";
          loadChat();
        })
        .error(function(data) {
          console.log(data);
        });
    };
  })

  
  .controller("SearchRoomsCtrl", function($scope, $state, $http, apiSettings){
    $scope.search = {pet_friendly: "nil"};
    $scope.searchRooms = function(){
      $state.go("menu.roomResults", $scope.search);
    };
  })

  .controller("RoomResultsCtrl", function($scope, $state, $http, apiSettings, $stateParams) {
    $http.get(apiSettings.baseUrl+"rooms", {params: $stateParams})
      .success(function(resp){
        console.log(resp);
        if(resp.length === 0){
          // maybe there's a better way for empty results
          $scope.msg = "no results match your criteria"
        }else{
          $scope.msg = "your search has return the following matches~!!"
          $scope.rooms = resp;
        }
      })
      .error( function(err){
        console.error("ERR", err);
      });
  })

  .controller("GetRoomCtrl",function($scope, $state, $http, apiSettings, $stateParams){
    $http.get(apiSettings.baseUrl+"rooms/"+$stateParams.id).then(function(resp){
      console.log(resp.data);
      $scope.room = resp.data.room;
      $scope.user = resp.data.user;
      $scope.baseUrl = apiSettings.baseUrl.slice(0,-1); // remove the trailing slash from baseUrl so it concatenates nicely with the image url
    }, function(err){
      console.error("ERR", err);
    });
    $http.get(apiSettings.baseUrl+"reviews/", {params: {room_id: $stateParams.id}}).then(function(resp){
      $scope.reviews = resp.data;
      console.log($scope.reviews)
    }, function(err){
      console.log("ERR", err); 
    });
  })


  .controller("SearchMatesCtrl", function($scope, $state, $http, apiSettings){
    $scope.search = {};
    $scope.searchMates = function(){
      $state.go("menu.mateResults", $scope.search)
    };
  })

  .controller("MateResultsCtrl", function($scope, $state, $http, apiSettings, $stateParams){
    $http.get(apiSettings.baseUrl+"users", {params:$stateParams}).then(function(resp){
      if(resp.data.length === 0){
        $scope.msg = "no mates are in your range"
      }else{
        $scope.msg = "looks like these folks are on the same vibe as you ~~~"
        $scope.mates = resp.data;
      }
      console.log(resp.data);
    }, function(err){
      console.error("ERR", err);
    });
  })
  .controller("GetMateCtrl",function($scope, $state, $http, apiSettings, $stateParams, $window, $ionicPopup){
    $http.get(apiSettings.baseUrl+"users/"+$stateParams.id).then(function(resp){
      console.log(resp.data);
      $scope.mate = resp.data;
    }, function(err){
      console.error("ERR", err);
    });

    $http.get(apiSettings.baseUrl+"endorsements", {params:{user_id:$stateParams.id}}).then(function(resp){
      console.log(resp.data)
      $scope.handy = Array.apply(null, Array(resp.data.handy)).map(function(a,b){return b;});
      console.log($scope.handy)
      $scope.neatfreak = Array.apply(null, Array(resp.data.neatfreak)).map(function(a,b){return b;});
      $scope.foodie = Array.apply(null, Array(resp.data.foodie)).map(function(a,b){return b;});
      $scope.active = Array.apply(null, Array(resp.data.active)).map(function(a,b){return b;});
      $scope.punctual = Array.apply(null, Array(resp.data.punctual)).map(function(a,b){return b;});
      $scope.lowkey = Array.apply(null, Array(resp.data.lowkey)).map(function(a,b){return b;});
    }, function(err){
      console.error("ERR", err);
    });

    $scope.endorseUser = function(skill){
      console.log(skill);
      var confirmPopup = $ionicPopup.confirm({
       title: "Endorsed "+skill + " !" ,
       template: 'Do you really think so ?'
     });
      confirmPopup.then(function(res){
        if(res){
          $http.post(apiSettings.baseUrl+"endorsements", {endorsee_id: $stateParams.id, skill: skill})
          .success(function(data, status){
            //probably want to add a pop-up msg telling them they've endorse the skill
            $window.location.reload(true);
          })
          .error(function(data,status){
            console.log("bad post!" + JSON.stringify(data) + " status: " +status); 
          });
        }else{
          console.log('cancel endorsement');
        }
      });
    }

  })

  .controller("PostRoomCtrl", function($scope, $state, $http, apiSettings) {
    $scope.room = {};
    $scope.postRoom = function(){
      $http.post(apiSettings.baseUrl+"rooms", {room: $scope.room})
        .success(function (data,status) {
          $state.go("menu.oneRoom", {id:data.id});
        })
        .error(function (data,status){
          // our post got rejected
          console.log("bad post! "+ JSON.stringify(data) + " status: "+ status);
        });
    };
  })
  .controller("PostReviewCtrl", function($scope, $state, $http, apiSettings, $stateParams){
    $scope.review= {};
    $scope.postReview = function(){
      $http.post(apiSettings.baseUrl+"reviews", {comment: $scope.review.content, room_id: $stateParams.id})
        .success(function(data, status){
          $state.go("menu.oneRoom", {id: $stateParams.id}); 
        })
        .error(function(data, status){
          alert("You already have a review posted for this room");
          $state.go("menu.oneRoom", {id: $stateParams.id});
        });
    };
  })

  .controller("PersonalityAppendCtrl", function($scope, $state, $http, apiSettings) {
    $scope.user = {};
    $scope.analyze = function() {
      $http.post(apiSettings.baseUrl + "/current_user/watsonfeed", {text: $scope.user.emails})
        .success(function(resp) {
          $state.go('menu.personalityResults');
        })
        .error(function(err) {
          alert('failed '+err);
        });
    };
    $http.get(apiSettings.baseUrl+"current_user")
      .success(function(resp){
        $scope.user = resp
      })
      .error(function(err){
        console.error('ERR', err);
      });
  })

  .factory('authInterceptor', function($q, $window, $location) {
    return {
      request: function(config) {
        console.log("req");
        // console.log("requesttoken:");
        // console.log($window.sessionStorage.token);
        config.headers = config.headers || {};
        if ($window.sessionStorage.token) {
          config.headers.Authorization = 'Bearer ' + $window.sessionStorage.token;
        }
        return config;
      },
      responseError: function(response) {
        console.log(response);
        if (response.status === 401) {
          delete $window.sessionStorage.token;
          $location.path('/login');
        }
        return $q.reject(response);
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
     .state("menu.personalityAppend", {
        url: "/personalityAppend",
        views: {
          "menuContent": {
           templateUrl: "templates/personalityAppend.html"
          }
        }
     })
       .state("menu.personalityResults", {
        url: "/personalityResults?id",
        views: {
          "menuContent": {
           templateUrl: "templates/personalityResults.html"
          }
        }
     })
      .state("menu.editProfile", {
        url: "/editProfile",
        views: {
          "menuContent": {
            templateUrl: "templates/editProfile.html"
          }
        }
      })
      .state("menu.editRoom", {
        url: "/editRoom",
        views: {
          "menuContent": {
            templateUrl: "templates/editRoom.html"
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
      .state("menu.chat", {
        url: "/menu/chat?username",
        views: {
          "menuContent": {
            templateUrl: "templates/chat.html"
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
      .state("menu.uploadPhoto", {
        url: "/uploadPhoto",
        views: {
          "menuContent": {
            templateUrl: "templates/uploadPhoto.html"
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
      .state("menu.oneRoom", {
        // change the rest of the criterias here 
        url: "/room?id", 
        views: {
          "menuContent":{
            templateUrl: "templates/oneRoom.html"
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
        url: "/materesults?gender&description&budget&range", 
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
      })
      .state("menu.postReview", {
        url:"/room?id/postReview",
        views: {
          "menuContent": {
            templateUrl: "templates/postReview.html"
          }
        }
      })
      .state("menu.camera", {
        url:"/camera",
        views: {
          "menuContent": {
            templateUrl: "templates/camera.html"
          }
        }
      });
 })

