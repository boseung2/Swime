<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../includes/tagLib.jsp" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
test
    <div class="app-container">
        <div class="chart-container">
            <canvas id="pie-chart"></canvas>
        </div>
    </div>
</body>
</html>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<script src="../../../resources/js/adminDashBoard/ColorMaker.js" crossorigin="anonymous"></script>


<script>

    console.log("script");

    $(document).ready(function () {
        test();
    });

    /* Set up Chart.js Pie Chart */
    function createChart(chartId, chartData, colorScale, colorRangeInfo) {
        console.log("createChart");
        /* Grab chart element by id */
        const chartElement = document.getElementById(chartId);

        const dataLength = chartData.data.length;

        /* Create color array */
        var COLORS = interpolateColors(dataLength, colorScale, colorRangeInfo);


        /* Create chart */
        const myChart = new Chart(chartElement, {
            type: 'doughnut',
            data: {
                labels: chartData.labels,
                datasets: [
                    {
                        backgroundColor: COLORS,
                        hoverBackgroundColor: COLORS,
                        data: chartData.data
                    }
                ],
            },
            options: {
                responsive: true,
                legend: {
                    display: false,
                },
                hover: {
                    onHover: function(e) {
                        var point = this.getElementAtEvent(e);
                        e.target.style.cursor = point.length ? 'pointer' : 'default';
                    },
                },
            }
        });
        return myChart;
    }

    function getRandomNumber(min, max) {
        console.log("getRandomNumber");
        return Math.round(Math.random() * (max - min) + min);
    }


    function test() {
        console.log("onload");
        /* Example Data */
        const arrayLength = 10;
        const min = 20;
        const max = 110;

        var i;
        var data = [];
        var labels = [];

        for (i = 0; i < arrayLength; i++) {
            data.push(getRandomNumber(min, max));
            labels.push(`Label ${i + 1}`);
        }

        const chartData = {
            labels: labels,
            data: data,
        };

        createChart('pie-chart', chartData, colorScale, colorRangeInfo);
    }


</script>