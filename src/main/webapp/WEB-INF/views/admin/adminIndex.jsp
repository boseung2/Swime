<%--
  Created by IntelliJ IDEA.
  User: JungHyungJin
  Date: 2021-05-06
  Time: 오전 10:35
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/tagLib.jsp" %>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Swime admin</title>
    <link href="../../../resources/css/adminPage.css" rel="stylesheet" />
    <link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>
</head>
<body class="sb-nav-fixed">
<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">


    <a class="navbar-brand" href="index.html">
        <img src="../../../resources/img/logo.png" class="swime-logo">
    </a>
    <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>

    <!-- Navbar Search-->
    <form class="d-none d-md-inline-block form-inline ml-auto mr-0 mr-md-3 my-2 my-md-0">
        <div class="input-group">
            <!-- <input class="form-control" type="text" placeholder="Search for..." aria-label="Search" aria-describedby="basic-addon2" /> -->
            <!-- <div class="input-group-append"> -->
            <!-- <button class="btn btn-primary" type="button"><i class="fas fa-search"></i></button> -->
            <!-- </div> -->
        </div>
    </form>
    <!-- Navbar-->
    <ul class="navbar-nav ml-auto ml-md-0">
        <!-- <li class="nav-item dropdown"> -->
        <!-- <a class="nav-link dropdown-toggle" id="userDropdown" href="#!" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a> -->
        <!-- </li> -->
        <div class="dropdown-menu dropdown-menu-right" aria-labelledby="userDropdown">
            <a class="dropdown-item" href="#!">Settings</a>
            <a class="dropdown-item" href="#!">Activity Log</a>
            <div class="dropdown-divider"></div>
            <a class="dropdown-item" href="login.html">Logout</a>
        </div>
    </ul>
</nav>
<div id="layoutSidenav">
    <div id="layoutSidenav_nav">
        <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
            <div class="sb-sidenav-menu">
                <div class="nav">
                    <div class="sb-sidenav-menu-heading"></div>
                    <a class="nav-link" href="/admin/adminIndex">
                        <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                        대시보드
                    </a>
                    <!-- <div class="sb-sidenav-menu-heading">Interface</div> -->
                    <a class="nav-link" href="/admin/manage-user">
                        <div class="sb-nav-link-icon"><i class="fas fa-users"></i>

                        </div>
                        회원관리
                        <!-- <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div> -->
                    </a>
                    <div class="collapse" id="collapseLayouts" aria-labelledby="headingOne" data-parent="#sidenavAccordion">
                        <nav class="sb-sidenav-menu-nested nav">
                            <a class="nav-link" href="layout-static.html">Static Navigation</a>
                            <a class="nav-link" href="layout-sidenav-light.html">Light Sidenav</a>
                        </nav>
                    </div>
                    <a class="nav-link" href="/admin/manage-group">
                        <div class="sb-nav-link-icon"><i class="far fa-handshake"></i></div>
                        모임관리
                        <!-- <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div> -->
                    </a>
                    <!-- <div class="collapse" id="collapsePages" aria-labelledby="headingTwo" data-parent="#sidenavAccordion">
                        <nav class="sb-sidenav-menu-nested nav accordion" id="sidenavAccordionPages">
                            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#pagesCollapseAuth" aria-expanded="false" aria-controls="pagesCollapseAuth">
                                Authentication
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="pagesCollapseAuth" aria-labelledby="headingOne" data-parent="#sidenavAccordionPages">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="login.html">Login</a>
                                    <a class="nav-link" href="register.html">Register</a>
                                    <a class="nav-link" href="password.html">Forgot Password</a>
                                </nav>
                            </div>
                            <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#pagesCollapseError" aria-expanded="false" aria-controls="pagesCollapseError">
                                Error
                                <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                            </a>
                            <div class="collapse" id="pagesCollapseError" aria-labelledby="headingOne" data-parent="#sidenavAccordionPages">
                                <nav class="sb-sidenav-menu-nested nav">
                                    <a class="nav-link" href="401.html">401 Page</a>
                                    <a class="nav-link" href="404.html">404 Page</a>
                                    <a class="nav-link" href="500.html">500 Page</a>
                                </nav>
                            </div>
                        </nav>
                    </div> -->
                    <!-- <div class="sb-sidenav-menu-heading">Addons</div> -->
                    <a class="nav-link" href="/admin/manage-study">
                        <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>
                        스터디관리
                    </a>
                    <a class="nav-link" href="/admin/manage-board">
                        <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>
                        게시물관리
                    </a>
                </div>
            </div>
            <!-- <div class="sb-sidenav-footer">
                <div class="small">Logged in as:</div>
                Start Bootstrap
            </div> -->
        </nav>
    </div>
    <div id="layoutSidenav_content">
        <main id="ContentsPlace">
