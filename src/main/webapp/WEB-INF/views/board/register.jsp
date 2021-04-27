<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@include file="../includes/header.jsp" %>

<sec:authorize access="isAuthenticated()">
    <c:set value="${principal.username}" var="userId"/>
</sec:authorize>
<style>
    #topFix{
        width: 15px;
        height: 15px;
    }
</style>

<div class="container">
    <h2>게시글 작성</h2>
    <hr/>
    <form id="registerForm"role="form" action="/board/register" method="post">

        <div class="form-group">
            <label for="userId">아이디</label>
            <input type="text" class="form-control" id="userId" name="userId"
                   value="<sec:authentication property="principal.username"/>" readonly="readonly">
        </div>

        <div class="form-group">
            <label for="grpSn">모임번호</label>
            <input type="text" class="form-control" id="grpSn" name="grpSn" value="${grpSn}"
                   readonly="readonly">
        </div>

        <div class="form-group">
            <label for="title">제목</label>
            <input type="text" class="form-control" name="title" id="title" required>
        </div>

        <div class="form-group">
            <label for="content">내용</label><small id="contentLength">(0/1333)</small>
            <textarea class="form-control" rows="5" id="content" name="content" required></textarea>
        </div>

        <div class="form-group">
            <label for="picture">사진</label>
            <input type="file" class="form-control" id="picture" name="picture" multiple>
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

        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        <button id='registerBtn' type="submit" class="btn btn-primary">등록</button>
        <button id="back" type="reset" class="btn btn-dark">취소</button>


        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
    </form>
</div>

<script>
    $(document).ready(function(){


    $("#back").on("click", function(){
        window.history.back();
    });

    let objForm = $('#registerForm');

    $('button[type="submit"]').on("click", function(e) {
        e.preventDefault();

        if(!validation()) {
            console.log('no validataion');

            return;
        }else{
            console.log('inserting');
            //alert("제목을 입력해주세요.");
            // return;
        }

        console.log('hi');
        objForm.submit();

    });
    //내용이 입력되면 글자 개수 증가
     $('textarea').keyup(function(){
            //정규식 숫자 영어 특수문자 한글
            let inputLength = $(this).val().length;
            let remain = inputLength++;

        if(inputLength > 0){
            $('textarea').val($('textarea').val().substring(0,1333));
            if(remain > 1333){
                alert("내용 입력을 초과하였습니다.");
            }
        }


        $('#contentLength').html('('+remain+'/1333)');
    });

    /*테스트 결과 register에서 처리해야 할 부분
    1. 제목 내용 공백(스페이스바)들어가는 것 처리.
    제목/내용 공백처리 완료.
    * */
    function validation(){
        // $("input[id='title']").val().trim().length == 0
        // getByte($("input[id='title']").val()) == ""
        if($("input[id='title']").val().trim().length == 0) {
            alert("제목을 입력해주세요.");
            return false;

        }else if(getByte($("input[id='title']").val()) > 200){
            alert("게시글 제목이 너무 깁니다.");
            return false;
        }
        //getByte($("textarea[id='content']").val()) == ""
        if($("textarea[id='content']").val().trim().length == 0) {
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


    })//end ready
</script>


<%@include file="../includes/footer.jsp" %>