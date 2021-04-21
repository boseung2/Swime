<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="../includes/header.jsp" %>

<!-- Page Content -->
<div class="container">

    <c:set var="startDate" value="${study.startDate}"/>
    <c:set var="endDate" value="${study.endDate}"/>
    <c:set var="startTime" value="${study.startTime}"/>
    <c:set var="endTime" value="${study.endTime}"/>

    <!-- Heading Row -->
    <div class="row align-items-center my-5">
        <div class="col-lg-7">

            <h3>${study.name}</h3>
            <c:if test="${study.repeatCycle eq 'STCY01'}"><span>매주</span></c:if>
            <c:if test="${study.repeatCycle eq 'STCY02'}"><span>격주</span></c:if>
            <c:if test="${study.repeatCycle eq 'STCY03'}"><span>매월</span></c:if>

            <c:if test="${study.repeatDay != null}"><span>${study.repeatDay}</span></c:if>
            <br>
            <span>${fn:substring(startTime,0,5)} ~ ${fn:substring(endTime,0,5)}</span>
            <br>
            <c:if test="${endDate != null}"><span>${fn:substring(startDate,0,10)} ~ ${fn:substring(endDate,0,10)}</span></c:if>
            <c:if test="${endDate == null}"><span>${fn:substring(startDate,0,10)}</span></c:if>
        </div>
        <!-- /.col-lg-8 -->
        <div class="col-lg-5">
            <h1 class="font-weight-light"><c:out value="${group.name}"/></h1>
            <p>스터디장 : ${study.representationName}</p>
            <p>${study.attendants} / ${study.capacity}</p>
            <c:if test="${study.onOff eq 'STOF01'}"><p>온라인 스터디</p></c:if>
            <c:if test="${study.onOff eq 'STOF02'}"><p>오프라인 스터디</p></c:if>
            <p>${study.expense}</p>

            <div class="wishButton"></div>

            <c:if test="${study.representation != pinfo.username}">
                <c:choose>
                    <c:when test="${study.attendants >= study.capacity}"><span class="btn btn-primary">모집마감</span></c:when>
<%--                    <c:when test="${attend.status eq 'STUS01'}"><a class="cancelAttend btn btn-primary" href="">참석 취소하기</a></c:when>--%>
<%--                    <c:when test="${attend.status eq 'STUS03'}"><a class="btn btn-primary" href="#">검토중</a></c:when>--%>
<%--                    <c:when test="${attend.status eq 'STUS04'}"><a class="btn btn-primary" href="#">가입불가</a></c:when>--%>
<%--                    <c:otherwise><a class="attend btn btn-primary" href="">참석하기</a></c:otherwise>--%>
                </c:choose>
            </c:if>

            <br><br>
            <c:if test="${study.representation eq pinfo.username}">
            <a class="modify btn btn-primary" href="">스터디 수정</a>
            <a class="remove btn btn-primary" href="">스터디 삭제</a>
<%--            <br><br>--%>
<%--            <a class="btn btn-primary" href="#">참가 신청 마감</a>--%>
<%--            <a class="btn btn-primary" href="/study/members?stdSn=${study.sn}">멤버 관리</a>--%>
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
            <p>구글맵</p>
            <p>${study.placeId}</p>
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
                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
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
<script type="text/javascript">

    $(document).ready(function(){

        let stdSn = ${study.sn};
        let userId = "${pinfo.username}";
        console.log("userId = " + userId);
        console.log("userId type = " + typeof(userId));
        let wishUL = $('.wishButton');

        if(userId !== '') {
            console.log("userId 널아님");
            getStudyWish();
        }

        <!--찜 버튼 출력-->
        function getStudyWish() {

            studyWishService.getWish({stdSn : stdSn, userId : userId}, function(result) {
                console.log("get > getWish > result = " + result);

                let str = "";

                if(result === "not exist") {
                    str += "<a class='wish btn btn-primary' href=''>♡</a>";
                }else {
                    str += "<a class='wish btn btn-primary' href=''>❤</a>";
                }

                wishUL.html(str);
            })
        }

        <!--찜 버튼 눌렸을 때-->
        $(".wish").on("click", function(e) {
            e.preventDefault();

            studyWishService.wish({stdSn : stdSn, userId : userId}, function(result) {
                console.log("get > wish > result = " + result);

                let str = "";

                //성공시 모달창 띄우기

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

            actionForm.append("<input type='hidden' name = 'sn' value='" + ${study.sn} + "'>");
            actionForm.append("<input type='hidden' name = 'representation' value='${study.representation}'>");
            actionForm.attr("action", "/study/remove");
            actionForm.attr("method", "post");
            actionForm.submit();
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

<%@include file="../includes/footer.jsp" %>