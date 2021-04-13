<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@include file="../includes/header.jsp" %>

<h2>멤버 관리</h2>

<!-- nav -->
<div class="topnav">
    <a href="#info" class="active">참여 멤버</a>
    <a href="#member">승인 대기 멤버</a>
</div>
<!-- /nav -->

<div id="member">
    <c:forEach items="${attendantList}" var="member">
        <img src="../../../resources/image/img_avatar2.png" alt="Avatar" class="avatar">
        <span>${member.userName}</span>
        <c:if test="${member.userId eq study.representation}"><span>스터디장</span></c:if>
        <span>${member.grpRole}</span>
        <button>강퇴</button>
        <br>
    </c:forEach>
</div>

<div id="waitingMember">
    <c:forEach items="${waitingList}" var="waitingMember">
        <img src="../../../resources/image/img_avatar2.png" alt="Avatar" class="avatar">
        <span>${waitingMember.userName}</span>
        <span>${waitingMember.grpRole}</span>
        <button>답변 보기</button>
        <br>
    </c:forEach>
</div>

<%@include file="../includes/footer.jsp" %>