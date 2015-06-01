angular.module('apiSettings', [])
  .value('apiSettings', {
    //baseUrl: "http://evangriffiths.nyc:4321/" // use api running on digital ocean
     baseUrl: "http://localhost:3000/" // use local api
  });