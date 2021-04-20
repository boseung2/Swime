<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../../includes/tagLib.jsp" %>
<h1>모임</h1>

<h2>생성한 모임</h2>
<c:forEach var="owner" items="${ownerList}">
    ${owner.sn} ${owner.name} <a href="#">자세히 보기</a> <br>
</c:forEach>

<h2>가입한 모임</h2>

<h2>관심 모임</h2>


<script>
    $(document).ready(function (){

    })
</script>