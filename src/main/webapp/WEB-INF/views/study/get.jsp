<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="../includes/header.jsp" %>

<style>
    #attendants a {
        margin-left: 10px;
        color : #007bff;
    }

    #onOff a {
        color : #007bff;
    }
</style>

<!-- container -->
<div class="container">
    <c:set var="startDate" value="${study.startDate}"/>
    <c:set var="endDate" value="${study.endDate}"/>
    <c:set var="startTime" value="${study.startTime}"/>
    <c:set var="endTime" value="${study.endTime}"/>

    <!-- Heading Row -->
    <div class="row align-items-center my-5" id="study-get-header">
        <div class="col-lg-7" style="padding-left: 5rem;">

            <h2>${study.name}</h2><br>

            <fmt:parseDate value="${startDate}" var = "sd" pattern="yyyy-MM-dd"/>
            <fmt:formatDate value="${sd}" pattern="E" var="startDay"/>

            <c:if test="${endDate != startDate}">
                <fmt:parseDate value="${endDate}" var = "ed" pattern="yyyy-MM-dd"/>
                <fmt:formatDate value="${ed}" pattern="E" var="endDay"/>

                <span><i class="fas fa-calendar-alt"></i> 날짜 : ${fn:substring(startDate,0,10)} (${startDay}) ~ ${fn:substring(endDate,0,10)} (${endDay})</span>
            </c:if>

            <c:if test="${endDate == startDate}">
                <span><i class="fas fa-calendar-alt"></i> 날짜 : ${fn:substring(startDate,0,10)} (${startDay})</span>
            </c:if>
            <br>

            <span><i class="fas fa-clock"></i> 시간 : ${fn:substring(startTime,0,5)} ~ ${fn:substring(endTime,0,5)}</span>


            <br>
            <c:if test="${study.repeatCycle eq 'STCY01'}"><span>매주</span></c:if>
            <c:if test="${study.repeatCycle eq 'STCY02'}"><span>격주</span></c:if>
            <c:if test="${study.repeatCycle eq 'STCY03'}"><span>매월</span></c:if>

            <c:if test="${study.repeatDay != null}"><span>${study.repeatDay}</span></c:if>
        </div>
        <!-- /.col-lg-8 -->
        <div class="col-lg-5" style="padding-left: 5rem;
">
            <p><i class="fas fa-user"></i> 스터디장 : ${study.representationName}</p>

            <div id = "capacity">
            </div>

            <c:if test="${study.onOff eq 'STOF01'}"><p><i class="fas fa-video"></i> 온라인 스터디 </p></c:if>
            <c:if test="${study.onOff eq 'STOF02'}"><p><i class="fas fa-map-marker-alt"></i> 오프라인 스터디 </p></c:if>

            <c:choose>
                <c:when test="${study.expense == '없음' || study.expense =='추후공지'}"><p><i class="fas fa-won-sign"></i> 지참금 : ${study.expense}</p></c:when>
                <c:when test="${study.expense != null}"><p><i class="fas fa-won-sign"></i> 지참금 : ${study.expense}원</p></c:when>
            </c:choose>

        </div>
        <!-- /.col-md-4 -->
    </div>
    <!-- /.row -->
</div>
<!-- /container -->

<!-- 버튼들 -->
<div class="container study-buttons">
    <div class="wishButton" style="display: inline"></div>

    <c:if test="${study.representation != pinfo.username}">
        <div id="attendButton" style="width: max-content; height: max-content"></div>
    </c:if>

    <c:if test="${study.representation eq pinfo.username}">
        <a class="modify btn btn-secondary" href="">스터디 수정</a>
        <a class="remove btn btn-danger" href="">스터디 삭제</a>
        <a class="btn btn-primary" href="/study/members?pageNum=${cri.pageNum}&amount=${cri.amount}&stdSn=${study.sn}&representation=${study.representation}">멤버 관리</a>
        <%--            <a class="btn btn-primary" href="#">참가 신청 마감</a>--%>
        <%--            <a class="btn btn-primary" href="#">참여멤버와 채팅</a>--%>
        <%--            <br><br>--%>
    </c:if>

    <a class="list btn btn-primary" href="">그룹으로 돌아가기</a>
