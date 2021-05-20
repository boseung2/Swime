<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="newTagLib.jsp"%>

<nav class="navbar navbar-default">
    <div class="container-fluid">

        <div class="navbar-header">
            <!-- 토글버튼 -->
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>

            <!-- 사이트 로고 -->
            <a class="navbar-brand" href="/">
                <img src="../../../resources/img/logo.png" alt="Swime" class="logo">
            </a>
        </div>

        <div class="collapse navbar-collapse" id="myNavbar">
            <!-- 왼쪽 메뉴 -->
            <ul class="nav navbar-nav">
                <li><a href="/group/list">모임 찾기</a></li>
                <li><a href="/group/register">모임 만들기</a></li>
                <li><a href="/group/new/index">뉴모임 찾기</a></li>
            </ul>


            <!-- 오른쪽 메뉴 -->
            <ul class="nav navbar-nav navbar-right">

                <!-- 비로그인 -->
                <sec:authorize access="isAnonymous()">
                    <li><a href="/user/register" class="RegisterBtn">회원가입</a></li>
                    <li><a href="/user/login" class="loginBtn"><button class="btn btn-primary btn-lg">로그인</button></a></li>
                </sec:authorize>

                <!-- 로그인 -->
                <sec:authorize access="isAuthenticated()">
                    <li>
                        <a href="/chat/list">
                            <span class="navIcon"><i class="far fa-comment-alt"></i></span>
                            <span class="navText">채팅</span>
                        </a>
                    </li>
                    <li>
                        <a id="notice" aria-expanded="false">
                            <span class="navIcon"><i class="far fa-bell"></i></span>
                            <span class="navText">알림</span>
                        </a>
                    </li>

                    <sec:authorize access="hasAuthority('ADMIN')">
                        <li>
                            <a href="/admin/adminIndex">
                                <span class="navIcon"><i class="fas fa-cog"></i></span>
                                <span class="navText">어드민</span>
                            </a>
                        </li>
                    </sec:authorize>

                    <li class="nav-item dropdown" id="profile">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                            ${memberVO.name} 님 안녕하세요  <span><i class="fas fa-chevron-down"></i></span>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="userInfoBtn">사용자 정보</a></li>
                            <li><a class="logoutBtn"><span class=""></span> 로그아웃</a></li>
                        </ul>
                    </li>
                </sec:authorize>

            </ul>
        </div>
    </div>
</nav>

<!-- Modal -->
<div class="modal " id="navModal" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-body">
                <div class="list-group custom-mb0">
                    <img src="${getPicture}" class="img-rounded img-responsive center-block profileImageSquare custom-mb1" alt="">
                    <a class="list-group-item userInfoBtn">사용자 정보</a>
                    <a class="list-group-item list-group-item-danger logoutBtn"><span class=""></span> 로그아웃</a>
                </div>
            </div>
        </div>

    </div>
</div>

<!-- Modal -->
<div class="modal " id="navModal2" role="dialog">
    <div class="modal-dialog">

        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-body">
                <div class="list-group custom-mb0">
                    <ul id="myDropdown" class="dropdown-content">
                        <li>알림이 없습니다.</li>
                    </ul>
                </div>
            </div>
        </div>

    </div>
</div>


<script>

    $(document).ajaxSend(function(e, xhr, options) {
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
    });

    $(".userInfoBtn").on("click", function () {
        $(location).attr('href', '/user/infoDetail?id=' + "${memberVO.id}");
    });

    $(".logoutBtn").on("click", function () {
        $.ajax({
            url: "/user/logout",
            method : 'Post'
        }).done(function () {
            $(location).attr('href', '/');
        }).fail(function () {
            alert("오류가 발생했습니다");
        });
    });

    function transparencyNav(condition) {
        let IsTransparency = condition === undefined ? false : condition === true;
        let logo = $(".navbar-brand > img");

        if(IsTransparency)
            logo.css("filter", "brightness(100) invert(0)");

        $(document).on("scroll", function () {
            // nav 위에 붙이기
            if (document.body.scrollTop > 250 || document.documentElement.scrollTop > 250) {
                if(IsTransparency)
                    logo.css("filter", "");
            }
            // nav 없애기
            else {
                if(IsTransparency)
                    logo.css("filter", "brightness(100) invert(0)");
            }
        });
    }


    $(document).on("scroll", function () {
        let navbar = $(".navbar");
        // nav 위에 붙이기
        let scrollvalue = 250;
        if (document.body.scrollTop > scrollvalue || document.documentElement.scrollTop > scrollvalue) {
            navbar.css("top", "0px");
            navbar.css("background-color", "white");
        }
        // nav 없애기
        else {
            navbar.css("top", "-72px");
            navbar.css("background-color", "rgba(255, 255, 255, 0)");
        }
    });


    $(document).ready(function(){
        $("#profile").click(function(){
            $("#navModal").modal();
            $('.modal-backdrop').css('display', 'none');
        });



        $(document).click(function(e){ //문서 body를 클릭했을때
            if(!(e.target.className ==="far fa-bell" || e.target.id === 'notice' )) $("#notice").parent().removeClass('open');

        });

        $("#notice").click(function(){
            $(this).parent().addClass('open');
            $("#navModal2").modal();
            $('.modal-backdrop').css('display', 'none');
        });




    });


</script>

<!-- 알림 -->


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
        if("${memberVO.id}" !== "") {
            getNoticeButton();
        }
    })

    // 안읽은 알림이 있으면 활성화된 알림버튼을 띄운다.
    function getNoticeButton() {
        noticeService.getList("${memberVO.id}", function(data) {

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
        noticeService.getList("${memberVO.id}", function(data) {

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


