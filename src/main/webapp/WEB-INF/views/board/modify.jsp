
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>



<div class="container">
    <h2>게시글 수정하기</h2>
    <hr/>
    <form role="form" action="/board/modify" method="post">

        <div class="form-group">
            <label for="sn">번호</label>
            <input type="text" class="form-control" name="sn" id="sn"
                   value="<c:out value="${board.sn}"/>" readonly="readonly">
        </div>

        <div class="form-group">
            <!--<label for="name">아이디</label>-->
            <input type="hidden" class="form-control" id="name" name="name"
                   value="<c:out value="${board.userId}"/>" readonly="readonly">
        </div>

        <div class="form-group">
            <label for="grpSn">모임번호</label>
            <input type="text" class="form-control" id="grpSn" name="grpSn"
                   value="<c:out value="${board.grpSn}"/>" readonly="readonly">
        </div>

        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" class="form-control" name="title" id="title"
                   value="<c:out value="${board.title}"/>">
        </div>

        <div class="form-group">
            <label for="content">내용</label>
            <textarea class="form-control" rows="5" id="content" name="content">
                <c:out value="${board.content}"/>
            </textarea>
        </div>

        <div class="form-group">
            <label for="picture">사진</label>
            <input type="file" class="form-control" id="picture" name="picture">
        </div>

        <div class="form-group">
            <label for="post">첨부파일</label>
            <input type="file" class="form-control" id="post" name="post">
        </div>


        <%--        <div class="form-group">--%>
        <%--            <label for="topFix">게시물 상위고정</label>--%>
        <%--            <input type="checkbox" class="form-control" name="topFix" id="topFix">--%>
        <%--        </div>--%>

        <div class="form-check">
            <input class="form-check-input" type="checkbox" value="BOFI02" id="topFix">
            <label class="form-check-label" for="topFix">
                게시물 상위고정
            </label>
        </div>

        <button type="submit" data-oper="modify" class="btn btn-primary">수정</button>
        <button type="submit" data-oper="remove" class="btn btn-danger">삭제</button>
        <a id="back" class="btn btn-dark">취소</a>

<%--        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">--%>
        <sec:csrfInput/>
    </form>
</div>

<script type="text/javascript">

    $(document).ready(function(){

        let formObj = $("form");

        $("button").on("click", function(e){
            e.preventDefault();

            let operation = $(this).data("oper");

            console.log(operation);

            if(operation === 'remove'){
                formObj.attr("action", "/board/remove");

            }
            formObj.submit();
        })

        $("#back").on("click", function(){
            window.history.back();
        });
    });

</script>


<%@include file="../includes/footer.jsp" %>
