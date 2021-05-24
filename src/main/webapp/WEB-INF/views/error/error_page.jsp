<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page session="false" import="java.util.*"%>

<%@include file="../includes/header.jsp" %>

<div class="container" style="text-align: center; margin-top: 30px;">
    <img src="../../../resources/img/logo.png" style="width: 10rem;">
</div>
<div class="page-wrap d-flex flex-row align-items-center">
    <div class="container">
        <div class="row justify-content-center">
            <div class="col-md-12 text-center">
                <span class="display-1 d-block">404</span>
                <div class="mb-4 lead">The page you are looking for was not found.</div>
                <a href="https://www.totoprayogo.com/#" class="btn btn-link">Back to Home</a>
            </div>
        </div>
    </div>
</div>

<%--<h4>${exception.getMessage()}</h4>--%>
<%--<ul>--%>
<%--    <c:forEach items="${exception.getStackTrace()}" var="stack">--%>
<%--        <li><c:out value="${stack}"></c:out></li>--%>
<%--    </c:forEach>--%>
<%--</ul>--%>

<%@include file="../includes/footer.jsp" %>
