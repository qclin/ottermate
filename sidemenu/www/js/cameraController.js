ottermate.controller("CameraCtrl", function($scope, $http, apiSettings, $stateParams, $cordovaCamera ,$ionicPlatform) {

  $scope.uri = "uri goes here";

  $ionicPlatform.ready(function() {
    var cameraOptions = {
      destinationType: Camera.DestinationType.FILE_URI,
      sourceType: Camera.PictureSourceType.CAMERA
    };

    $cordovaCamera.getPicture(cameraOptions).then(function(imageURI) {
      $scope.uri = imageURI;
      $scope.progress = "uploading now";
      $cordovaFileTransfer.upload(apiSettings.baseUrl+"imageUpload", imageURI, {}) // probably need to pass authorization header in here
        .then(function(result) {
          $scope.progress = "done!";
          // Success!
        }, function(err) {
          $scope.progress = "err: "+err;
          // Error
        }, function (progress) {
          $scope.progress += ".";
          // constant progress updates
        });
    }, function(err) {
      console.log(err);
    });
  });
});