</div>

<!-- Page Content -->
<div class="gray-background">
    <!-- nav -->
    <div class="topnav" STYLE="position: sticky;
    top: 0;
    transition: background-color 0.5s ease 0s;
    ">
        <a href="#info" class="active">스터디 정보</a>
        <c:if test="${study.onOff eq 'STOF01'}"><a href="#onOff">온라인 링크</a></c:if>
        <c:if test="${study.onOff eq 'STOF02'}"><a href="#onOff">장소</a></c:if>
    </div>
    <!-- /nav -->
<div class="container">

    <div class="main-contents get-body">

        <div id="groupAttend">
            <div id = "attendants">
            </div>
            <ul id="member">
            </ul>
        </div>

        <hr class="centerHr">

        <div id="info">
            <h4> 스터디 정보</h4>
            <pre>${study.information}</pre>
        </div>

        <hr class="centerHr">
        <div id="study-place">
            <div id="onOff">
                <c:if test="${study.onOff eq 'STOF01'}">
                    <h4>온라인 스터디 링크</h4>
                    <a href="${study.onUrl}">바로가기</a>
                </c:if>

                <c:if test="${study.onOff eq 'STOF02'}">
                    <h4>장소</h4>
                    <div id="map"></div>
                </c:if>
            </div>
        </div>
    </div>
    <hr style="margin: 2rem; border-top: 1px solid #f1f1f1;">
</div>




<!-- 스터디 생성/수정 확인 모달 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">정상적으로 처리되었습니다.</div>
            <div class = "modal-footer">
<%--                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>--%>
                <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>

<form id="actionForm" action="" method="get">
    <input type="hidden" name="pageNum" value="${cri.pageNum}">
    <input type="hidden" name="amount" value="${cri.amount}">
    <input type="hidden" name="grpSn" value="${study.grpSn}">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
</form>

<!-- 설문 등록 모달창 -->
<div class="surveyModal modal fade" id="surveyModal" tabindex="-1" role="dialog" aria-labelledby="surveyModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="surveyModalLabel">스터디 설문 등록</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body"><span style="color: gray; font-size: small">스터디 참석을 위한 정보를 입력해주세요.</span></div>
                <div class="questionForm form-group" hidden="true">
                    <strong><label style="padding-left: 16px;">질문 1. </label></strong>
                    <p class="questionLabel" style="padding-left: 16px;"></p>
                    <input style="width:465px;margin-left: 16px;" class="form-control answer">
                </div>
                <div class="questionForm form-group" hidden="true">
                    <strong><label style="padding-left: 16px;">질문 2. </label></strong>
                    <p class="questionLabel" style="padding-left: 16px;"></p>
                    <input style="width:465px;margin-left: 16px;" class="form-control answer">
                </div>
                <div class="questionForm form-group" hidden="true">
                    <strong><label style="padding-left: 16px;">질문 3. </label></strong>
                    <p class="questionLabel" style="padding-left: 16px;"></p>
                    <input style="width:465px;margin-left: 16px;" class="form-control answer">
                </div>
            <div class = "modal-footer">
                <button id= "surveyRegisterBtn" type="button" class="btn btn-primary">등록</button>
                <button id= "surveyCloseBtn" type="button" class="btn btn-default" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>


<script type="text/javascript" src="/resources/js/studyWish.js"></script>
<script type="text/javascript" src="/resources/js/studyAttend.js"></script>
<script type="text/javascript" src="/resources/js/studySurvey.js"></script>
<script type="text/javascript" src="/resources/js/studyAnswer.js"></script>
<script type="text/javascript" src="/resources/js/studyMember.js"></script>
<script type="text/javascript" src="/resources/js/study.js"></script>

<!-- 참여멤버 불러오기 -->
<script>
    $(document).ready(function() {

        // 참여인원 / 모집인원 불러오기
        getCapacity();

        // 참여멤버 불러오기
        getAttendList();

    })
</script>

