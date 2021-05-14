<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%--<%@include file="../includes/tagLib.jsp" %>--%>


<div class="container-fluid">
    <!-- <h2 class="mt-4">대시보드</h2> -->
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item active">Dashboard</li>
    </ol>

    <div class="row row1">
        <div class="col-xl-4 col-md-4">
            <div class="card bg-primary text-white mb-4">
                <div class="card-body">
                    <div style="float: Left;">당일 가입자수</div>
                    <div id="countUser" style="float: Right;">0</div>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-between">
                    <a class="small text-white stretched-link" href="#">View Details</a>
                    <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                </div>
            </div>
        </div>
        <div class="col-xl-4 col-md-4">
            <div class="card bg-warning text-white mb-4">
                <div class="card-body">
                    <div style="float: Left;">당일 생성 모임수</div>
                    <div id="countGroup" style="float: Right;">0</div>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-between">
                    <a class="small text-white stretched-link" href="#">View Details</a>
                    <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                </div>
            </div>
        </div>

        <div class="col-xl-4 col-md-4">
            <div class="card bg-success text-white mb-4">
                <div class="card-body">
                    <div style="float: Left;">당일 생성 스터디수</div>
                    <div id="countStudy" style="float: Right;">0</div>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-between">
                    <a class="small text-white stretched-link" href="#">View Details</a>
                    <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                </div>
            </div>
        </div>
    </div>
        <!-- <div class="col-xl-3 col-md-6">
            <div class="card bg-danger text-white mb-4">
                <div class="card-body">Danger Card</div>
                <div class="card-footer d-flex align-items-center justify-content-between">
                    <a class="small text-white stretched-link" href="#">View Details</a>
                    <div class="small text-white"><i class="fas fa-angle-right"></i></div>
                </div>
            </div>
        </div> -->
    <div class="row">
        <div class="col-xl-6">
            <div class="card mb-4">
                <div class="card-header"><i class="fas fa-chart-area mr-1"></i>일일 가입자수</div>
                <div class="card-body"><canvas id="myAreaChart" width="100%" height="40"></canvas></div>
            </div>
        </div>
        <div class="col-xl-6">
            <div class="card mb-4">
                <div class="card-header"><i class="fas fa-chart-bar mr-1"></i>시간대별 접속자수</div>
                <div class="card-body"><canvas id="myBarChart" width="100%" height="40"></canvas></div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-lg-6">
            <div class="card mb-4">
                <div class="card-header"><i class="fas fa-chart-pie mr-1"></i>모임언어</div>
                <div class="card-body"><canvas id="myPieChart" width="100%" height="50"></canvas></div>
<%--                <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>--%>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="card mb-4">
                <div class="card-header"><i class="fas fa-chart-pie mr-1"></i>모임지역</div>
                <div class="card-body"><canvas id="myPieChart2" width="100%" height="50"></canvas></div>
<%--                <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>--%>
            </div>
        </div>
    </div>
</div>






