<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal" var="pinfo"/>
</sec:authorize>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">


    <title>SWIME</title>


    <!-- Bootstrap core CSS -->
    <link href="/resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- Custom styles for this template -->
    <link href="/resources/css/small-business.css" rel="stylesheet">

    <!-- nav -->
    <link href="/resources/css/nav.css" rel="stylesheet">

    <!-- avatar -->
    <link href="/resources/css/avatar.css" rel="stylesheet">

    <!-- filter -->
    <link href="/resources/css/filter.css" rel="stylesheet">

    <!-- jquery -->
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <!-- font icon -->
<%--    <script src="https://kit.fontawesome.com/a076d05399.js" crossorigin="anonymous"></script>--%>
<%--    <script src="/resources/js/a076d05399.js"></script>--%>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.css" integrity="sha256-PF6MatZtiJ8/c9O9HQ8uSUXr++R9KBYu4gbNG5511WE=" crossorigin="anonymous" />

    <!-- scrollbar -->
    <link href="/resources/css/scrollbar.css" rel="stylesheet">

    <style>
        /*@media (min-width: 768px) {*/
        /*    .container {*/
        /*        width: 750px;*/
        /*    }*/
        /*}*/

        /*@media (min-width: 992px) {*/
        /*    .container {*/
        /*        width: 1000px;*/
        /*    }*/
        /*}*/

        /*!*<!-- 알림 드롭다운-->*!*/
        /*.dropdown {*/
        /*    position: relative;*/
        /*    display: inline-block;*/
        /*}*/


        /*.dropdown-content {*/
        /*    display: none;*/
        /*    position: absolute;*/
        /*    background-color: #f1f1f1;*/
        /*    min-width: 160px;*/
        /*    overflow: auto;*/
        /*    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);*/
        /*    z-index: 1;*/
        /*}*/

        /*.dropdown-content a {*/
        /*    color: black;*/
        /*    padding: 12px 16px;*/
        /*    text-decoration: none;*/
        /*    display: block;*/
        /*    width: 330px;*/
        /*}*/

        /*.dropdown a:hover {background-color: #ddd;}*/

        /*.show {display: block;}*/
    </style>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
        }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            margin: 0 auto;

        }

        /* Reset CSS */

        a {
            color: inherit;
            text-decoration: none;
        }

        button,
        input,
        textarea {
            font-size: 16px;
            font-family: 'Noto Sans KR', sans-serif;
            background: white;
        }

        button:focus,
        button:active,
        input:focus,
        input:active,
        textarea:focus,
        textarea:active {
            box-shadow: none;
            outline: none;
        }

        ul,
        ol,
        li {
            list-style: none;
            padding-left: 0;
            margin-left: 0;
        }

        /* Header */

        .header-block {
            position: fixed;
            width: 100%;
            height: 70px;
            background-color: white;
            box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.08);
            padding-right: 20px;
            display: flex;
            align-items: center;
            font-size: 1rem;
            color: rgba(68, 68, 68, 0.767);

        }

        .logo {
            width: 115px;
            margin-left: 20px;
            margin-right: 35px;
        }

        .flex-flow {
            flex-grow: 1;
        }

        .header-menu,
        .header-login {
            display: flex;
        }

        .header-menu li,
        .header-login li {
            margin-right: 30px;
            cursor: pointer;
        }

        .header-menu li:hover,
        .header-menu li:focus,
        .header-login li:hover,
        .header-login li:focus {
            color: rgb(32, 32, 32);
        }

        .point {
            background-color: cornflowerblue;
            color: white;
            padding: 10px 20px;
            border-radius: 6px;
        }

        .point:hover,
        .point:focus {
            background-color: #4dcfe0;
        }

        .spacer {
            height: 75px;
        }

        /* main */

        .container {
            width: 1000px;
        }

        .main-container {
            width: 980px;
            height: 903px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
        }

        .main-wrapper {
            width: 100%;
            height: 900px;
        }

        .main-wrapper section {
            display: flex;
            justify-content: center;
        }

        .main-left {
            width: 50%;
            height: 903px;
            background: white;
            padding-bottom: 150px;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
        }

        .main-left {
            color:rgb(54, 54, 54)
        }

        .main-right {
            width: 50%;
            height: 903px;
            display: flex;
            padding-bottom: 300px;
            background: white;
            flex-direction: column;
            justify-content: flex-end;
        }

        .main-right img {
            width: 100%;
            margin-left: 35px;
        }

        .main-left h2 {
            font-size: 2rem;
        }

        .search-form {
            width: 90%;
            height: 60px;
            margin-top: 30px;
            padding-right: 20px;
            border-radius: 6px;
            border: 2px solid rgba(89, 176, 248, 0.966);
            display: flex;
            align-items : center;
        }

        input::placeholder {
            color: rgb(160, 158, 158);
        }

        .search-form:hover {
            border: 2px solid #4dcfe0;
        }

        .search-form form input {
            border: none;
            margin-left: 10px;
        }

        .search-form i {
            font-size: 20px;
            color: rgba(59, 228, 250, 0.897);
        }

        .language-icon {
            font-size: 12px;
        }

        .language-list {
            width: 100%;
            height: 300px;
        }

        .language-list ul{
            margin-top: 30px;
            display: flex;
            flex-direction: column;
        }

        .language-list ul li {
            font-size: 45px;
            color: rgba(76, 164, 236, 0.966);
            margin-left: 6px;
            text-align: center;
            line-height: 10%;

        }

        .language-list ul li:hover {
            color: #4dcfe0;
        }

        .language-top,
        .language-bottom {
            display: flex;
            justify-content: flex-start;
            margin-bottom: 30px;
        }

        .language-top li {
            margin-right: 43px;
        }

        .language-bottom li {
            margin-right: 38px;
        }

        /* Card */

        .card-container {
            width: 980px;
            height: 500px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
        }

        .card-wrap {
            display: flex;
            justify-content: space-between;
            margin-top: 10px;
        }

        article {
            display: flex;
            padding-right: 20px;
            margin-bottom: 30px;
        }

        article h1 {
            margin-top: 50px;
            color:rgb(54, 54, 54)
        }

        article h2 {
            margin-top: 60px;
            font-size: 1rem;
            font-weight: 200;
            color: rgba(68, 68, 68, 0.767)
        }

        article h2:hover {
            color: rgb(32, 32, 32);
        }

        .card {
            display: flex;
            flex-direction: column;
            width: 300px;
            height: 300px;
        }

        .card-img {
            display: block;
            width: 100%;
            height: 300px;
            background-image: url(assets/java2.jpg);
            background-size: cover;
            background-repeat: no-repeat;
            background-position: center;
            border-radius: 4px;
            margin-bottom: 10px;
        }


        .card-content span {
            font-size: 13px;
            color: #0b70e4e3;
        }

        .card-content h3 {
            font-size: 20px;
            color:rgb(32, 32, 32);
        }

        .card-content p {
            color:rgb(90, 89, 89);
        }


        /* footer */

        footer {
            width: 100%;
            height: 408px;
            background-color: #1E1E1E;
            padding-top: 60px;
            margin-top: 100px;
        }

        .footer-container {
            width: 980px;
            height: 300px;
            margin: 0 auto;
            display: flex;
        }

        .footer-left {
            width: 30%;
            height: 300px;
            display: flex;
            flex-direction: column;
            padding-bottom: 20px;
            justify-content: space-around;
        }

        .footer-contect i {
            font-size: 30px;
            color:rgb(160, 158, 158);
            margin-right: 10px;
        }

        .footer-logo img {
            width: 120px;
        }

        .footer-contect i:hover {
            color: white;
        }

        .footer-right {
            width: 70%;
            height: 300px;
            display: flex;
            justify-content: flex-end;
        }

        .footer-project,
        .footer-customer {
            width: 33%;
            height: 300px;
            text-align: center;
            color:rgb(214, 211, 211);
        }

        .footer-project h2,
        .footer-customer h2 {
            font-weight: bold;
            font-size: 20px;
            margin-bottom: 30px;
        }

        .footer-customer h2:hover {
            color: white;
        }


        .footer-project li {
            margin-bottom: 10px;
            font-size: 20px;
        }

        .footer-customer {
            width: 33%;
            height: 300px;
        }

        .footer-customer p {
            font-size: 1.5rem;
            font-weight: bold;
            margin-top: 30px;
            color: white;
        }

        /* 로그인 후 헤더 */
        .header-login-after {
            display: flex;
            justify-content: space-between;
        }

        .header-login-after button {
            border: none;
            height: 40px;
            color: rgba(68, 68, 68, 0.767);
            cursor: pointer;
            margin-left: 15px;
        }

        .header-login-after button:focus,
        .header-login-after button:active,
        .header-login-after button:hover {
            color: rgb(32, 32, 32);
        }

        .button-icon {
            background: #73b4fde3;
            width: 40px;
            border-radius: 50%;
        }

        .button-icon:focus,
        .button-icon:active,
        .button-icon:hover {
            background: #4dcfe0;
        }


        .button-icon i {
            font-size: 25px;
            color: #fcfdfde3;
        }

        /* 알람 빨간색 */

        .red {
            z-index: 1;
            float: right;
            width: 10px;
            height: 10px;
            border-radius: 50%;
            background: rgb(243, 98, 98);
            position: relative;
            right: 10px;
            top: 1px;
            /* display: none; */

        }

        /* 모달 */

        .modal {
            display: flex;
            justify-content: flex-end;
            flex-wrap: wrap;
        }

        .modal-alert {
            width: 320px;
            height: 500px;
            background: white;
            border-radius: 5px;
            position: relative;
            bottom: 12px;
            right: 50px;
            box-shadow: 2px 2px 2px 2px rgba(0, 0, 0, 0.08);
            border: 1px solid rgb(212, 212, 212);
            padding: 20px;
            display: none;
        }

        .modal-alert h3 {
            font-size: 20px;
            font-weight: 100;
            color: rgb(32, 32, 32)
        }

        .modal-alert p,
        .modal-mypage a {
            text-align: center;
            margin-top: 30px;
            color:rgb(90, 89, 89);
        }

        .modal-mypage {
            float: right;
            width: 200px;
            height: 180px;
            background: white;
            border-radius: 5px;
            position: relative;
            bottom: 12px;
            right: 8px;
            box-shadow: 2px 2px 2px 2px rgba(0, 0, 0, 0.08);
            border: 1px solid rgb(212, 212, 212);
            padding: 20px;
            display: none;
        }

        .modal-mypage h3 {
            font-size: 17px;
            font-weight: 100;
            color:rgb(90, 89, 89);
            margin-bottom: 30px;
        }


    </style>