<script>
    // 참여멤버 불러오는 함수 (10명만 불러옴)
    function getAttendList() {
        studyMemberService.getAttendListWithPaging(${study.sn}, function(result){

            if(result.length > 0) {

                console.log(result);

                let str  = '';

                for(let i = 0 ; i < result.length; i++) {

                    str += '<li>';

                    if(result[i].picture !== null && result[i].picture !== 'myPicture.jpeg') {
                        str += '<img src="' + '/display?fileName=' + result[i].picture.replace('s_', '') + '" alt="Avatar" class="avatar">';
                    }else {
                        str += '<img src="https://image.flaticon.com/icons/png/512/3237/3237472.png" alt="Avatar" class="avatar">';
                    }

                    // str += '<img src="../../../resources/img/img_avatar2.png" alt="Avatar" class="avatar">';
                    str += '<strong> ' + result[i].userName + '</strong>';
                    if ("${study.representation}" === result[i].userId) str += '<span> 스터디장</span>';
                    if ("GRRO01" === result[i].grpRole) str += '<span> 모임장</span>';
                    if ("GRRO02" === result[i].grpRole) str += '<span> 운영진</span>';
                    if ("GRRO03" === result[i].grpRole) str += '<span> 일반회원</span>';


                    // 로그인되어있으며, 해당사용자가 아니면 채팅버튼 띄우기

                    // console.log("window.location.protocol = " + window.location.protocol);
                    // console.log("domain = " + window.location.host);

                    if("${pinfo.username}" !== "" && result[i].userId !== "${pinfo.username}") {
                        str += '<div style="float:right">';
                        str += '<a href="http://' + window.location.host + '/chat/register?userId=' + result[i].userId + '">';
                        str += '<img src="../../../resources/img/chat.png" class="listChatBtn">';
                        str += '</a>';
                        str += '</div>';
                    }

                    str += '</li>';

                }

                $('#member').html(str);
            }

        })
    }
</script>

<script>
    // 참여인원 / 모집인원 불러오는 함수
    function getCapacity() {
        studyService.get(${study.sn}, function(result){

            let str = '';

            str += '<p><i class="fas fa-users"></i> 참여인원 : ' +  result.attendants  + ' / '  + result.capacity + '</p>';

            $('#capacity').html(str);

            // 참여멤버 제목 구성
            let str2 = '<div style="margin-bottom: 30px"><h4 style="display:inline;">참여멤버 (' + result.attendants + '명)</h4>';
            str2 += '<a href="/study/members?pageNum=${cri.pageNum}&amount=${cri.amount}&stdSn=${study.sn}&representation=${study.representation}"> 모두 보기</a></div>';

            $('#attendants').html(str2)
        })
    }
</script>

<script type="text/javascript">

    $(document).ready(function(){

        // post, ajax 시큐리티 적용
        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        // ajax spring security header
        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        });

        let stdSn = ${study.sn};
        let userId = "${pinfo.username}"; // 로그인중인 id
        let grpSn = ${study.grpSn};

        console.log("grpSn = " + grpSn);
        console.log("userId = " + userId);
        console.log("stdSn = " + stdSn);

        if(userId !== '') { // 로그인 되어있으면

            // 찜버튼 출력
            getStudyWish();

            // 참석버튼 출력
            getStudyAttendBtn();
        }

        <!-- 스터디 생성/수정/찜/찜 삭제 후 모달 창-->
        let result = '<c:out value="${result}"/>';

        checkModal(result);

        function checkModal(result) {

            console.log("checkModal")
            console.log("checkModal result= " + result);

            if(result === '') {
                return;
            }

            switch (result) {
                case "register" :
                    $(".modal-body").html("스터디가 정상적으로 등록되었습니다.");
                    break;
                case "update" :
                    $(".modal-body").html("스터디가 정상적으로 수정되었습니다.");
                    break;
            }

            $("#myModal").modal("show");
        }

        <!-- 그룹으로 돌아가기 버튼 눌렸을 때-->
        let actionForm = $("#actionForm");

        $(".list").on("click", function(e) {
            e.preventDefault();
            actionForm.attr("action", "/group/get")
            actionForm.find("input[name='grpSn']").remove();
            actionForm.append("<input type='hidden' name = 'sn' value='" + ${study.grpSn} + "'>");
            actionForm.submit();
        });

        <!-- 스터디 삭제 버튼 눌렀을 때-->
        $(".remove").on("click", function(e) {
            e.preventDefault();

            if (confirm('글을 삭제하시겠습니까?')) {

                actionForm.append("<input type='hidden' name = 'sn' value='" + ${study.sn} + "'>");
                actionForm.append("<input type='hidden' name = 'representation' value='${study.representation}'>");
                actionForm.attr("action", "/study/remove");
                actionForm.attr("method", "post");
                actionForm.submit();
            }

        });

        <!-- 스터디 수정 버튼 눌렀을 때-->
        $(".modify").on("click", function(e) {
            e.preventDefault();

            actionForm.append("<input type='hidden' name = 'sn' value='" + ${study.sn} + "'>");
            actionForm.append("<input type='hidden' name = 'representation' value='${study.representation}'>");
            actionForm.attr("action", "/study/modify");
            actionForm.attr("method", "get");
            actionForm.submit();
        });

    });

