angular.module('ionicApp', ['ionic'])

    .controller('MainCtrl', function($scope, $ionicSideMenuDelegate) {
        $scope.toggleLeft = function() {
             $ionicSideMenuDelegate.toggleLeft()   
        }
    })

    .config(function($stateProvider, $urlRouterProvider) {
        $urlRouterProvider.otherwise("/menu/home");

        $stateProvider
            .state('menu', {
                url: "/menu",
                abstract: true,
                templateUrl: "templates/menu.html"
            })
            .state('menu.home', {
                url: "/home",
                views: {
                    'menuContent' :{
                        templateUrl: "templates/home.html"
                    }
                }
            });
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