</head>

<body>
<!-- header -->
<header class="header-block">
    <h1>
        <a href="">
            <img src="../../../resources/img/logo.png" alt="Swime" class="logo">
        </a>
    </h1>
    <nav>
        <h1 style="display: none;">Menu</h1>
        <ul class="header-menu">
            <li>
                <a href="">모임 찾기</a>
            </li>
            <li>
                <a href="">모임 만들기</a>
            </li>
        </ul>
    </nav>
    <div class="flex-flow"></div>
    <ul class="header-login-after">
        <li>
            <button type="button" class="button-icon" id="alert">
                <i class="far fa-bell"></i>
            </button>
            <div class="red"></div>
        </li>
        <li>
            <button type="button" id="mypage">
                <p><span>신성권</span> 고객님 &nbsp&nbsp<i class="fas fa-chevron-down"></i></p>
            </button>
        </li>
    </ul>
</header>
<div class="spacer"></div>

<div class="modal">
    <div class="modal-alert">
        <h3>알림</h3>
        <p>받은 알림이 없습니다</p>
    </div>
    <div class="modal-mypage">
        <h3>안녕하세요, <span>신성권</span>님</h3>
        <span>
        <a href="#">
          마이페이지
        </a>
      </span>
        <br>
        <br>
        <span>
        <a href="#">
           로그아웃
        </a>
      </span>
    </div>
