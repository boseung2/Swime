<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<%@include file="../includes/header.jsp" %>

<h2>멤버 관리</h2>

<h1>${stdSn}</h1>

<!-- nav -->
<div class="topnav">
    <a href="#member" class="active">참여 멤버</a>
    <a href="#waitingMember">승인 대기 멤버</a>
</div>
<!-- /nav -->

<%--<div id="member">--%>
<%--    <c:forEach items="${attendantList}" var="member">--%>
<%--        <img src="../../../resources/image/img_avatar2.png" alt="Avatar" class="avatar">--%>
<%--        <span>${member.userName}</span>--%>
<%--        <c:if test="${member.userId == study.representation}"><span>스터디장</span></c:if>--%>
<%--        <span>${member.grpRole}</span>--%>
<%--        <c:if test="${member.grpRole == 'GRRO01'}"><span>모임장</span></c:if>--%>
<%--        <c:if test="${member.grpRole == 'GRRO02'}"><span>운영진</span></c:if>--%>
<%--        <c:if test="${member.userId != study.representation}"><button>강퇴</button></c:if>--%>
<%--        <br>--%>
<%--    </c:forEach>--%>
<%--</div>--%>

<%--<div id="waitingMember">--%>
<%--    <c:forEach items="${waitingList}" var="waitingMember">--%>
<%--        <img src="../../../resources/image/img_avatar2.png" alt="Avatar" class="avatar">--%>
<%--        <span>${waitingMember.userName}</span>--%>
<%--        <span>${waitingMember.grpRole}</span>--%>
<%--        <c:if test="${waitingMember.grpRole == 'GRRO01'}"><span>모임장</span></c:if>--%>
<%--        <c:if test="${waitingMember.grpRole == 'GRRO02'}"><span>운영진</span></c:if>--%>
<%--        <button>답변 보기</button>--%>
<%--        <br>--%>
<%--    </c:forEach>--%>
<%--</div>--%>

<%@include file="../includes/footer.jsp" %>