</script>


<!-- 찜 버튼 처리-->
<script>
    // 찜버튼 출력 함수
    function getStudyWish() {

        studyWishService.getWish({stdSn : ${study.sn}, userId : "${pinfo.username}"}, function(result) {
            console.log("getWish > result = " + result);

            let str = "";

            if(result === "not exist") {
                str += "<a class='wish btn btn-outline-primary' href=''>♡</a>";
            } else {
                str += "<a class='wish btn btn-primary' href=''>♡</a>";
            }

            $('.wishButton').html(str);
        })
    }

    // 찜버튼 눌렀을 때
    $(".wishButton").on("click", function(e) {
        e.preventDefault();

        studyWishService.wish({stdSn : ${study.sn}, userId : "${pinfo.username}"}, function(result) {
            console.log("찜버튼 눌린 result = " + result);

            if(result === "wish") {
                alert("스터디를 찜했습니다.");
            }else if(result === "cancelWish"){
                alert("스터디를 찜을 취소했습니다.");
            }else if(result === "fail") {
                alert("찜 서비스가 실패했습니다.")
            }

            getStudyWish();
        })
    });
</script>


<!-- attend 버튼 처리-->
<script>
    // attend 버튼 출력
    function getStudyAttendBtn() {
        studyAttendService.get({grpSn : ${study.grpSn}, stdSn : ${study.sn}, userId : "${pinfo.username}"}, function(result) {
            console.log("getStudyAttend > result = " + result);

            let str = "";

            // 현재날짜
            let currDate = new Date();

            //시작일자
            let startDate = new Date("${study.startDate}" + " " + "${study.startTime}");

            console.log("현재날짜 = " + currDate);
            console.log("시작날짜 = " + startDate);
            console.log("예정스터디 = " + currDate <= startDate);
            console.log("지난스터디 = " + currDate > startDate);

            // 그룹에 속해있지 않거나 시작일자가 현재날짜보다 이전일때
            if(result === "group not attend" || currDate > startDate) {
                // str += "";

            } else if(result === "not attend"){

                // 참여인원과 모집인원을 다시 불러오기
                studyService.get(${study.sn}, function(result){

                    attendants = result.attendants;
                    capacity = result.capacity;

                    if (attendants >= capacity) {

                        str += "<a class='btn btn-dark'>모집마감</a>";
                    }else {
                        str += "<a id='attend' class='btn btn-primary' href=''>참석하기</a>";
                    }

                    $('#attendButton').html(str);
                    return;
                })

            } else if(result === "attend"){
                str += "<a id='cancel' class='btn btn-danger' href=''>탈퇴하기</a>";

            } else if(result === "waiting"){
                str += "<a id ='waiting' class='btn btn-primary' href=''>검토중</a>";

            } else if(result === "kicked"){
                str += "<a class='btn btn-danger'>가입불가</a>";

            } else if(result === "fail"){
                alert('가입상태를 불러오는데 실패하였습니다.');
            }

            $('#attendButton').html(str);
        })
    }

    // attend 버튼 눌렀을 때
    $('#attendButton').on("click", function(e) {
        e.preventDefault();

        // 참석버튼이 눌리면
        if($('#attendButton').children()[0].id === 'attend') {
            console.log('참석');

            // 설문 가져오는 ajax 호출
            studySurveyService.getSurveyList(${study.sn}, function(result) {

                // 해당 스터디에 설문이 있으면
                if(result.length > 0) {
                    for(let i = 0; i < result.length; i++) {

                        // label에 해당 질문을 등록
                        $('.questionLabel')[i].innerText = result[i].question;

                        // 질문 form hidden처리 풀기
                        $('.questionForm')[i].hidden = false;
                    }

                    // 모달 띄우기
                    $('#surveyModal').modal("show");
                }else {

                    // 없으면 바로 참석 진행
                    studyAttendService.attend({stdSn : ${study.sn}, userId : "${pinfo.username}"}, function(result) {
                        console.log("attend > result = " + result);

                        if(result === "success") {

                            alert("스터디에 참석했습니다.");

                            // 참여인원 / 모집인원 불러오기
                            getCapacity();

                            // 참석버튼 reload
                            getStudyAttendBtn();

                            // 참여멤버 불러오기
                            getAttendList();

                        }else if(result === "fail") {
                            alert("스터디에 참석하지 못했습니다.");
                        }
                    })
                }

            })

            // 탈퇴 버튼이 눌리면
        } else if($('#attendButton').children()[0].id === 'cancel') {
            // cancel이면 탈퇴를 수행하는 ajax 호출
            console.log('탈퇴');
            if(confirm('해당 스터디를 탈퇴하시겠습니까?')) {
                studyAttendService.cancel({stdSn : ${study.sn}, userId : "${pinfo.username}"}, function(result) {
                    console.log("cancel > result = " + result);

                    if(result === "success") {
                        alert("스터디를 탈퇴했습니다.");

                        // 참여인원 / 모집인원 불러오기
                        getCapacity();

                        // 참석버튼 reload
                        getStudyAttendBtn();

                        // 참여멤버 불러오기
                        getAttendList();

                    }else if(result === "fail") {
                        alert("스터디를 탈퇴하지 못했습니다.");
                    }
                })
            }

        // 검토중이 눌리면 명단에서 삭제하는 reject ajax 호출
        } else if ($('#attendButton').children()[0].id === 'waiting') {

            if(confirm('스터디장이 승인하면 스터디에 참석됩니다. 그래도 스터디 참석을 취소하겠습니까?')) {
                studyAttendService.reject({stdSn : ${study.sn}, userId : "${pinfo.username}"}, function(result) {
                    console.log("waiting > reject > result = " + result);

                    if(result === "success") { // 검토중인 회원을 명단에서 삭제하고 해당 회원의 설문답변을 모두 삭제함
                        alert("스터디 참석을 취소했습니다.");

                        // 참석버튼 reload
                        getStudyAttendBtn();

                    }else if(result === "fail") {
                        alert("스터디 참석을 취소하지 못했습니다.");
                    }
                })
            }
        }

    });
