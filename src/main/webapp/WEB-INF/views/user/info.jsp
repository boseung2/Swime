<%--
  Created by IntelliJ IDEA.
  User: JungHyungJin
  Date: 2021-04-13
  Time: 오후 10:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../includes/header.jsp" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h1>사용자 정보</h1>
    <sec:authorize access="isAnonymous()">
        로그인중이 아닙니다
    </sec:authorize>
    <sec:authorize access="isAuthenticated()">
        principal : <sec:authentication property="principal"/><br>
        memberVo : <sec:authentication property="principal.memberVO"/><br>
        사용자이름 : <sec:authentication property="principal.memberVO.name"/><br>
        사용자 권한 리스트 : <sec:authentication property="principal.memberVO.authList"/><br>
    </sec:authorize>

<div style="border-style:solid;
    border-top-width: thin;
    border-bottom-width: thick;
    border-left-width: 20px;
    border-right-width: medium;
    border-radius: 2px;">

</div>
</body>
</html>
