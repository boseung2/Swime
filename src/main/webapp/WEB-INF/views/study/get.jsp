<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

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
            <span>${fn:substring(startDate,0,10)} ~ ${fn:substring(endDate,0,10)}</span>
        </div>
        <!-- /.col-lg-8 -->
        <div class="col-lg-5">
            <form id="operForm" action="group/modify" method="get">
                <input type="hidden" id="sn" name="sn" value="<c:out value="${group.sn}"/>">
            </form>
            <h1 class="font-weight-light"><c:out value="${group.name}"/></h1>
            <p>모임장 : ${study.representationName}</p>
            <p>${study.attendants} / ${study.capacity}</p>
            <c:if test="${study.onOff eq 'STOF01'}"><p>온라인 스터디</p></c:if>
            <c:if test="${study.onOff eq 'STOF02'}"><p>오프라인 스터디</p></c:if>
            <p>${study.expense}</p>

            <c:if test="${wish == null}"><a class="btn btn-primary" href="#">❤</a></c:if>
            <c:if test="${wish != null}"><a class="btn btn-primary" href="#">♡</a></c:if>

            <c:choose>
                <c:when test="${study.attendants >= study.capacity}"><a class="btn btn-primary" href="#">모집마감</a></c:when>
                <c:when test="${study.representation == studyParam.userId}"></c:when>
                <c:when test="${attend.status eq 'STUS01'}"><a class="btn btn-primary" href="#">탈퇴하기</a></c:when>
                <c:when test="${attend.status eq 'STUS02'}"><a class="btn btn-primary" href="#">참석하기</a></c:when>
                <c:when test="${attend.status eq 'STUS03'}"><a class="btn btn-primary" href="#">검토중</a></c:when>
                <c:when test="${attend.status eq 'STUS04'}"><a class="btn btn-primary" href="#">가입불가</a></c:when>
                <c:otherwise><a class="btn btn-primary" href="#">참석하기</a></c:otherwise>
            </c:choose>

            <br><br>
<%--            <c:if test="${study.representation eq param.userId}">--%>
            <a class="btn btn-primary" href="/study/modify?sn=${study.sn}">스터디 수정</a>
            <a class="remove btn btn-primary" href="#">스터디 삭제</a>
            <br><br>
            <a class="btn btn-primary" href="#">참가 신청 마감</a>
            <a class="btn btn-primary" href="/study/members?stdSn=${study.sn}">멤버 관리</a>
            <a class="btn btn-primary" href="#">참여멤버와 채팅</a>
            <br><br>
            <a class="list btn btn-primary" href="">스터디 목록</a>
<%--            </c:if>--%>
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

    <div id="info">
        <h4> 정보</h4>
        <p>${study.information}</p>
    </div>

    <div id="member">
        <h4> 참여멤버</h4>

        <c:forEach items="${members}" var="member">
            <img src="../../../resources/image/img_avatar2.png" alt="Avatar" class="avatar">
            <span>${member.userName}</span>
            <c:if test="${member.userId eq study.representation}"><span>스터디장</span></c:if>
            <span>${member.grpRole}</span>
            <br>
        </c:forEach>
    </div>

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

    <form id="actionForm" action="/study/list" method="get">
        <input type="hidden" name="pageNum" value="${cri.pageNum}">
        <input type="hidden" name="amount" value="${cri.amount}">
        <input type="hidden" name="grpSn" value="${study.grpSn}">
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
    </form>


</div>

<script type="text/javascript">

    $(document).ready(function(){

        <!-- 스터디 생성/수정 후 모달 창-->
        let result = '<c:out value="${result}"/>';

        checkModal(result);

        history.replaceState({}, null, null);


        function checkModal(result) {
            if(result === '' || history.state) {
                return;
            }

            if(parseInt(result) > 0) {
                $(".modal-body").html("스터디 " + parseInt(result) + "번이 정상적으로 처리되었습니다.");
            }

            $("#myModal").modal("show");
        }

        <!-- 스터디 목록 버튼 눌렸을 때-->
        let actionForm = $("#actionForm");

        $(".list").on("click", function(e) {
            e.preventDefault();
            actionForm.submit();
        });

        <!-- 스터디 삭제 버튼 눌렀을 때-->
        $(".remove").on("click", function(e) {
            e.preventDefault();

            actionForm.append("<input type='hidden' name='sn' value='" + ${study.sn} + "'>");
            actionForm.attr("action", "/study/remove");
            actionForm.attr("method", "post");
            actionForm.submit();
        });
    });
</script>

<%@include file="../includes/footer.jsp" %>