</script>


<!-- 설문 등록 -->
<script>
    // 설문 등록 버튼 눌리면
    $('#surveyRegisterBtn').on("click", function() {
        console.log("등록 버튼 클릭");

        // 유효성 검사
        let qForms = $('.questionForm');

        for(let i = 0; i < qForms.length; i++){
            if(qForms[i].hidden == false){ // 질문이 존재하고

                if($('.answer')[i].value === '') { // 답변이 없으면
                    alert(i+1 + '번째 답변을 등록해주세요.');
                    return;
                }else if ($('.answer')[i].value.length > 100) {
                    alert(i+1 + '번째 답변 정보가 너무 큽니다. 100자 이내로 작성해주세요.');
                    return;
                }
            }
        }

        // 유효성 검사 통과하면 등록 버튼 눌리면 닫히게하기
        $('#surveyRegisterBtn').attr("data-dismiss", "modal");

        // 답변 배열
        let answerList = [];

        // 답변 input을 모두 돌면서 value가 ""이 아니면 answerList에 추가
        for(let i = 0; i < $('.answer').length; i++) {
            if($('.answer')[i].value === "") break;

            let answer = {
                stdSn : ${study.sn},
                userId : "${pinfo.username}",
                questionSn : i+1,
                question : $('.questionLabel')[i].innerText,
                answer : $('.answer')[i].value
            };

            answerList.push(answer);
        }

        // 콘솔에 답변 출력
        console.log(answerList);

        // ajax에 answerList 보내고 호출
        studyAnswerService.register(answerList, function(result) {
            console.log("result = " + result);

            // 기존에 등록했던 답변을 모달에서 삭제
            for(let i = 0; i < $('.answer').length; i++) {
                $('.answer')[i].value = '';
            }

            if(result === 'success') {

                // console.log("context = " + getContextPath(document.location.href));
                let context = getContextPath(document.location.href);

                // 스터디장에게 참석했다는 알림을 db에 저장하고 실시간 알림 전송
                noticeService.register(
                    {sender : "${pinfo.username}", receiver : "${study.representation}",
                        kind : "스터디", url : context + "/get?sn=${study.sn}", content : "스터디 ${study.name}에 새로운 승인 대기멤버가 있습니다."}, function(notice) {
                        if(notice === 'success') {

                            console.log('알림 등록 완료 완료되었습니다.');
                        }
                    })


                alert('설문을 등록하였습니다. 스터디장이 승인하면 스터디에 참석됩니다.');

                // attend 버튼 reload
                getStudyAttendBtn();
            }else {
                alert('설문을 등록하는데 문제가 발생했습니다. 다시 시도해주세요.');
            }
        })

    })
