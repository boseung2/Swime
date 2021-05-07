<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page session="false" import="java.util.*"%>

<%@include file="includes/header.jsp" %>

<h1>실행중에 에러가 발생했습니다.</h1>
<h4>${exception.getMessage()}</h4>
<ul>
    <c:forEach items="${exception.getStackTrace()}" var="stack">
        <li><c:out value="${stack}"></c:out></li>
    </c:forEach>
</ul>

<%@include file="includes/footer.jsp" %>