<script>
    $(document).ready(async function () {
        let writeInnerHtml = function (result, place) {
            $(place).html(result);
        };

        let makeChart = function (result, place) {
            let label = [];
            for (let i = 0; i < result.length; i++) {
                label[i] = (i+1);
            }

            lineChartMaker(place, label, result);
        };

        let barChart = function (result, place) {
            let label = [];
            let tmp, tmp2, prefix, suffix;
            for (let i = 0; i < result.length; i++) {
                tmp = i + "";
                tmp2 = i + 1 + "";
                prefix = tmp.length === 1 ? 0 + tmp + ':00' : tmp + ':00';
                suffix = tmp2.length === 1 ? 0 + tmp2 + ':00' : tmp2 + ':00';
                label[i] = prefix;
            }

            barChartMaker(place, label, result)
        };

        let pieChart = function (result, place){
            let label = [], data = [];

            for (let i = 0; i < result.length; i++) {
                label[i] = result[i].name;
                data[i] = result[i].count;
            }

            pieChartMaker(place, label, data);
        };
        let datalist = [];

        // await chartData("countUser", "none", $("#countUser"), writeInnerHtml);
        // await chartData("countStudy", "none", $("#countStudy"), writeInnerHtml);
        // await chartData("countGroup", "none", $("#countGroup"), writeInnerHtml);

        await chartData("todayUserRegister", "none", $("#countUser"), topData);
        await chartData("todayGroupRegister", "none", $("#countGroup"), topData);
        await chartData("todayStudyRegister", "none", $("#countStudy"), topData);
        await chartData("countUserForMonth", "month", $("#myAreaChart"), makeChart);
        await chartData("getVisitCountByTime", "day", $("#myBarChart"), barChart);
        await chartData("getDashBoardLang", "none", $("#myPieChart"), pieChart);
        await chartData("getDashBoardLocale", "none", $("#myPieChart2"), pieChart);



        function topData(result, place){
            writeInnerHtml(result.count, place);
            datalist.push(result);
        }

        showModal(datalist);
    });


    
    function showModal(datalist) {
        let {modalSetting, show, modalCssSetting} = modal($("#modalPlace"));
        // console.log(a);
        // let test = function () {
        //     for (let i = 0; i <3; i++) {
        //         console.log(i);
        //     }
        //     console.log("function 종료");
        // }

        modalCssSetting(800);



        $(".stretched-link").on("click", function () {
            let hrefTags = $(".stretched-link");


            for (let i = 0; i < hrefTags.length; i++) {
                let title = String($(".row1 > div:nth-child(" + (i + 1) + ") > div > div.card-body > div:nth-child(1)")[0].innerHTML);

                if(hrefTags[i] === this) {
                    // console.log(datalist[i].list);
                    let str = makeTable(datalist[i].list, i);
                    modalSetting(title, str, 'alert');
                    break;
                }
            }
            
            function makeTable(list, who) {
                if(list.length === 0) return "<div>데이터가 존재 하지 않습니다</div>";

                let str = "";

                let column1, column2, column3, column4;

                if(who === 0){
                    column1 = "아이디";
                    column2 = "생성시간";
                }
                if(who === 1){
                    column1 = "모임명";
                    column2 = "생성시간";
                }
                if(who === 2){
                    column1 = "스터디명";
                    column2 = "생성시간";
                }

                str += "" +
                    "<table border='1'>" +
                    "   <thead>" +
                    "       <tr>" +
                    "           <td>" + column1 + "</td>" +
                    "           <td>" + column2 + "</td>" +
                    "       </tr>" +
                    "   </thead>" +
                    "   <tdody>"
                ;

                for (let i = 0; i < list.length; i++) {
                    str += "" +
                        "<tr>" +
                        "   <td>" + list[i].string1 + "</td>" +
                        "   <td>" + boardDisplayTime(list[i].date1) + "</td>" +
                        "</tr>"
                    ;
                }

                str += ("" +
                    "   </tdody>"
                );

                console.log(list);
                return str;
            }

            show();
        });

    }

    function boardDisplayTime(timeValue) {

        let date = new Date(timeValue);

        let year = date.getFullYear().toString().slice(-2); //년도 뒤에 두자리
        let month = ("0" + (date.getMonth() + 1)).slice(-2); //월 2자리 (01, 02 ... 12)
        let day = ("0" + date.getDate()).slice(-2); //일 2자리 (01, 02 ... 31)
        let hour = ("0" + date.getHours()).slice(-2); //시 2자리 (00, 01 ... 23)
        let minute = ("0" + date.getMinutes()).slice(-2); //분 2자리 (00, 01 ... 59)
        let second = ("0" + date.getSeconds()).slice(-2); //초 2자리 (00, 01 ... 59)

        let returnDate = year + "/" + month + "/" + day + " "+ hour + ":" + minute + ":" + second;

        return returnDate;

    }

    function chartData(url, dataInterval, place, func){
        return new Promise((resolve,reject) => {
            let cal = new Date();
            let data = {};

            if (dataInterval === "month") {
                data = {
                    year: cal.getFullYear(),
                    month: cal.getMonth() + 1
                };
            } else if (dataInterval === "day") {
                data = {
                    year: cal.getFullYear(),
                    month: cal.getMonth() + 1,
                    day: cal.getDate()
                };
            }
            $.ajax({
                url: "/adminData/" + url,
                dataType: "json",
                data: data
            }).done(function (result) {
                console.log(url);
                if (func !== undefined) func(result, place);
                resolve();
            }).fail(function () {
                reject();
            });
        })
    }






</script>