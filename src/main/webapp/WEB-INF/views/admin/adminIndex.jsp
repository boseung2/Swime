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

<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="../../../resources/js/adminPage.js"></script>
<link href="../../../resources/css/adminPage.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/js/all.min.js" crossorigin="anonymous"></script>




<script src="https://cdn.datatables.net/1.10.20/js/jquery.dataTables.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.datatables.net/1.10.20/js/dataTables.bootstrap4.min.js" crossorigin="anonymous"></script>
<script src="../../../resources/js/adminPageDemo/datatables-demo.js"></script>
<link href="https://cdn.datatables.net/1.10.20/css/dataTables.bootstrap4.min.css" rel="stylesheet" crossorigin="anonymous" />

<script src="../../../resources/js/adminDashBoard/chartGlobalSettings.js"></script>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Swime admin</title>
    <style>
        #myModal{
            position:absolute;
            width:100%;
            height:150%;
            background: rgba(0,0,0,0.8);
            top:0;
            left:0;
            display:none;
            z-index: 2000;
        }
    </style>
</head>
<body class="sb-nav-fixed">

    <%--modal--%>
    <div id='modalPlace'></div>

    <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">

    <a class="navbar-brand" href="/">
        <img src="../../../resources/img/logo.png" class="swime-logo">
    </a>
<%--    <button class="btn btn-link btn-sm order-1 order-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>--%>

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

                    <a class="nav-link" href="/admin/dashBoard">
                        <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>대시보드
                    </a>

                    <a class="nav-link" href="/admin/manage-user">
                        <div class="sb-nav-link-icon"><i class="fas fa-users"></i></div>회원관리
                    </a>

                    <a class="nav-link" href="/admin/manage-group">
                        <div class="sb-nav-link-icon"><i class="far fa-handshake"></i></div>모임관리
                    </a>

                    <a class="nav-link" href="/admin/manage-study">
                        <div class="sb-nav-link-icon"><i class="fas fa-book-open"></i></div>스터디관리
                    </a>

                    <a class="nav-link" href="/admin/manage-board">
                        <div class="sb-nav-link-icon"><i class="fas fa-table"></i></div>게시물관리
                    </a>
                    
                </div>
            </div>

        </nav>
    </div>
    <div id="layoutSidenav_content">
        <main id="ContentsPlace">

        </main>
        <%@include file="./footer.jsp" %>
    </div>
</div>


</body>
</html>

<script>
    let pieChartMaker;

    $(document).ready(function () {
        let first = $(".nav > .nav-link")[0];
        $(first).addClass('active');

        loadByAjax(first.attributes[1].nodeValue);
    });


    $(".nav > .nav-link").on("click", function (e) {
        e.preventDefault();
        $(".nav > .nav-link").removeClass('active');
        $(this).addClass('active');
        let href = this.attributes[1].nodeValue;

        loadByAjax(href);
    });


    function loadByAjax(href) {
        $.ajax(href).done(function(result) {
            $("#ContentsPlace").html(result);
        });

        // $.ajax({
        //     url : href,
        //     type: 'GET',
        //     success:function(result) {
        //         $("#ContentsPlace").html(result);
        //     }
        // });
    }
</script>