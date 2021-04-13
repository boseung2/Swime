<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@include file="../includes/header.jsp" %>

<%--참고 링크 : https://www.w3schools.com/howto/howto_css_column_cards.asp--%>

<style>
    * {
        box-sizing: border-box;
    }

    body {
        font-family: Arial, Helvetica, sans-serif;
    }

    /* Float four columns side by side */
    .column {
        float: left;
        width: 25%;
        padding: 0 10px;
    }

    /* Remove extra left and right margins, due to padding */
    .row {margin: 0 -5px;}

    /* Clear floats after the columns */
    .row:after {
        content: "";
        display: table;
        clear: both;
    }

    /* Responsive columns */
    @media screen and (max-width: 600px) {
        .column {
            width: 100%;
            display: block;
            margin-bottom: 20px;
        }
    }

    /* Style the counter cards */
    .card {
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
        padding: 16px;
        text-align: center;
        background-color: #f1f1f1;
    }
</style>

<div class="row">
    <c:forEach items="${list}" var="study">
    <c:set var="startDate" value="${study.startDate}"/>
    <c:set var="endDate" value="${study.endDate}"/>
    <c:set var="startTime" value="${study.startTime}"/>
    <c:set var="endTime" value="${study.endTime}"/>
    <div class="column">
        <div class="card">
            <h3>${study.name}</h3>
            <p>${fn:substring(startDate,0,10)} ~ ${fn:substring(endDate,0,10)}</p>
            <p>${fn:substring(startTime,0,5)} ~ ${fn:substring(endTime,0,5)}<p>
            <c:if test="${study.onOff eq 'STOF01'}"><p>온라인 스터디 : ${study.onUrl}</p></c:if>
            <c:if test="${study.onOff eq 'STOF02'}"><p>장소 : ${study.placeId}</p></c:if>
            <p>${study.expense}</p>
            <p>${study.attendants} / ${study.capacity}</p>
            <button>참석하기</button></p>
        </div>
    </div>
    </c:forEach>
</div>

<%@include file="../includes/footer.jsp" %>
