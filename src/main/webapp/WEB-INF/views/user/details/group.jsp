<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../../includes/tagLib.jsp" %>

<h1>모임</h1>
<hr>

<div id="height">
    <div style="float:left; width: 30px;height: 30px;">
    </div>
    <div style="float:left;">
        <h2>생성한 모임</h2>
        <c:forEach var="GroupVo" items="${ownerList}">
            ${GroupVo.sn} ${GroupVo.name} <a href="/group/get?sn=${GroupVo.sn}">자세히 보기</a> <br>
        </c:forEach>
        <hr>

        <h2>가입한 모임</h2>
        <c:forEach var="GroupVo" items="${joinList}">
            ${GroupVo.sn} ${GroupVo.name} <a href="/group/get?sn=${GroupVo.sn}">자세히 보기</a> <br>
        </c:forEach>
        <hr>

        <h2>관심 모임</h2>
        <c:forEach var="GroupVo" items="${wishList}">
            ${GroupVo.sn} ${GroupVo.name} <a href="/group/get?sn=${GroupVo.sn}">자세히 보기</a> <br>
        </c:forEach>
        <div id="end" style="width: 0;height: 0;float: left;"/>
    </div>
</div>




<script>
    $(document).ready(function (){
        if($("#end")[0] !== undefined){
            $("#height").css("height", $("#end").offset().top - $("#height").offset().top);
        }
    })
</script>