<%--
  Created by IntelliJ IDEA.
  User: tht12
  Date: 2021-05-16
  Time: 오후 3:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%--<%@include file="../includes/header.jsp" %>--%>

<%@include file="../includes/header4.jsp" %>
<div style="height: 300px;width: 300px;background-color: #4d90fe"></div>

request.getRemoteAddr() =<%= request.getRemoteAddr() %> <br>
request.getContentLength() =<%= request.getContentLength() %> <br>
request.getCharacterEncoding() =<%= request.getCharacterEncoding() %> <br>
request.getContentType() =<%= request.getContentType() %> <br>
request.getProtocol() =<%= request.getProtocol() %> <br>
request.getMethod() =<%= request.getMethod() %> <br>
request.getQueryString() =<%= request.getQueryString() %> <br>
request.getRequestURI() =<%= request.getRequestURI() %> <br>
request.getRequestURL() =<%= request.getRequestURL() %> <br>
request.getContextPath() =<%= request.getContextPath() %> <br>
request.getServletPath() =<%= request.getServletPath() %> <br>
request.getServerName() =<%= request.getServerName() %> <br>
request.getServerPort() =<%= request.getServerPort() %> <br>
<div style="height: 2000px;"></div>
