ottermate.controller("CameraCtrl", function($scope, $http, apiSettings, $stateParams, $cordovaCamera, $cordovaFileTransfer, $ionicPlatform, $window) {

  $scope.uri = "uri goes here";

  $ionicPlatform.ready(function() {
    var cameraOptions = {
      destinationType: Camera.DestinationType.FILE_URI,
      sourceType: Camera.PictureSourceType.CAMERA
    };

    $cordovaCamera.getPicture(cameraOptions).then(function(imageURI) {
      $scope.uri = imageURI;
      $scope.progress = "uploading now";

      var fileOptions = new FileUploadOptions();
      fileOptions.fileName = imageURI.split('/').pop();
      fileOptions.mimeType = 'image/jpeg';
      fileOptions.headers = {'AUTHORIZATION': 'Bearer ' + $window.sessionStorage.token};
      $cordovaFileTransfer.upload(apiSettings.baseUrl+"uploadImage", imageURI, fileOptions) // probably need to pass authorization header in here
        .then(function(result) {
          $scope.progress = JSON.parse(result).filename;
          // Success!
        }, function(err) {
          $scope.progress = JSON.stringify(err);
          // Error
        }, function (progress) {
          // constant progress updates
          if (progress.lengthComputable) {
            $scope.progress = Math.round((progress.loaded / progress.total)*100) + " %";
          } else {
            $scope.progress += ".";
          }
        });
    }, function(err) {
      console.log(err);
    });
  });
});