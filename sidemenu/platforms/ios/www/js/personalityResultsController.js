ottermate.controller("PersonalityResultsCtrl", function($scope, $http, apiSettings, $stateParams) {
    $scope.user = {}
    $http.get(apiSettings.baseUrl+"watson/"+$stateParams.id)
      .success(function(data){

        var user1pers,user2pers,twoUsers,people;

        // check for nulls
        if (data.user1.personality === null) {
          user1pers = JSON.parse(data.user2.personality);
          twoUsers = false;
          people = [data.user2.name];
          $scope.msg = "I'm sorry " + data.user2.name + " does not have enough personality data to compare right now";
    
        } else if (data.user2 === null || data.user2.personality === null) {
          user1pers = JSON.parse(data.user1.personality);
          twoUsers = false;
          people = [data.user1.name];
          if (data.user2 !== null) {
            $scope.msg = "I'm sorry " + data.user2.name + " does not have enough personality data to compare right now";
          }
        } else {
          user1pers = JSON.parse(data.user1.personality);
          user2pers = JSON.parse(data.user2.personality);
          twoUsers = true;
          people = [data.user1.name, data.user2.name]
        }

        var compare = [];
        for (var i = 0; i < 5; i++) {
          compare.push(user1pers[0].children[0].children[i].percentage);
          if (twoUsers) {
            compare.push(user2pers[0].children[0].children[i].percentage);
          }
        }

        var names = [];
        for (var i = 0; i < 5; i++) { 
          names.push(user1pers[0].children[0].children[i].name);
        };


        var svgWidth = window.innerWidth,
          svgHeight = 700,
          titleHeight = 40,
          titleYShift = 5,
          barHeight = 30,
          barLeftPadding = 20,
          barRightPadding = 80,
          barBottomPadding = 10,
          barSeperation = 5,
          legendHeight = 50,
          rowHeight = titleHeight + barHeight + barBottomPadding + (twoUsers ? barHeight + barSeperation : 0),
          legendBoxPadRight = svgWidth/8,
          legendBoxPadLeft = 20,
          legendBoxSize = barHeight,
          legendVertPad = (legendHeight - legendBoxSize) / 2,
          legendYShift = 5,
          percentageLeftPad = 10,
          percentageYShift = 5;


        var svg = d3.select("#personalityResultsDiv")
        .append("svg")
        .attr("width", svgWidth)
        .attr("height", svgHeight);

        svg.selectAll("rect") 
          .data(compare)
          .enter()
          .append("rect")
          .attr("x", function (d, i) {
            return barLeftPadding;
          })
          .attr("y", function (d, i) {
            if (twoUsers) {
              return legendHeight + rowHeight * (Math.floor(i / 2)) + titleHeight + (i % 2 === 0 ? 0 : barHeight + barSeperation);
            } else {
              return legendHeight + rowHeight * i + titleHeight;
            }            
          })
          .attr("width", function (d) {
            console.log(d)
            return (svgWidth - barLeftPadding - barRightPadding) * d;
          })
          .attr("height", function (d) {
            return barHeight;
          })
          .attr("fill", function(d, i) {
            if (i % 2 && twoUsers) {
              return 'burlywood';
            };
            return 'darkcyan';
          });

        svg.selectAll("text.percentages")
          .data(compare)
          .enter()
          .append("text")
          .text(function(d) {
            return (Math.floor(d * 100)) + "%";   
          })
          .attr("x", function(d, i) {
            return barLeftPadding + ((svgWidth - barLeftPadding - barRightPadding) * d) + percentageLeftPad;  
          })

          .attr("y", function(d, i) {
            if (twoUsers) {
              return legendHeight + rowHeight * (Math.floor(i / 2)) + titleHeight + (i % 2 === 0 ? 0 : barHeight + barSeperation) + (barHeight / 2)+percentageYShift;
            } else {
              return legendHeight + rowHeight * i + titleHeight + (barHeight / 2)+percentageYShift;
            }          
          })
          .attr("font-family", "sans-serif")
          .attr("font-size", "14px")
          .attr("fill", "black")
          .style("text-anchor", "start"); 

        svg.selectAll("rect.legends")
        .data(people)
        .enter()
        .append("rect")
        .attr("x", function(d, i) {
          if (twoUsers) {
          return (svgWidth / 2) * (i + 1) - legendBoxPadRight - legendBoxSize;
        } else {
          return (svgWidth / 2) * (i + 1) - legendBoxPadRight - legendBoxSize + (svgWidth / 7);
        }
        })
        .attr("y", function(d, i) {
          return legendVertPad;
        })
        .attr("width", legendBoxSize)
        .attr("height", legendBoxSize)
        .attr("fill", function(d, i) {
            if (i % 2 && twoUsers) {
                return 'burlywood';
            };
                return 'darkcyan';
            });



        svg.selectAll("text.legendlabels")
          .data(people)
          .enter()
          .append('text')
          .text(function(d) {
            return d;
          })
          .attr("x", function(d, i) {
           if (twoUsers) {
            return (svgWidth / 2) * (i + 1) - legendBoxPadRight - legendBoxSize - legendBoxPadLeft;
          } else {
            return (svgWidth / 2) * (i + 1) - legendBoxPadRight - legendBoxSize - legendBoxPadLeft + (svgWidth / 7);
          }
          })
          .attr("y", function(d, i) {
            return legendHeight / 2 + legendYShift;
          })
          .style("text-anchor", "end");

         svg.selectAll("text.labels")
           .data(names)
           .enter()
           .append("text")
           .text(function(d) {
            return d;   
           })
           .attr("x", function(d, i) {
            return svgWidth / 2;  
           })

           .attr("y", function(d, i) {
            return legendHeight + (rowHeight * i) + (titleHeight / 2) + titleYShift;
           })

           .attr("font-family", "sans-serif")
           .attr("font-size", "14px")
           .attr("fill", "black")
           .style("text-anchor", "middle");

      })
      // failed to get personality data from rails
      .error(function(err){
        console.error('ERR', err);
      });
  })