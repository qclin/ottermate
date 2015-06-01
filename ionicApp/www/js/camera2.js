angular.module('cameraUpload', ['apiSettings', 'ngCordova'])
.controller('uploadPhotoCtrl', function($scope, $timeout, $cordovaFileTransfer) {

  document.addEventListener('deviceready', function () {

    var url = "http://cdn.wall-pix.net/albums/art-space/00030109.jpg";
    var targetPath = cordova.file.documentsDirectory + "testImage.png";
    var trustHosts = true
    var options = {};

    $cordovaFileTransfer.download(url, targetPath, options, trustHosts)
      .then(function(result) {
        // Success!
      }, function(err) {
        // Error
      }, function (progress) {
        $timeout(function () {
          $scope.downloadProgress = (progress.loaded / progress.total) * 100;
        })
      });

   }, false);


  document.addEventListener('deviceready', function () {

    $cordovaFileTransfer.upload(server, filePath, options)
      .then(function(result) {
        // Success!
      }, function(err) {
        // Error
      }, function (progress) {
        // constant progress updates
      });

  }, false);

});