<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@include file="../includes/header.jsp" %>

<style>
    .left {
        float: left;
        background-color: #f1f1f1;
        width: 30%;
        height: 300px;
    }

    .right {
        padding: 0px 12px;
        width: 70%;
        border-left: none;
        height: 300px;
    }
</style>

<c:set var="startDate" value="${study.startDate}"/>
<c:set var="endDate" value="${study.endDate}"/>
<c:set var="startTime" value="${study.startTime}"/>
<c:set var="endTime" value="${study.endTime}"/>

<div class="left">
    <h3>${study.name}</h3>
    <c:if test="${study.repeatCycle eq 'STCY01'}"><span>매주</span></c:if>
    <c:if test="${study.repeatCycle eq 'STCY02'}"><span>격주</span></c:if>
    <c:if test="${study.repeatCycle eq 'STCY03'}"><span>매월</span></c:if>
    <c:if test="${study.repeatDay != null}"><span>${study.repeatDay}</span></c:if>
    <br>
    <span>${fn:substring(startTime,0,5)} ~ ${fn:substring(endTime,0,5)}<span>
    <br>
    <span>${fn:substring(startDate,0,10)} ~ ${fn:substring(endDate,0,10)}</span>
</div>

<div class="right">
    <p>모임장 : ${study.representationName}</p>
    <p>${study.attendants} / ${study.capacity}</p>
    <c:if test="${study.onOff eq 'STOF01'}"><p>온라인 스터디</p></c:if>
    <c:if test="${study.onOff eq 'STOF02'}"><p>오프라인 스터디</p></c:if>
    <p>${study.expense}</p>

    <c:if test="${wish == null}"><button>찜</button></c:if>
    <c:if test="${wish != null}"><button>찜 취소</button></c:if>

    <c:choose>
        <c:when test="${study.attendants >= study.capacity}"><button>모집마감</button></c:when>
        <c:when test="${attend.status eq 'STUS01'}"><button>탈퇴하기</button></c:when>
        <c:when test="${attend.status eq 'STUS02'}"><button>참석하기</button></c:when>
        <c:when test="${attend.status eq 'STUS03'}"><button>검토중</button></c:when>
        <c:when test="${attend.status eq 'STUS04'}"><button>가입불가</button></c:when>
        <c:otherwise><button>참석하기</button></c:otherwise>
    </c:choose>
    <br>

    <c:if test="${study.representation eq param.userId}">
    <button>스터디 수정</button>
    <button>스터디 삭제</button>
    <button>참가 신청 마감</button>
    <button>멤버 관리</button>
    <button>참여멤버와 채팅</button>
    </c:if>
</div>

<!-- nav -->
<div class="topnav">
    <a href="#info" class="active">정보</a>
    <a href="#member">참여멤버</a>
    <a href="#study">장소</a>
</div>
<!-- /nav -->

<div id="info">
    <h4> 정보</h4>
    <p>${study.information}</p>
</div>

<div id="member">
    <h4>참여멤버</h4>

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
        <p>${study.onUrl}</p>
    </c:if>

    <c:if test="${study.onOff eq 'STOF02'}">
        <h4>장소</h4>
        <p>${study.placeId}</p>
    </c:if>
</div>

<%@include file="../includes/footer.jsp" %>