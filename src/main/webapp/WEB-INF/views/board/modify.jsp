
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>



<div class="container">
    <h2>게시글 수정하기</h2>
    <hr/>
    <form id="modifyForm" role="form" action="/board/modify" method="post">


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


        <div class="form-check">
            <input class="form-check-input" type="checkbox" ${board.topFix == 'BOFI01' ? 'checked' : ''} value="${board.topFix == null ? 'BOFI01' : board.topFix}" name="topFix" id="topFix">
            <label class="form-check-label" for="topFix">
                게시물 상위고정
            </label>
        </div>

        <input type="hidden" name="status" value="${board.status}">
        <input type="hidden" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
        <input type="hidden" name="amount" value="<c:out value="${cri.amount}"/>">

        <button id='modifyBtn' type="submit" data-oper="modify" class="btn btn-primary">수정</button>
        <button type="submit" data-oper="remove" class="btn btn-danger">삭제</button>
        <button type="submit" data-oper="list" class="btn btn-dark">목록</button>
<%--        <a id="back" class="btn btn-dark">취소</a>--%>

        <%--        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">--%>
        <sec:csrfInput/>
    </form>
</div>

<script type="text/javascript">

    $(document).ready(function(){

        let formObj = $("#modifyForm");

        $("button").on("click", function(e){
            e.preventDefault();

            let operation = $(this).data('oper');

            console.log(operation);

            if(operation === 'remove') {
                formObj.attr("action", "/board/remove");
            } else if (operation === 'list') {
                formObj.attr("action", '/board/list').attr("method", "get");
                let pageNumTag = $("input[name='pageNum']").clone();
                let amountTag = $("input[name='amount']").clone();
                formObj.empty();
                formObj.append(pageNumTag);
                formObj.append(amountTag);
            } else {

                e.preventDefault();

                if(!validation()) {
                    return;
                }
            }

            formObj.submit();
        });

        // $("#back").on("click", function(){
        //     window.history.back();
        // });


        // $("button[id='modifyBtn']").on("click", function(e) {
        //
        //
        // })

        function validation(){

            if(getByte($("input[id='title']").val())== "") {
                alert("제목을 입력해주세요.");
                return false;
            }else if(getByte($("input[id='title']").val()) > 200){
                alert("게시글 제목을 65자 이하로 작성해주세요.");
                return false;
            }

            if(getByte($("textarea[id='content']").val()) == "") {
                alert("내용을 입력해주세요");
                return false;

            }else if(getByte($("textarea[id='content']").val()) > 4000){
                alert("게시글 내용이 너무 깁니다.");
                return false;
            }
            return true;
        }

        function getByte(str){
            let byte = 0;
            for(let i = 0; i<str.length; ++i){
                (str.charCodeAt(i) > 127) ? byte += 3 : byte++;
            }
            return byte;
        }



    });

</script>


<%@include file="../includes/footer.jsp" %>
