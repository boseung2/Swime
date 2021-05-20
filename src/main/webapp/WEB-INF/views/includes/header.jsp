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
    <script src="/resources/js/a076d05399.js"></script>

    <!-- scrollbar -->
    <link href="/resources/css/scrollbar.css" rel="stylesheet">

    <style>
        @media (min-width: 768px) {
            .container {
                width: 750px;
            }
        }

        @media (min-width: 992px) {
            .container {
                width: 1000px;
            }
        }

        /*<!-- 알림 드롭다운-->*/
        .dropdown {
            position: relative;
            display: inline-block;
        }


        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f1f1f1;
            min-width: 160px;
            overflow: auto;
            box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
            z-index: 1;
        }

        .dropdown-content a {
            color: black;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            width: 330px;
        }

        .dropdown a:hover {background-color: #ddd;}

        .show {display: block;}

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
            display: none;

        }
    </style>

</head>

<body>
<!-- header -->
<div class="header">
    <a href="/" class="logo"><img src="../../../resources/img/logo.png"></a>
    <a href="/group/list">모임찾기</a>
    <a href="/group/register">모임만들기</a>
    <a href="/group/new/index">뉴 모임찾기(미적용)</a>

    <div class="header-right">
        <sec:authorize access="isAuthenticated()">
            <a href="/serviceCenter/list">고객센터</a>
            <div class="dropdown" style="position: absolute;">
                <ul id="myDropdown" class="dropdown-content">
                    <li>알림이 없습니다.</li>
                </ul>
            </div>
            <a><img id="notice" src="../../../resources/img/notice.png" style="width:18px; height: 18px;"></a>
            <a href="/chat/list">
                <img id="chatBtn" src="../../../resources/img/chat.png" style="width:18px; height: 18px;">
                <div class="red"></div>
            </a>
        </sec:authorize>
        <sec:authorize access="isAnonymous()">
            <a href="/user/register">회원가입</a>
            <a class="active" href="/user/login">로그인</a>
        </sec:authorize>
        <sec:authorize access="isAuthenticated()">
            <a href="/user/infoDetail?id=<sec:authentication property='principal.username'/>"><sec:authentication property="principal.memberVO.name"/> 님 안녕하세요</a>
            <sec:authorize access="hasAuthority('ADMIN')">
                <a href="/admin/adminIndex">어드민 페이지</a>
            </sec:authorize>
            <a href="#" onclick="document.getElementById('logout').submit();">로그아웃</a>
        </sec:authorize>
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
<script type="text/javascript", src="/resources/js/chat.js"></script>

<!-- 웹소켓-->
<script type="text/javascript">
    // 전역변수 socket
    let noticeSocket = null;
    let chatSocket = null;

    $(document).ready(function() {

        //알림 웹소켓 연결
        let sock = new SockJS('/notice');
        noticeSocket = sock;

        // 데이터 전달받았을 때
        sock.onmessage = onNoticeMessage;

        function onNoticeMessage(e) {
            let data = e.data;

            // notice 이미지를 바꿔준다.
            $('#notice')[0].src = "../../../resources/img/exist_notice.png";
        }

        // 채팅 웹소켓 연결
        let sock2 = new SockJS('/chat');
        chatSocket = sock2;

        sock2.onmessage = onChatMessage;

        console.log("context = " + getContextPath(document.location.href));

        function onChatMessage(e) {
            let data = e.data;

            if(data === "reload chatList") {

                // url의 context가 chat이면
                if(getContextPath(document.location.href) === '/chat') {

                    //채팅방 리로드
                    reloadChatList();
                }else {

                    // 아니면 chatBtn 다시 불러오기
                    getChatButton();
                }
            }
        }

    })

    // context path 가져오는 함수
    function getContextPath() {
        let hostIndex = location.href.indexOf( location.host ) + location.host.length;
        return location.href.substring( hostIndex, location.href.indexOf('/', hostIndex + 1) );
    }

</script>

<script>
    $(document).ready(function() {
        // 로그인된 상태이면 알림버튼, 채팅버튼 띄우기
        if("${pinfo.username}" !== "") {
            getNoticeButton();
            getChatButton();
        }

        // post, ajax 시큐리티 적용
        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        // ajax spring security header
        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        });
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
    $('#myDropdown').on("click", "li", function(e){

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

        // 알림버튼 다시 불러오기
        getNoticeButton();

    })

    // 채팅버튼 불러오기
    function getChatButton() {
        chatService.getTotalUnreadMsg("${pinfo.username}", function(result){

            if(result > 0) {
                $('.red').css('display', 'inline');
            }else {
                $('.red').css('display', 'none');
            }
        })

    }

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