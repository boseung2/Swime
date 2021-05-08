<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../includes/tagLib.jsp" %>

<%--<script src="../../../resources/js/adminPageDemo/chart-area-demo.js"></script>--%>
<script src="../../../resources/js/adminPageDemo/chart-bar-demo.js"></script>
<script src="../../../resources/js/adminPageDemo/chart-bar-demo.js"></script>
<script src="../../../resources/js/adminPageDemo/chart-pie-demo.js"></script>
<script src="../../../resources/js/adminPageDemo/chart-pie-demo2.js"></script>

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
                <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
            </div>
        </div>
        <div class="col-lg-6">
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fas fa-chart-pie mr-1"></i>
                    모임지역
                </div>
                <div class="card-body"><canvas id="myPieChart2" width="100%" height="50"></canvas></div>
                <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
            </div>
        </div>
    </div>
</div>

<script>

    $(document).ready(function () {
        getData("countUser", "number");
        getData("countStudy", "number");
        getData("countGroup", "number");
        chartData("countUserForMonth", "chart");
    });

    function getData(url, type){
        $.ajax({
            url : "/adminData/" + url,
            dataType : "json"
        }).done(function (result) {
            if(type === 'number'){
                $("#"+url).html(result);
            }
        });
    }

    function chartData(url, type){
        let cal = new Date();

        $.ajax({
            url : "/adminData/" + url,
            dataType : "json",
            data : {
                year : cal.getFullYear(),
                month : cal.getMonth() + 1
            }
        }).done(function (result) {
            // console.log(result);
            makeChart(result, cal);
        });
    }

    function makeChart(result, cal) {

        let max = Math.max.apply(null, result);
        let label = [];
        for (let i = 0; i < result.length; i++) {
            label[i] = (i+1) + ' Day';
        }




        // Set new default font family and font color to mimic Bootstrap's default styling
        Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
        Chart.defaults.global.defaultFontColor = '#292b2c';

        // Area Chart Example
        var ctx = document.getElementById("myAreaChart");
        var myLineChart = new Chart(ctx, {
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
                    pointHitRadius: 50,
                    pointBorderWidth: 2,
                    data: result,
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
                            maxTicksLimit: 7
                        }
                    }],
                    yAxes: [{
                        ticks: {
                            min: 0,
                            max: max,
                            maxTicksLimit: 5
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
</script>