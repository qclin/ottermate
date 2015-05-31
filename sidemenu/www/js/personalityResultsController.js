ottermate.controller("PersonalityResultsCtrl", function($scope, $http, apiSettings, $stateParams) {
    $scope.user = {}
    $http.get(apiSettings.baseUrl+"watson/"+$stateParams.id)
      .success(function(data){

        var user1pers = JSON.parse(data.user1.personality);
        var user2pers = JSON.parse(data.user2.personality);
        // console.log(user1pers[0].children[0]);
        var compare = [
         user1pers[0].children[0].children[0].percentage,
         user2pers[0].children[0].children[0].percentage,
         user1pers[0].children[0].children[1].percentage, 
         user2pers[0].children[0].children[1].percentage, 
         user1pers[0].children[0].children[2].percentage, 
         user2pers[0].children[0].children[2].percentage, 
         user1pers[0].children[0].children[3].percentage, 
         user2pers[0].children[0].children[3].percentage, 
         user1pers[0].children[0].children[4].percentage, 
         user2pers[0].children[0].children[4].percentage
        ];

        var names = [ 
          user1pers[0].children[0].children[0].name, 
          user1pers[0].children[0].children[1].name, 
          user1pers[0].children[0].children[2].name,
          user1pers[0].children[0].children[3].name, 
          user1pers[0].children[0].children[4].name
        ];

        var people = [data.user1.name, data.user2.name]

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
          rowHeight = titleHeight + (2 * barHeight) + barSeperation + barBottomPadding,
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
            return legendHeight + rowHeight * (Math.floor(i / 2)) + titleHeight + (i % 2 === 0 ? 0 : barHeight + barSeperation);
          })
          .attr("width", function (d) {
            console.log(d)
            return (svgWidth - barLeftPadding - barRightPadding) * d;
          })
          .attr("height", function (d) {
            return barHeight;
          })
          .attr("fill", function(d, i) {
            if (i % 2) {
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
            return legendHeight + rowHeight * (Math.floor(i / 2)) + titleHeight + (i % 2 === 0 ? 0 : barHeight + barSeperation) + (barHeight / 2)+percentageYShift;
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
          return (svgWidth / 2) * (i + 1) - legendBoxPadRight - legendBoxSize;
        })
        .attr("y", function(d, i) {
          return legendVertPad;
        })
        .attr("width", legendBoxSize)
        .attr("height", legendBoxSize)
        .attr("fill", function(d, i) {
            if (i % 2) {
                return 'burlywood';
            };
                return 'darkcyan';
            });;



        svg.selectAll("text.legendlabels")
          .data(people)
          .enter()
          .append('text')
          .text(function(d) {
            return d;
          })
          .attr("x", function(d, i) {
            return (svgWidth / 2) * (i + 1) - legendBoxPadRight - legendBoxSize - legendBoxPadLeft;
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