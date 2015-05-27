angular.module('ionicApp', ['ionic', 'ngResource'])

.factory('User', function($resource) {
  return $resource('/api/user/:id');
})

.controller('MainCtrl', function($scope, User) {
  // Get all users
  $scope.users = User.query();

  // Our form data for creating a new user with ng-model
  $scope.userData = {};
  $scope.newUser = function() {
    var user = new User($scope.userData);
    user.$save();
  }
});