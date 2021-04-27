<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="../includes/header.jsp" %>

<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
<style type="text/css">
    #map {
        width : 100%;
        height: 400px;
    }

    html,
    body {
        height: 100%;
        margin: 0;
        padding: 0;
    }
</style>

<!-- Page Content -->
<div class="container">

    <c:set var="startDate" value="${study.startDate}"/>
    <c:set var="endDate" value="${study.endDate}"/>
    <c:set var="startTime" value="${study.startTime}"/>
    <c:set var="endTime" value="${study.endTime}"/>

    <!-- Heading Row -->
    <div class="row align-items-center my-5">
        <div class="col-lg-7">

            <h1>${study.name}</h1><br>
            <c:if test="${study.repeatCycle eq 'STCY01'}"><span>매주</span></c:if>
            <c:if test="${study.repeatCycle eq 'STCY02'}"><span>격주</span></c:if>
            <c:if test="${study.repeatCycle eq 'STCY03'}"><span>매월</span></c:if>

            <c:if test="${study.repeatDay != null}"><span>${study.repeatDay}</span></c:if>
            <br>
            <span><i class="fas fa-clock"></i> 시간 : ${fn:substring(startTime,0,5)} ~ ${fn:substring(endTime,0,5)}</span>
            <br>
            <c:if test="${endDate != null}"><span><i class="fas fa-calendar-alt"></i> 날짜 : ${fn:substring(startDate,0,10)} ~ ${fn:substring(endDate,0,10)}</span></c:if>
            <c:if test="${endDate == null}"><span><i class="fas fa-calendar-alt"></i> 날짜 : ${fn:substring(startDate,0,10)}</span></c:if>
        </div>
        <!-- /.col-lg-8 -->
        <div class="col-lg-5">
            <p><i class="fas fa-user"></i> 스터디장 : ${study.representationName}</p>
            <p><i class="fas fa-users"></i> 참여인원 : ${study.attendants} / ${study.capacity}</p>
            <c:if test="${study.onOff eq 'STOF01'}"><p><i class="fas fa-video"></i>온라인 스터디</p></c:if>
            <c:if test="${study.onOff eq 'STOF02'}"><p><i class="fas fa-map-marker-alt"></i> 오프라인 스터디</p></c:if>

            <c:choose>
                <c:when test="${study.expense == '(선택)'}"></c:when>
                <c:when test="${study.expense == '없음' || study.expense =='추후공지'}"><p><i class="fas fa-won-sign"></i> 지참금 : ${study.expense}</p></c:when>
                <c:otherwise><p><i class="fas fa-won-sign"></i> 지참금 : ${study.expense}원</p></c:otherwise>
            </c:choose>


            <div class="wishButton" style="width: max-content; height: max-content"></div>

            <c:if test="${study.representation != pinfo.username}">
                <c:choose>
                    <c:when test="${pinfo.username == null && study.attendants >= study.capacity}"><span class="btn btn-primary">모집마감</span></c:when>
                    <c:otherwise><div id="attendButton" style="width: max-content; height: max-content"></div></c:otherwise>
                </c:choose>
            </c:if>

            <br>
            <c:if test="${study.representation eq pinfo.username}">
                <a class="modify btn btn-primary" href="">스터디 수정</a>
                <a class="remove btn btn-primary" href="">스터디 삭제</a>
                <a class="btn btn-primary" href="/study/members?stdSn=${study.sn}&representation=${study.representation}">멤버 관리</a>
                <br><br>
<%--            <a class="btn btn-primary" href="#">참가 신청 마감</a>--%>
<%--            <a class="btn btn-primary" href="#">참여멤버와 채팅</a>--%>
<%--            <br><br>--%>
            </c:if>

            <a class="list btn btn-primary" href="">그룹으로 돌아가기</a>
            <br>
        </div>
        <!-- /.col-md-4 -->
    </div>
    <!-- /.row -->

    <!-- nav -->
    <div class="topnav">
        <a href="#info" class="active">정보</a>
        <a href="#member">참여멤버</a>
        <c:if test="${study.onOff eq 'STOF01'}"><a href="#onOff">온라인 링크</a></c:if>
        <c:if test="${study.onOff eq 'STOF02'}"><a href="#onOff">장소</a></c:if>
    </div>
    <!-- /nav -->

    <!-- topnav javascript -->
    <script>
        let topnav = document.getElementsByClassName("topnav")[0];
        let sticky = topnav.offsetTop;

        $(document).ready(function() {
            $('.topnav').on("click", "a", function(e) {
                $(".topnav > a").removeClass('active');
                console.dir(e.target);
                $(this).attr("class", "active");
            })
        })

        // window.onscroll = function() {myFunction()};
        //
        // function myFunction() {
        //     if(window.pageYOffset >= sticky) {
        //         topnav.classList.add("sticky");
        //     } else {
        //         topnav.classList.remove("sticky");
        //     }
        // }
    </script>

    <div class="main-contents">
    <div id="info">
        <h4> 정보</h4>
        <pre>${study.information}</pre>
    </div>
    <br>

    <hr class="centerHr">
    <div id="member">
        <h4> 참여멤버</h4>

        <c:forEach items="${members}" var="member">
            <img src="../../../resources/img/img_avatar2.png" alt="Avatar" class="avatar">
            <strong>${member.userName}</strong>
            <c:if test="${member.userId eq study.representation}"><span>스터디장</span></c:if>
            <c:choose>
                <c:when test="${member.grpRole == 'GRRO01'}">모임장</c:when>
                <c:when test="${member.grpRole == 'GRRO02'}">운영진</c:when>
                <c:when test="${member.grpRole == 'GRRO03'}">일반회원</c:when>
            </c:choose>
            <br>
        </c:forEach>
    </div>

    <hr class="centerHr">
    <div id="onOff">
        <c:if test="${study.onOff eq 'STOF01'}">
            <h4>온라인 스터디 링크</h4>
            <p><a href="${study.onUrl}">바로가기</a></p>
        </c:if>

        <c:if test="${study.onOff eq 'STOF02'}">
            <h4>장소</h4>
            <div id="map"></div>
        </c:if>
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


