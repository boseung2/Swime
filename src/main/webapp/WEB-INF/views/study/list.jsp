<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>

<style>
    .card {
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
        max-width: 300%;
        margin: auto;
        text-align: center;
        font-family: arial;
        display: inline-flex;
    }

    .card button {
        border: none;
        outline: 0;
        padding: 12px;
        color: white;
        background-color: #000;
        text-align: center;
        cursor: pointer;
        width: 100%;
        font-size: 18px;
    }

    .card button:hover {
        opacity: 0.7;
    }
</style>

<c:forEach items="${list}" var="study">
    <c:set var="startDate" value="${study.startDate}"/>
    <c:set var="endDate" value="${study.endDate}"/>
    <c:set var="startTime" value="${study.startTime}"/>
    <c:set var="endTime" value="${study.endTime}"/>

    <span class="card">
        <h3>${study.name}</h3>
        <p>${fn:substring(startDate,0,10)} ~ ${fn:substring(endDate,0,10)}</p>
        <p>${fn:substring(startTime,0,5)} ~ ${fn:substring(endTime,0,5)}<p>
        <c:if test="${study.onOff eq 'STOF01'}"><p>${study.onUrl}</p></c:if>
        <c:if test="${study.onOff eq 'STOF02'}"><p>${study.placeId}</p></c:if>
        <p>${study.expense}</p>
        <p>${study.attendants} / ${study.capacity}</p>
        <button>참석하기</button></p>
    </span>
</c:forEach>

<%@include file="../includes/footer.jsp" %>
