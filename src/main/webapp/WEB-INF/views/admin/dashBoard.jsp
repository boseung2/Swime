<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../includes/tagLib.jsp" %>


<%--<script src="../../../resources/js/adminPageDemo/chart-area-demo.js"></script>--%>
<%--<script src="../../../resources/js/adminPageDemo/chart-bar-demo.js"></script>--%>
<%--<script src="../../../resources/js/adminPageDemo/chart-pie-demo.js"></script>--%>
<%--<script src="../../../resources/js/adminPageDemo/chart-pie-demo2.js"></script>--%>

<div class="container-fluid">
    <!-- <h2 class="mt-4">대시보드</h2> -->
    <ol class="breadcrumb mb-4">
        <li class="breadcrumb-item active">Dashboard</li>
    </ol>
    <div class="row">
        <div class="col-xl-4 col-md-4">
            <div class="card bg-primary text-white mb-4">
                <div class="card-body">
                    <div style="float: Left;">
                        당일 가입자수
                    </div>
                    <div id="countUser" style="float: Right;">
                        0
                    </div>
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
                    <div style="float: Left;">
                        당일 생성 모임수
                    </div>
                    <div id="countGroup" style="float: Right;">
                        0
                    </div>
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
                    <div style="float: Left;">
                        당일 생성 스터디수
                    </div>
                    <div id="countStudy" style="float: Right;">
                        0
                    </div>
                </div>
                <div class="card-footer d-flex align-items-center justify-content-between">
                    <a class="small text-white stretched-link" href="#">View Details</a>
                    <div class="small text-white"><i class="fas fa-angle-right"></i></div>
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
    </div>
    <div class="row">
        <div class="col-xl-6">
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-chart-area mr-1"></i>
                    일일 가입자수
                </div>
                <div class="card-body"><canvas id="myAreaChart" width="100%" height="40"></canvas></div>
            </div>
        </div>
        <div class="col-xl-6">
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-chart-bar mr-1"></i>
                    시간대별 접속자수
                </div>
                <div class="card-body"><canvas id="myBarChart" width="100%" height="40"></canvas></div>
            </div>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-6">
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-chart-pie mr-1"></i>
                    모임언어
                </div>
                <div class="card-body"><canvas id="myPieChart" width="100%" height="50"></canvas></div>
<%--                <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>--%>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-chart-pie mr-1"></i>
                    모임지역
                </div>
                <div class="card-body"><canvas id="myPieChart2" width="100%" height="50"></canvas></div>
<%--                <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>--%>
            </div>
        </div>
    </div>
</div>


<script src="../../../resources/js/adminDashBoard/chartGlobalSettings.js"></script>
<script src="../../../resources/js/adminDashBoard/lineChart.js"></script>
<script src="../../../resources/js/adminDashBoard/barChart.js"></script>
<script src="../../../resources/js/adminDashBoard/pieChart.js"></script>
<script src="../../../resources/js/adminDashBoard/pieChart2.js"></script>

<div class="modal">
    <div class="modal_content" title="클릭하면 창이 닫힙니다.">
        여기에 모달창 내용을 적어줍니다.<br>
        이미지여도 좋고 글이어도 좋습니다.
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


        await chartData("countUser", "none", $("#countUser"), writeInnerHtml);
        await chartData("countStudy", "none", $("#countStudy"), writeInnerHtml);
        await chartData("countGroup", "none", $("#countGroup"), writeInnerHtml);
        await chartData("countUserForMonth", "month", $("#myAreaChart"), makeChart);
        await chartData("getVisitCountByTime", "day", $("#myBarChart"), barChart);
        await chartData("getDashBoardLang", "none", $("#myPieChart"), pieChart);
        await chartData("getDashBoardLocale", "none", $("#myPieChart2"), pieChart);

        console.log();

        $(".stretched-link").on("click", function () {
            let hrefTags = $(".stretched-link");

            let who = 0;
            for (let i = 0; i < hrefTags.length; i++) {
                if(hrefTags[i] === this) {
                    who = i;
                    break;
                }
            }

            console.log("modal");

            $("#myModal").fadeIn();
        });



        $(".modal-footer > button").click(function(){
            $(".modal").fadeOut();
        });
    });




    function chartData(url, type, place, func){
        let cal = new Date();
        let data = {};

        if(type === "month"){
            data = {
                year : cal.getFullYear(),
                month : cal.getMonth() + 1
            };
        }else if(type === "day"){
            data = {
                year : cal.getFullYear(),
                month : cal.getMonth() + 1,
                day : cal.getDate()
            };
        }

        $.ajax({
            url : "/adminData/" + url,
            dataType : "json",
            data : data
        }).done(function (result) {
            func(result, place);
        });
    }




</script>