</div>

<script type="text/javascript" src="/resources/js/studyWish.js"></script>
<script type="text/javascript" src="/resources/js/studyAttend.js"></script>
<script type="text/javascript">

    $(document).ready(function(){
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

        let wishUL = $('.wishButton');

        if(userId !== '') { // 로그인 되어있으면

            // 찜버튼 출력
            getStudyWish();

            // 참석버튼 출력
            getStudyAttend();
        }

        <!-- 참석버튼 출력 -->
        function getStudyAttend() {
            studyAttendService.get({grpSn : grpSn, stdSn : stdSn, userId : userId}, function(result) {
                console.log("getStudyAttend > result = " + result);

                let str = "";

                if(result === "group not attend") {
                    str += "";

                } else if(result === "not attend"){
                    str += "<a id='attend' class='btn btn-primary' href=''>참석하기</a>";

                } else if(result === "attend"){
                    str += "<a id='cancel' class='btn btn-danger' href=''>탈퇴하기</a>";

                } else if(result === "waiting"){
                    str += "<a class='btn btn-primary'>검토중</a>";

                } else if(result === "kicked"){
                    str += "<a class='btn btn-danger'>가입불가</a>";

                } else if(result === "fail"){
                    alert('가입상태를 불러오는데 실패하였습니다.');
                }

                $('#attendButton').html(str);
            })
        }

        <!-- 참석 버튼 눌렀을 때-->
        $('#attendButton').on("click", function(e) {
            e.preventDefault();

            // 참석 div안의 a태그의 id가 attend이면 참석을 수행하는 ajax 호출
            if($('#attendButton').children()[0].id === 'attend') {
                console.log('참석');
                studyAttendService.attend({stdSn : stdSn, userId : userId}, function(result) {
                    console.log("attend > result = " + result);

                    if(result === "success") {
                        alert("스터디에 참석했습니다.");
                    }else if(result === "fail") {
                        alert("스터디에 참석하지 못했습니다.");
                    }

                    // 참석버튼 reload
                    getStudyAttend();
                })


            } else if($('#attendButton').children()[0].id === 'cancel') {
                // cancel이면 탈퇴를 수행하는 ajax 호출
                console.log('탈퇴');
                studyAttendService.cancel({stdSn : stdSn, userId : userId}, function(result) {
                    console.log("cancel > result = " + result);

                    if(result === "success") {
                        alert("스터디를 탈퇴했습니다.");
                    }else if(result === "fail") {
                        alert("스터디를 탈퇴하지 못했습니다.");
                    }

                    // 참석버튼 reload
                    getStudyAttend();
                })
            }

        });

        <!--찜 버튼 출력-->
        function getStudyWish() {

            studyWishService.getWish({stdSn : stdSn, userId : userId}, function(result) {
                console.log("getWish > result = " + result);

                let str = "";

                if(result === "not exist") {
                    str += "<a class='wish btn btn-outline-primary' href=''>♡</a>";
                } else {
                    str += "<a class='wish btn btn-outline-primary' href=''>❤</a>";
                }

                wishUL.html(str);
            })
        }

        <!--찜 버튼 눌렀을 때-->
        $(".wishButton").on("click", function(e) {
            e.preventDefault();

            studyWishService.wish({stdSn : stdSn, userId : userId}, function(result) {
                console.log("찜버튼 눌린 result = " + result);

                let str = "";

                if(result === "wish") {
                    alert("스터디를 찜했습니다.");
                }else if(result === "cancelWish"){
                    alert("스터디를 찜을 취소했습니다.");
                }else if(result === "fail") {
                    alert("찜 서비스가 실패했습니다.")
                }

                wishUL.html(str);

                getStudyWish();
            })
        });

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
                case "register error" :
                    $(".modal-body").html("스터디가 등록을 실패하였습니다.");
                    break;
                case "update" :
                    $(".modal-body").html("스터디가 정상적으로 수정되었습니다.");
                    break;
                case "update error" :
                    $(".modal-body").html("스터디 수정을 실패하였습니다.");
                    break;
                case "wish" :
                    $(".modal-body").html("스터디를 찜했습니다.");
                    break;
                case "cancelWish" :
                    $(".modal-body").html("스터디 찜이 취소되었습니다.");
                    break;
                case "attend" :
                    $(".modal-body").html("참석 완료되었습니다.");
                    //참석 버튼을 탈퇴버튼으로 바꾸기
                    break;
                case "failAttend" :
                    $(".modal-body").html("참석 실패하였습니다.");
                    break;
                case "cancelAttend" :
                    $(".modal-body").html("참석 취소되었습니다.");
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

<%@include file="../includes/footer.jsp" %>