</div>

<sec:authorize access="isAuthenticated()">
<%--    <div class="dropdown">--%>
<%--        <ul id="myDropdown" class="dropdown-content">--%>
<%--            <li>알림이 없습니다.</li>--%>
<%--        </ul>--%>
<%--    </div>--%>
</sec:authorize>

<%--toast 알림--%>
<%--<div id="msgStack"></div>--%>

<form id="logout" action="/user/logout" method="post" hidden>
    <%--    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>--%>
    <sec:csrfInput/>
</form>

<hr style="
    margin-top: 0px;
    margin-bottom: 0px;">

<!-- 알림 -->
<!-- sockJS -->
<script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

<script type="text/javascript", src="/resources/js/notice.js"></script>

<!-- 웹소켓-->
<script type="text/javascript">
    // 전역변수 socket
    let socket = null;

    $(document).ready(function() {

        //웹소켓 연결
        let sock = new SockJS('/notice');
        socket = sock;

        // 데이터 전달받았을 때
        sock.onmessage = onMessage;

        function onMessage(e) {
            let data = e.data;

            // notice 이미지를 바꿔준다.
            $('#notice')[0].src = "../../../resources/img/exist_notice.png";
        }

    })

</script>

<script>
    $(document).ready(function() {
        // 로그인된 상태이면 알림버튼 띄우기
        if("${pinfo.username}" !== "") {
            getNoticeButton();
        }
    })

    // 안읽은 알림이 있으면 활성화된 알림버튼을 띄운다.
    function getNoticeButton() {
        noticeService.getList("${pinfo.username}", function(data) {

            if(data.length > 0) {
                $('#notice')[0].src = "../../../resources/img/exist_notice.png";

            }else if(data.length === 0) {
                $('#notice')[0].src = "../../../resources/img/notice.png";
            }
        })
    }

    // 알림버튼 눌리면
    $('#notice').on("click", function() {

        // 안읽은 알림을 가져와서 드롭다운 리스트에 띄워준다.
        noticeService.getList("${pinfo.username}", function(data) {

            console.log(data);

            if(data == null || data.length <= 0) return;

            let str = '';

            for(let i = 0; i < data.length; i++) {
                str += '<li class="noticeList" data-sn="' + data[i].sn + '">';
                str += '<a href="' + data[i].url +'">';
                str += '<strong>[' + data[i].kind + ']</strong> ';
                str += data[i].content;
                str += '<br>';

                let tempDate = new Date(data[i].sendDate);
                // 월
                let month = tempDate.getMonth()+1;
                month = (month < 10 ? "0" : "") + month;
                // 일
                let date = tempDate.getDate();
                date = (date < 10 ? "0" : "") + date;
                // 시간
                let hours = tempDate.getHours();
                hours = (hours < 10 ? "0" : "") + hours;
                // 분
                let min = tempDate.getMinutes();
                min = (min < 10 ? "0" : "") + min;

                str += tempDate.getFullYear() + '-' + month + '-' + date;
                str += ' ' + hours + ':' + min;

                str += '</a>';
                str += '</li>';
            }

            $('#myDropdown').html(str);
        })

        $("#myDropdown")[0].classList.toggle("show");
    })

    // 알림 리스트가 눌리면
    $('#myDropdown').on("click", "li", function(){

        if($(this).attr("class") === undefined) {
            return;
        }

        let sn = $(this).data("sn");

        // 해당 알림을 읽음처리
        noticeService.modify({sn : sn}, function(result) {
            if(result === "success") {
                console.log('해당 알림을 읽음처리했음!');
            }
        })
    })

    $(document).ready(function (){
        let noti = $("#notice")[0];
        let drop = $(".dropdown");
        drop.offset({
            top: $("#notice").offsetTop + 30,
        });
    })



</script>

<%-- countVisitor --%>
<script>
    visitorCountRequest();

    function visitorCountRequest() {
        $.ajax({
            url : "/adminData/countVisitor",
        }).done(function (result) {
        });
    }
</script>

<script>
    $("#alert").click(function(){
        $(".modal-alert").stop().fadeToggle(500);
        return false;
    });

    $(document).click(function(e){
        if(e.target.className ==".modal-alert"){return false}
        $(".modal-alert").stop().fadeOut(500);
    });

    $("#mypage").click(function(){
        $(".modal-mypage").stop().fadeToggle(500);
        return false;
    });

    $(document).click(function(e){
        if(e.target.className ==".modal-mypage"){return false}
        $(".modal-mypage").stop().fadeOut(500);
    });

</script>