</script>


<!--구글 맵 -->
<script>
    window.onload = function() {
        if("${study.placeId}" !== "") { // placeId가 null이 아니면 지도 출력
            initMap();
        }
    }
</script>

<script>
    function initMap() {

        const request = {
            placeId: "${study.placeId}",
            fields: ["name", "formatted_address", "place_id", "geometry", "url"],
        };

        // 말풍선
        const infowindow = new google.maps.InfoWindow();
        const service = new google.maps.places.PlacesService(map);

        service.getDetails(request, (place, status) => { // 세부정보 가져오기
            if (
                status === google.maps.places.PlacesServiceStatus.OK &&
                place &&
                place.geometry &&
                place.geometry.location
            ) {

                // 지도
                const map = new google.maps.Map(document.getElementById("map"), {
                    center: place.geometry.location,
                    zoom: 15,
                });

                const marker = new google.maps.Marker({ // 마커 위치 설정
                    map,
                    position: place.geometry.location,
                });

                marker.setVisible(true);

                infowindow.setContent(
                    "<div><strong style='font-weight: bold;'>" + place.name + "</strong><br>" +
                        "<strong style='font-weight: bold;'>주소: </strong><span>" + place.formatted_address + "</span><br>" +
                        "<strong style='font-weight: bold;'>URL: </strong><a href='" + place.url + "'>구글맵 바로가기</a><br>" +
                    "</div>"
                )

                infowindow.open(map, marker);
            }
        });
    }
</script>

<script
    src="https://maps.googleapis.com/maps/api/js?key=${key}&libraries=places&v=weekly"
    async
></script>

<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>

<!-- topnav javascript -->
<script>
    let topnav = document.getElementsByClassName("topnav")[0];
    $(".topnav").css( "padding-left", $(".container")[0].offsetLeft + 15);
    let sticky = topnav.offsetTop;

    $(document).ready(function() {
        $('.topnav').on("click", "a", function(e) {
            $(".topnav > a").removeClass('active');
            console.dir(e.target);
            $(this).attr("class", "active");
        })


    })


    $(window).resize( function() {
        $(".topnav").css( "padding-left", $(".container")[0].offsetLeft + 15);
    })

    window.onscroll = function() {
        myFunction();
    };

    function myFunction() {
        let topnav = $(".topnav")[0];
        if(window.pageYOffset >= topnav.offsetTop) {
            $(".topnav").css("background-color", "white");
            // topnav.classList.add("sticky");
        } else {
            $(".topnav").css("background-color", "#ffffff00");
            // topnav.classList.remove("sticky");
        }
    }
</script>

<%@include file="../includes/footer.jsp" %>