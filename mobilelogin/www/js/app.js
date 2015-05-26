// Ionic Starter App

// angular.module is a global place for creating, registering and retrieving Angular modules
// 'starter' is the name of this angular module example (also set in a <body> attribute in index.html)
// the 2nd parameter is an array of 'requires'
angular.module('starter', ['ionic'])

  .controller('NavController', function($scope,$ionicPopup,$state) {
    $scope.name = "dave";

    $scope.goHome = function() {
      $state.go('index');
      $ionicPopup.alert({
       title: 'Don\'t eat that!',
       template: 'It might taste good'
      });
    }
  })

  .controller('HomeCtrl', function($scope) {
    $scope.name = "henry";
  })

  .config(function($urlRouterProvider, $stateProvider) {
    $urlRouterProvider.otherwise('/')

    $stateProvider.state('home', {
      url: '/home',
      views: {
        home: {
          templateUrl: 'home.html'
        }
      }
    })

    $stateProvider.state('login', {
      url: '/login',
      views: {
        login: {
          templateUrl: 'login.html'
        }
      }
    })

    $stateProvider.state('signup', {
      url: '/signup',
      views: {
        signup: {
          templateUrl: 'signup.html'
        }
      }
    })
  })

  .run(function($ionicPlatform) {
    $ionicPlatform.ready(function() {
      // Hide the accessory bar by default (remove this to show the accessory bar above the keyboard
      // for form inputs)
      if(window.cordova && window.cordova.plugins.Keyboard) {
        cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true);
      }
      if(window.StatusBar) {
        StatusBar.styleDefault();
      }
    });
  })
