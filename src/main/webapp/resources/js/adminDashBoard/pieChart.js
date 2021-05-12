
$(document).ready(function () {
    pieChartMaker = function (ctx, label, data) {


        // let resData = dataCut(data, label);
        data = dataCut(data, label);


        function dataCut(data){
            let dataSum = 0;
            for (let i = 0; i < data.length; i++) {
                dataSum += data[i];
            }

            let where;
            let etcSum = 0;

            for (let i = 0; i < data.length; i++) {
                let tmp = data[i] * 100 / dataSum;
                if(tmp <= 2){
                    etcSum += data[i];
                    if(where === undefined) where = i;
                }
            }
            data = data.slice(0, where);
            data[where] = etcSum;

            label = label.slice(0, where);
            label[where] = "etc";


            return data;

        }

        const colorScale = d3.interpolateRainbow;

        const colorRangeInfo = {
            colorStart: 0.15,
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

        let options = {
            // tooltips: {
            //     enabled: true
            // },
            // plugins: {
            //     datalabels: {
            //         formatter: (value, ctx) => {
            //             let sum = ctx.dataset._meta[0].total;
            //             let percentage = (value * 100 / sum).toFixed(2) + "%";
            //             console.log(percentage);
            //             return "percentage";
            //
            //
            //         },
            //         color: '#fff',
            //     }
            // }
        };

        new Chart(ctx, {
            type: 'pie',
            data: {
                labels: label,
                datasets: [{
                    data: data,
                    backgroundColor: colors,
                }],
            },
            options: options

        });
    }
});
