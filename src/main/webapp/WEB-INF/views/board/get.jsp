<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>


<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="/resources/css/board-get.css">

<div class="container">
    <div class="row">
        <div class="col-lg-12">
            <h1 class="page-header"> 게시판</h1>
            <hr/>
            <div id="inline3">
                <div class="inline" id="img"><img class="profile" src="../../../resources/image/img_avatar2.png" alt="error"></div>
                <div class="inline" id="name"><c:out value="${board.name}" /></div>
                <div class="inline" id="role">모임장</div>
            </div>

            <div id="inline2">
                <button data-oper='modify' class="btn btn-default"
                onClick="location.href='/board/modify?sn=<c:out value="${board.sn}"/>'">수정</button>
                <button data-oper='remove' class="btn btn-default">삭제</button>
            </div>

            <div id="date">
                <fmt:formatDate pattern="YYYY-MM-dd hh:mm" value="${board.regDate}"/>
            </div>


            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" class="form-control" id="title" name="title"
                       value="<c:out value="${board.title}"/>" readonly="readonly">
            </div>


            <div class="form-group">
                <label for="content">내용</label>
                <textarea class="form-control" rows="5" id="content" name="content" readonly="readonly">
                    <c:out value="${board.content}"/></textarea>
            </div>

            <div class="form-group">
                <label>사진</label>
            </div>

            <div class="form-group">
                <label>첨부파일</label>
            </div>

            <div class="form-group">
                <label>댓글</label>
                <label>5개</label>
            </div>


            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

        </div>
        <!-- ./col-lg-12-->
    </div>
<!-- row -->
</div>
<!--container-->




<%@include file="../includes/footer.jsp" %>