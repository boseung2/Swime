<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>

<!-- Page Content -->
<div class="container">

    <!-- Heading Row -->
    <div class="row align-items-center my-5">
        <div class="col-lg-7">
            <img class="img-fluid rounded mb-4 mb-lg-0" src="http://placehold.it/900x400" alt="">
        </div>
        <!-- /.col-lg-8 -->
        <div class="col-lg-5">
            <form id="operForm" action="group/modify" method="get">
                <input type="hidden" id="sn" name="sn" value="<c:out value="${group.sn}"/>">
            </form>
            <h1 class="font-weight-light"><c:out value="${group.name}"/></h1>
            <p><c:out value="${group.tags}"/></p>
            <p>지역 <c:out value="${group.sido}"/><c:out value="${group.sigungu}"/></p>
            <p>총인원 <c:out value="${group.attendCount}"/></p>
            <p>모임장 <c:out value="${group.userName}"/></p>
            <a class="btn btn-primary" href="#">모임 가입</a>
            <button data-oper="modify" class="btn btn-primary">모임 수정</button>
            <a class="btn btn-primary" href="#">❤</a>
        </div>
        <!-- /.col-md-4 -->
    </div>
    <!-- /.row -->

    <!-- nav -->
    <div class="topnav">
        <a href="#info" class="active">정보</a>
        <a href="#member">모임멤버</a>
        <a href="#study">스터디</a>
        <a href="#board">게시판</a>
    </div>
    <!-- /nav -->

    <div id="info">
        <h4> 정보</h4>
        <p><c:out value="${group.info}"/></p>
    </div>
    <div id="member">
        <h4> 모임멤버</h4>
        <c:forEach items="${attendList}" var="member" varStatus="status">
            <img src="../../../resources/image/img_avatar2.png" alt="Avatar" class="avatar">
            <span><c:out value="${member.name}"/></span>
            <span><c:out value="${member.grpRole}"/></span>
            <c:if test="${status.count % 3 == 0}">
                <br>
            </c:if>
        </c:forEach>
    </div>


    <!-- Call to Action Well -->
    <div class="card text-white bg-secondary my-5 py-4 text-center">
        <div class="card-body">
            <p class="text-white m-0">This call to action card is a great place to showcase some important information or display a clever tagline!</p>
        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function() {

        let operForm = $('#operForm');

        $("button[data-oper='modify']").on("click", function(e) {
            operForm.attr('action', '/group/modify').submit();
        })

    })
</script>




<%@include file="../includes/footer.jsp" %>
