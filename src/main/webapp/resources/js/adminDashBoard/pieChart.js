function addScript(src) {
    let script = document.createElement('script');
    script.src = src;
    document.head.appendChild(script);
}

addScript("../../../resources/js/adminDashBoard/ColorMaker.js");


let pieChartMaker;

$(document).ready(function () {
    pieChartMaker = function (ctx, label, data) {
        // Pie Chart Example
        // var ctx = document.getElementById("myPieChart");
        //
        const colorScale = d3.interpolateRainbow;

        const colorRangeInfo = {
            colorStart: 0,
            colorEnd: 1,
            useEndAsStart: false,
        };

        function calculatePoint(i, intervalSize, colorRangeInfo) {
            let { colorStart, colorEnd, useEndAsStart } = colorRangeInfo;
            return (useEndAsStart
                ? (colorEnd - (i * intervalSize))
                : (colorStart + (i * intervalSize)));
        }

        function interpolateColors(dataLength, colorScale, colorRangeInfo) {
            let { colorStart, colorEnd } = colorRangeInfo;
            let colorRange = colorEnd - colorStart;
            let intervalSize = colorRange / dataLength;
            let i, colorPoint;
            let colorArray = [];

            for (i = 0; i < dataLength; i++) {
                colorPoint = calculatePoint(i, intervalSize, colorRangeInfo);
                colorArray.push(colorScale(colorPoint));
            }

            return colorArray;
        }

        let colors = interpolateColors(data.length, colorScale, colorRangeInfo);


        new Chart(ctx, {
            type: 'pie',
            data: {
                labels: label,
                datasets: [{
                    data: data,
                    backgroundColor: colors,
                }],
            },
        });
    }
});
