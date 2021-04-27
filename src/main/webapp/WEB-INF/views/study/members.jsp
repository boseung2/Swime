<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@include file="../includes/header.jsp" %>

<h2>멤버 관리</h2>

<!-- nav -->
<div class="topnav" style="margin-bottom: 10px;">
    <a href="#member" class="active">참여 멤버</a>
    <a href="#waitingMember">승인 대기 멤버</a>
</div>
<!-- /nav -->

<div id="member">
</div>

<div id="waitingMember">
</div>

<%@include file="../includes/footer.jsp" %>

<script type="text/javascript" src="/resources/js/studyMember.js"></script>

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
                $('#member').html("");
                return;
            }

            let str = "";

            for(let i = 0; i < result.length; i++) {
                str += '<ul>';
                str += '<li>';
                str += '<div class="attendCard">';
                str += '<img src="../../../resources/img/img_avatar2.png" alt="Avatar" class="avatar">';
                str += '<strong> ' + result[i].userName + '</strong>';

                if(result[i].grpRole === 'GRRO01') str += '<span style="color:gray;"> 모임장</span>';
                if(result[i].grpRole === 'GRRO02') str += '<span style="color:gray;"> 운영진</span>';
                if(result[i].grpRole === 'GRRO03') str += '<span style="color:gray;"> 일반회원</span>';

                str += '</div>';

                str += '<div class="attendBtn">';
                str += '<a id ="cancel" href="">강퇴</a>'
                str += '<a id = "ban" href="">영구강퇴</a>'
                str += '</div>';
                str += '</li>';
                str += '</ul>';
            }

            $('#member').html(str);
        });
    }


    // 대기멤버 가져오기
    function getWaitingList() {
        studyMemberService.getWaitingList("${stdSn}", function (result) {
            for(let i = 0; i < result.length; i++) {
                console.log(result[i]);
            }

            if(result == null || result.length == 0) {
                $('#waitingMember').html("");
                return;
            }

            let str = "";

            for(let i = 0; i < result.length; i++) {
                str += '<ul>';
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
                str += '</ul>';
            }

            $('#waitingMember').html(str);
        })
    }
</script>