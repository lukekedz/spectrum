$(document).ready(function() {

	granimation = function() {
		// console.log("anyong");
		// console.log(jdub);
		// console.log(elko);
		// console.log(gsal);
		// console.log(pbts);

		// var dData = function() {
		// 	return Math.round(Math.random() * 90) + 10
		// };

		var last_data_point = jdub.length;
		// console.log(last_data_point);

		var barChartData = {
			labels: [
				jdub[0][0],
	 			jdub[1][0],
	 			jdub[2][0],
	 			jdub[3][0],
	 			jdub[4][0],
	 			jdub[5][0],
	 			jdub[6][0],
	 			jdub[7][0],
	 			jdub[8][0],
	 			jdub[9][0]
	 		],
			datasets: [
				{
					// fillColor:   "rgba(0,60,100,1)",
					fill: false,
					// strokeColor: "black",
					borderColor: "red",
					label: "Joker's Wild",
					data: [
						jdub[0][1],
			 			jdub[1][1],
			 			jdub[2][1],
			 			jdub[3][1],
			 			jdub[4][1],
			 			jdub[5][1],
			 			jdub[6][1],
			 			jdub[7][1],
			 			jdub[8][1],
			 			jdub[9][1]
						]
				},
				{
					// fillColor:   "rgba(0,60,100,1)",
					fill: false,
					// strokeColor: "black",
					borderColor: "orange",
					label: "Elko Bugles",
					data: [
						elko[0][1],
			 			elko[1][1],
			 			elko[2][1],
			 			elko[3][1],
			 			elko[4][1],
			 			elko[5][1],
			 			elko[6][1],
			 			elko[7][1],
			 			elko[8][1],
			 			elko[9][1]
						]
				},
				{
					// fillColor:   "rgba(0,60,100,1)",
					fill: false,
					// strokeColor: "black",
					borderColor: "blue",
					label: "General Salami",
					data: [
						gsal[0][1],
			 			gsal[1][1],
			 			gsal[2][1],
			 			gsal[3][1],
			 			gsal[4][1],
			 			gsal[5][1],
			 			gsal[6][1],
			 			gsal[7][1],
			 			gsal[8][1],
			 			gsal[9][1]
						]
				},
				{
					// fillColor:   "rgba(0,60,100,1)",
					fill: false,
					// strokeColor: "black",
					borderColor: "green",
					label: "PBTappers",
					data: [
						pbts[0][1],
			 			pbts[1][1],
			 			pbts[2][1],
			 			pbts[3][1],
			 			pbts[4][1],
			 			pbts[5][1],
			 			pbts[6][1],
			 			pbts[7][1],
			 			pbts[8][1],
			 			pbts[9][1]
						]
				}
			]
		}

		var index        = 10;
		var ctx          = document.getElementById("canvas").getContext("2d");
		var barChartDemo = new Chart(ctx, {
			type: 'line',
			data: barChartData,
			responsive: true,
			barValueSpacing: 2,
			// deprecated
			// scaleOverride : true,
	        // scaleSteps : 20,
	        // scaleStepWidth : 25,
	        // scaleStartValue : 350, 
	        // scaleBeginAtZero: true,
	        // end deprecated
			options: {
				legend: {
					display: true
				}
			},
			// ticks: {
			// 	min: 0
			// }
		});

		function stop() {
			// console.log("stop");
			clearInterval(granimate);
		}

		function nextCol() {
			barChartData.labels.shift();
			barChartData.labels.push(jdub[index][0]);

			barChartData.datasets[0].data.shift();
			barChartData.datasets[0].data.push(jdub[index][1]);

			barChartData.datasets[1].data.shift();
			barChartData.datasets[1].data.push(elko[index][1]);

			barChartData.datasets[2].data.shift();
			barChartData.datasets[2].data.push(gsal[index][1]);

			barChartData.datasets[3].data.shift();
			barChartData.datasets[3].data.push(pbts[index][1]);
		}

		var granimate = setInterval(function() {
			// console.log(index);

			if (jdub[index]) { 
				nextCol();
				barChartDemo.update();
			} else {
				stop();
				// document.getElementById("granimate").enabled = true;
			}

			index++;
		}, 1500);

	}
});
