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
                <a data-oper='modify' class="btn btn-primary"
                onclick="location.href='/board/modify?sn=<c:out value="${board.sn}"/>'">수정</a>

                <a id="back" class="btn btn-dark">취소</a>

<%--                <button data-oper="modify" class=""--%>


<%--                <form id="modifyForm" role="form" action="/board/remove" method="post">--%>
<%--                    <button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>--%>
<%--                    <sec:csrfInput/>--%>
<%--                </form>--%>
<%--                                    <button data-oper='remove' class="btn btn-default">삭제</button>--%>
            </div>
            <form id="operForm" action="/board/modify" method="get">
                <input type="hidden" id="sn" name="sn" value="<c:out value="${board.sn}"/>">
            </form>


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

<script>

    $(document).ready(function(){

        $("button[data-oper='modify']").on("click",function(){
            operForm.attr("action", "/board/modify").submit();

        })
        $("#back").on("click", function(){
            window.history.back();
        })
    })


    // $(document).ready(function(){
    //
    //     let formObj = $("form");
    //     console.dir(formObj);
    //
    //     $('button').on("click", function(e){
    //
    //         e.preventDefault();
    //
    //         let operation = $(this).data("oper");
    //
    //         console.log(operation);
    //
    //         if(operation === 'remove'){
    //             formObj.attr("action", "board/remove")
    //             self.location = "/board/list";
    //             return
    //         }
    //         formObj.submit();
    //     });
    // });
</script>



<%@include file="../includes/footer.jsp" %>