<%--            <div class="container-fluid">--%>
<%--                <!-- <h2 class="mt-4">대시보드</h2> -->--%>
<%--                <ol class="breadcrumb mb-4">--%>
<%--                    <li class="breadcrumb-item active">Dashboard</li>--%>
<%--                </ol>--%>
<%--                <div class="row">--%>
<%--                    <div class="col-xl-4 col-md-4">--%>
<%--                        <div class="card bg-primary text-white mb-4">--%>
<%--                            <div class="card-body">당일 가입자수</div>--%>
<%--                            <div class="card-footer d-flex align-items-center justify-content-between">--%>
<%--                                <a class="small text-white stretched-link" href="#">View Details</a>--%>
<%--                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="col-xl-4 col-md-4">--%>
<%--                        <div class="card bg-warning text-white mb-4">--%>
<%--                            <div class="card-body">당일 생성 모임수</div>--%>
<%--                            <div class="card-footer d-flex align-items-center justify-content-between">--%>
<%--                                <a class="small text-white stretched-link" href="#">View Details</a>--%>
<%--                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="col-xl-4 col-md-4">--%>
<%--                        <div class="card bg-success text-white mb-4">--%>
<%--                            <div class="card-body">당일 생성 스터디수</div>--%>
<%--                            <div class="card-footer d-flex align-items-center justify-content-between">--%>
<%--                                <a class="small text-white stretched-link" href="#">View Details</a>--%>
<%--                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <!-- <div class="col-xl-3 col-md-6">--%>
<%--                        <div class="card bg-danger text-white mb-4">--%>
<%--                            <div class="card-body">Danger Card</div>--%>
<%--                            <div class="card-footer d-flex align-items-center justify-content-between">--%>
<%--                                <a class="small text-white stretched-link" href="#">View Details</a>--%>
<%--                                <div class="small text-white"><i class="fas fa-angle-right"></i></div>--%>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                    </div> -->--%>
<%--                </div>--%>
<%--                <div class="row">--%>
<%--                    <div class="col-xl-6">--%>
<%--                        <div class="card mb-4">--%>
<%--                            <div class="card-header">--%>
<%--                                <i class="fas fa-chart-area mr-1"></i>--%>
<%--                                일일 가입자수--%>
<%--                            </div>--%>
<%--                            <div class="card-body"><canvas id="myAreaChart" width="100%" height="40"></canvas></div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="col-xl-6">--%>
<%--                        <div class="card mb-4">--%>
<%--                            <div class="card-header">--%>
<%--                                <i class="fas fa-chart-bar mr-1"></i>--%>
<%--                                시간대별 접속자수--%>
<%--                            </div>--%>
<%--                            <div class="card-body"><canvas id="myBarChart" width="100%" height="40"></canvas></div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--                <div class="row">--%>
<%--                    <div class="col-lg-6">--%>
<%--                        <div class="card mb-4">--%>
<%--                            <div class="card-header">--%>
<%--                                <i class="fas fa-chart-pie mr-1"></i>--%>
<%--                                모임언어--%>
<%--                            </div>--%>
<%--                            <div class="card-body"><canvas id="myPieChart" width="100%" height="50"></canvas></div>--%>
<%--                            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                    <div class="col-lg-6">--%>
<%--                        <div class="card mb-4">--%>
<%--                            <div class="card-header">--%>
<%--                                <i class="fas fa-chart-pie mr-1"></i>--%>
<%--                                모임지역--%>
<%--                            </div>--%>
<%--                            <div class="card-body"><canvas id="myPieChart2" width="100%" height="50"></canvas></div>--%>
<%--                            <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>--%>
<%--                        </div>--%>
<%--                    </div>--%>
<%--                </div>--%>
<%--            </div>--%>
    <%@include file="./dashBoard.jsp" %>
        </main>
        <%@include file="./footer.jsp" %>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="../../../resources/js/adminPage.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>
<script src="../../../resources/js/adminPageDemo/chart-area-demo.js"></script>
<script src="../../../resources/js/adminPageDemo/chart-bar-demo.js"></script>
<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
<script src="../../../resources/js/adminPageDemo/datatables-demo.js"></script>
<script src="../../../resources/js/adminPageDemo/chart-bar-demo.js"></script>
<script src="../../../resources/js/adminPageDemo/chart-pie-demo.js"></script>
<script src="../../../resources/js/adminPageDemo/chart-pie-demo2.js"></script>
</body>
</html>

<script>
    let contentPlace = $("#ContentsPlace");
    ajax(contentPlace);


    $(document).ready(function () {

    });


    function ajax(contentPlace) {
        $.ajax({
            url:"/admin/dashBoard",
            data : {

            },
            success:function(result) {
                $(contentPlace).html(result);
            }
        });
    }
</script>