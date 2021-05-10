function lineChartMaker(ctx, label, data) {

    let max = Math.max.apply(null, data);
    let labelMax = label.length;

    // Area Chart Example
    // var ctx = document.getElementById("myAreaChart");
    new Chart(ctx, {
        type: 'line',
        data: {
            labels: label,
            datasets: [{
                label: "Register User",
                lineTension: 0.3,
                backgroundColor: "rgba(2,117,216,0.2)",
                borderColor: "rgba(2,117,216,1)",
                pointRadius: 5,
                pointBackgroundColor: "rgba(2,117,216,1)",
                pointBorderColor: "rgba(255,255,255,0.8)",
                pointHoverRadius: 5,
                pointHoverBackgroundColor: "rgba(2,117,216,1)",
                pointHitRadius: 10,
                pointBorderWidth: 2,
                data: data,
            }],
        },
        options: {
            scales: {
                xAxes: [{
                    time: {
                        unit: 'date'
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
                        stepSize: 1,
                        min: 0,
                        max: max,
                        maxTicksLimit: 10
                    },
                    gridLines: {
                        color: "rgba(0, 0, 0, .125)",
                    }
                }],
            },
            legend: {
                display: false
            }
        }
    });
}