<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="../includes/header.jsp" %>

<h2>멤버 관리</h2>
<a class="btn btn-primary" href="/study/get?pageNum=${cri.pageNum}&amount=${cri.amount}&sn=${stdSn}">스터디로 돌아가기</a>


<!-- nav -->
<div class="topnav" style="margin-bottom: 10px;">
    <a href="#member" class="active">참여 멤버</a>
    <a href="#waitingMember">승인 대기 멤버</a>
</div>
<!-- /nav -->

<div id="member">
    <ul id="attendList">

    </ul>
</div>

<div id="waitingMember">
    <ul id="waitingList">

    </ul>
</div>

<%@include file="../includes/footer.jsp" %>

<script type="text/javascript" src="/resources/js/studyMember.js"></script>
<script type="text/javascript" src="/resources/js/studyAttend.js"></script>

<script>
    $(document).ready(function() {

        // post방식 처리
        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        });

    })
</script>

<script>
    $(document).ready(function() {

        getAttendList();
        getWaitingList();

    })
</script>

<script>

    // 참여멤버 가져오기
    function getAttendList() {
        studyMemberService.getAttendList("${stdSn}", function(result) {

            for(let i = 0; i < result.length; i++) {
                console.log(result[i]);
            }

            if(result == null || result.length == 0) {
                $('#attendList').html("");
                return;
            }

            let str = "";

            for(let i = 0; i < result.length; i++) {
                str += '<li>';
                str += '<div class="attendCard">';
                str += '<img src="../../../resources/img/img_avatar2.png" alt="Avatar" class="avatar">';
                str += '<strong> ' + result[i].userName + '</strong>';

                if("${representation}" === result[i].userId) str += '<span style="color:gray;"> 스터디장</span>';

                if(result[i].grpRole === 'GRRO01') str += '<span style="color:gray;"> 모임장</span>';
                if(result[i].grpRole === 'GRRO02') str += '<span style="color:gray;"> 운영진</span>';
                if(result[i].grpRole === 'GRRO03') str += '<span style="color:gray;"> 일반회원</span>';

                str += '</div>';

                // 로그인한 사용자가 스터디장이고, 본인이 아닌 사람들만 강퇴 가능
                if("${pinfo.username}" !== "" && "${representation}" === "${pinfo.username}" && "${representation}" !== result[i].userId) {
                    str += '<div class="attendBtn">';
                    str += '<a id ="cancel" class="' + result[i].userId + '" href="">강퇴</a>'
                    str += '<a id = "ban" class="' + result[i].userId + '" href="">영구강퇴</a>'
                    str += '</div>';
                }

                str += '</li>';
            }

            $('#attendList').html(str);
        });
    }


    // 대기멤버 가져오기
    function getWaitingList() {
        studyMemberService.getWaitingList("${stdSn}", function (result) {
            for(let i = 0; i < result.length; i++) {
                console.log(result[i]);
            }

            if(result == null || result.length == 0) {
                $('#waitingList').html("");
                return;
            }

            let str = "";

            for(let i = 0; i < result.length; i++) {
                str += '<li>';
                str += '<div class="attendCard">';
                str += '<img src="../../../resources/img/img_avatar2.png" alt="Avatar" class="avatar">';
                str += '<strong> ' + result[i].userName + '</strong>';

                if(result[i].grpRole === 'GRRO01') str += '<span style="color:gray;"> 모임장</span>';
                if(result[i].grpRole === 'GRRO02') str += '<span style="color:gray;"> 운영진</span>';
                if(result[i].grpRole === 'GRRO03') str += '<span style="color:gray;"> 일반회원</span>';

                str += '</div>';

                str += '<div class="attendBtn">';
                str += '<a id ="getAnswer" href="" style="color: blue;">답변보기</a>';
                str += '</div>';
                str += '</li>';
            }

            $('#waitingList').html(str);
        })
    }
</script>


<script>
    $('#attendList').on("click", "li", function(e) {
        e.preventDefault();

        console.log("userId = " + e.target.className);
        console.log("userId = " + e.target.id);

        let userId = e.target.className;
        let method = e.target.id;

        if(method === 'cancel') {
            if (confirm("해당 회원을 정말로 강퇴하겠습니까?")) {
                studyAttendService.cancel({stdSn : ${stdSn}, userId : userId}, function(result) {

                    if(result === 'success') {
                        alert('해당 회원을 성공적으로 강퇴시켰습니다.');
                        getAttendList();

                    }else if (result === 'fail') {
                        alert('해당 회원을 강퇴시키지 못했습니다.');
                    }
                })
            }
        } else if(method === 'ban') {
            if (confirm("해당 회원을 정말로 영구탈퇴시키겠습니까? (해당 회원은 다시 스터디에 참석할 수 없습니다.)")) {
                studyAttendService.ban({stdSn : ${stdSn}, userId : userId}, function(result) {

                    if(result === 'success') {
                        alert('해당 회원을 성공적으로 강퇴시켰습니다.');
                        getAttendList();

                    }else if (result === 'fail') {
                        alert('해당 회원을 강퇴시키지 못했습니다.');
                    }
                })
            }
        }


    })
</script>