function pieChartMaker(ctx, label, data) {
    // Pie Chart Example
    // var ctx = document.getElementById("myPieChart");
    new Chart(ctx, {
        type: 'pie',
        data: {
            labels: label,
            datasets: [{
                data: data,
                backgroundColor: ['#007bff', '#dc3545', '#ffc107', '#28a745'],
            }],
        },
    });
}