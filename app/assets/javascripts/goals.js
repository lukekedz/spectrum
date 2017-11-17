$(document).ready(function() {

  ga_goals = function() {
    var last_data_point = jdub.length;

    var labels = []
    for (i = 0; i < jdub.length; i++) {
      labels.push(jdub[i][0])
    }

    var lineChartData = {
      labels: labels,
      datasets: [
        {
          fill:        false,
          borderColor: "green",
          pointStyle:  false,
          label:       "Joker's Wild",
          data:        [ jdub[0][1] ]
        }
      ]
    }

    var index     = 1;
    var ctx       = document.getElementById("canvas").getContext("2d");
    var lineChart = new Chart(ctx, {
      type:            'line',
      data:            lineChartData,
      responsive:      true,
      barValueSpacing: 2,
      options: {
        legend: {
          display: true
        },
        scales: {
          yAxes: [{
            display: true,
            ticks: {
              beginAtZero:  0,
              suggestedMin: 0,
              suggestedMax: 75
            }
          }],
          xAxes: [{
              ticks: {
                  autoSkip:      true,
                  maxTicksLimit: 32
              }
          }]
        },
        elements: { 
          point: { 
            radius: 0 
          } 
        }
      }
    });

    function stop() {
      clearInterval(ga_goals);
    }

    function nextCol() {
      lineChartData.datasets[0].data.push(jdub[index][1]);
    }

    var ga_goals = setInterval(function() {
      if (jdub[index]) { 
        nextCol();
        lineChart.update();
      } else {
        stop();
      }

      index++;
    }, 50);
  }
});
