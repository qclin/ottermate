var express = require('express');
var bodyParser = require('body-parser');
var fs = require('fs');
var watson = require('watson-developer-cloud');
var cors = require('cors');

var secrets = require('../secrets.json');
var exampletext = fs.readFileSync('../exampletext.txt');

var corsOptions = {
  origin: "http://localhost"
}

var app = express();

var personality_insights = watson.personality_insights({
  username: secrets.watson.credentials.username,
  password: secrets.watson.credentials.password,
  version: 'v2'
});

app.use(bodyParser.urlencoded({extended: true}));
app.use(bodyParser.json());

app.post('/personality', cors(corsOptions), function(req,res) {
  personality_insights.profile(
    {text: req.body.text},
    function (err, response) {
      if (err)
        res.json({error: err});
      else
        res.json(response.tree.children);
  });
});


app.listen(9090, function() {console.log('listening to port 9090');});



