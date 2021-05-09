function addScript(src) {
    let script = document.createElement('script');
    script.src = src;
    document.head.appendChild(script);
}

<!-- Import D3 Scale Chromatic via CDN -->
addScript("https://d3js.org/d3-color.v1.min.js");
addScript("https://d3js.org/d3-interpolate.v1.min.js");
addScript("https://d3js.org/d3-scale-chromatic.v1.min.js");




let colorScale;
let colorRangeInfo;
let calculatePoint;
let interpolateColors;

$(document).ready(function () {
    // colorScale = d3.interpolateRainbow;
    //
    // colorRangeInfo = {
    //     colorStart: 0,
    //     colorEnd: 1,
    //     useEndAsStart: false,
    // };

    calculatePoint = function (i, intervalSize, colorRangeInfo) {
        let { colorStart, colorEnd, useEndAsStart } = colorRangeInfo;
        return (useEndAsStart
            ? (colorEnd - (i * intervalSize))
            : (colorStart + (i * intervalSize)));
    };

    interpolateColors = function (dataLength, colorScale, colorRangeInfo) {
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
    };
});
