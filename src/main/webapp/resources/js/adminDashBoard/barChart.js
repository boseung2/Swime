function barChartMaker(ctx, label, data) {

    // data = [0,0,0,0,0,
    // 0,0,0,0,0,0,0];

    let max = Math.max.apply(null, data);
    let labelMax = label.length;

    // Bar Chart Example
    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: label,
            datasets: [{
                label: "Visitor",
                backgroundColor: "rgba(2,117,216,1)",
                borderColor: "rgba(2,117,216,1)",
                data: data,
            }],
        },
        options: {
            scales: {
                xAxes: [{
                    time: {
                        unit: 'hour'
                    },
                    gridLines: {
                        display: false
                    },
                    ticks: {
                        maxTicksLimit: labelMax
                    }
                }],
                yAxes: [{
                    ticks: {
                        min: 0,
                        max: max,
                        maxTicksLimit: 5
                    },
                    gridLines: {
                        display: true
                    }
                }],
            },
            legend: {
                display: false
            }
            // ,
            // tooltips: {
            //     callbacks: {
            //         label: function(tooltipItem, data) {
            //             console.log(tooltipItem);
            //             console.log(data);
            //             return tooltipItem;
            //         }
            //     }
            // }
        }
    });
}