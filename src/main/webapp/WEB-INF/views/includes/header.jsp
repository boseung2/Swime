<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="./tagLib.jsp" %>

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


</style>


<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"/>
<!-- Google Fonts -->
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700&display=swap"/>
<!-- MDB -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.5.0/mdb.min.css"/>
<!-- MDB -->
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/mdb-ui-kit/3.5.0/mdb.min.js"></script>

<style>
    .navbar {
        font-family: 'Noto Sans KR', sans-serif;
        /*font-size: 1.6rem;*/
        color: rgba(68, 68, 68, 0.767);
        background: rgb(255, 255, 255);

        top: 0;
        position: sticky;
        width: 100%;
        transition: 0.1s;
        z-index: 100;
    }
    .navbar-dark .navbar-nav .nav-link:focus,
    .navbar-dark .navbar-nav .nav-link:hover,
    .navbar-dark .navbar-nav .nav-link.active,
    .navbar-dark .navbar-nav .show>.nav-link{
        font-family: 'Noto Sans KR', sans-serif;
        color: hsla(0, 0%, 0%, 0.8);
    }

    .navbar-dark .navbar-nav .nav-link {
        font-family: 'Noto Sans KR', sans-serif;
        color: hsla(0, 0%, 22%, 0.8);
    }


</style>


<!--Navbar -->
<nav class="mb-1 navbar navbar-expand-lg navbar-dark secondary-color lighten-1">
    <a class="navbar-brand" href="/">
        <img src="../../../resources/img/logo.png" alt="Swime" class="logo">
    </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent-555"
            aria-controls="navbarSupportedContent-555" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent-555">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="/group/list">모임 찾기

                    <%--                    <span class="sr-only">(current)</span>--%>
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/group/register">모임 만들기</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="/group/new/index">뉴모임 찾기</a>
            </li>

        </ul>

        <ul class="navbar-nav ml-auto nav-flex-icons">
            <sec:authorize access="isAnonymous()">
                <li class="nav-item">
                    <a class="nav-link" href="/user/register">회원가입</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/user/login">로그인</a>
                </li>
            </sec:authorize>
            <sec:authorize access="isAuthenticated()">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="chat" data-toggle="dropdown"
                   aria-haspopup="true" aria-expanded="false">1
                    <i class="fas fa-bell"></i>
                </a>
                <div class="dropdown-menu dropdown-secondary" aria-labelledby="chat">
                    <a class="dropdown-item" href="#">Action</a>
                    <a class="dropdown-item" href="#">Another action</a>
                    <a class="dropdown-item" href="#">Something else here</a>
                </div>
            </li>

            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" id="notice" data-toggle="dropdown"
                   aria-haspopup="true" aria-expanded="false">1
                    <i class="fas fa-envelope" id="noticeIconI"></i>
                </a>
                <div class="dropdown-menu dropdown-secondary" aria-labelledby="chat">
                    <a class="dropdown-item" href="#">Action</a>
                    <a class="dropdown-item" href="#">Another action</a>
                    <a class="dropdown-item" href="#">Something else here</a>
                </div>
            </li>
            </sec:authorize>
        </ul>

        <%--  프로필  --%>
        <sec:authorize access="isAuthenticated()">
        <ul class="navbar-nav nav-flex-icons">
            <li class="nav-item avatar dropdown" style="margin-right: 1rem;margin-left: 1rem;">
                <a class="nav-link dropdown-toggle" id="navbarDropdownMenuLink-55" data-toggle="dropdown"
                   aria-haspopup="true" aria-expanded="false" style="padding: 0;">
                    <img src="https://mdbootstrap.com/img/Photos/Avatars/avatar-2.jpg" class="rounded-circle z-depth-0"
                         alt="avatar image" style="height: 3rem;">
                </a>
                <div class="dropdown-menu dropdown-menu-lg-right dropdown-secondary"
                     aria-labelledby="navbarDropdownMenuLink-55">
                    <a class="dropdown-item" href="#">나의 정보</a>
                    <a class="dropdown-item" href="#">로그아웃</a>
                </div>
            </li>
        </ul>
        </sec:authorize>

    </div>
</nav>
<!--/.Navbar -->


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

