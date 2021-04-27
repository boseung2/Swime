<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../../includes/tagLib.jsp" %>


<h1>스터디</h1>
<hr>

<div id="height">
    <div style="float:left; width: 30px;height: 30px;">
    </div>
    <div style="float:left;">
        <h2>생성한 스터디</h2>

        <hr>





        <h2>예정된 스터디</h2>

        <hr>




        <h2>종료된 스터디</h2>

        <hr>




        <h2>관심 스터디</h2>




        <div id="end" style="width: 0;height: 0;float: left;"/>
    </div>
</div>




<script>
    if($("#end")[0] !== undefined){
        $("#height").css("height", $("#end").offset().top - $("#height").offset().top);
    }
</script>