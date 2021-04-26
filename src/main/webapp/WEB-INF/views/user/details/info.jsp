<%--
  Created by IntelliJ IDEA.
  User: JungHyungJin
  Date: 2021-04-20
  Time: 오후 1:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../../includes/tagLib.jsp" %>


<style>
    .topnav > a {
        cursor: pointer;
    }

    .marginLeft {
        margin-left: 30px;
    }
</style>



<!-- Page Content -->
<div class="container">
    <c:if test="${!empty MemberVo}">
        <!-- Heading Row -->
        <div class="row align-items-center my-5">
            <div class="col-lg-7">
                <div>
                    <img id="imgPlace" class="img-fluid rounded mb-4 mb-lg-0" alt="">
                        <%--                    <img id="imgPlace" class="img-fluid rounded mb-4 mb-lg-0" src="/display?fileName=${MemberVo.picture}" alt="">--%>
                        <%--                    <img id="imgPlace" class="img-fluid rounded mb-4 mb-lg-0" src="${!empty MemberVo.picture ? '/display?fileName=' += MemberVo.picture : '사진없음'}" alt="">--%>
                </div>
                <div>${MemberVo.name}</div>
            </div>
            <!-- /.col-lg-8 -->

        </div>
        <!-- /.row -->

        <!-- nav -->
        <div class="topnav">
            <a id="group" class="active">모임</a>
            <a id="study" >스터디</a>
            <a id="written" >작성한 글</a>
            <a id="reply" >작성한 댓글</a>
            <a id="profile" >프로필</a>
        </div>
        <!-- /nav -->

        <div id="content">
            컨테츠 표시구역
        </div>
    </c:if>
    <c:if test="${empty MemberVo}">
        <h1>그런 사용자는 존재하지 않습니다!!!</h1>
    </c:if>

</div>