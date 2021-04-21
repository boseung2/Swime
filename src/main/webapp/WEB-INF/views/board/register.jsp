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
            <label for="content">내용</label>
            <textarea class="form-control" rows="5" id="content" name="content" required></textarea>
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

        <button id='registerBtn' type="submit" class="btn btn-primary">등록</button>
        <button id="back" type="reset" class="btn btn-dark">취소</button>


        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
    </form>
</div>

<script>
    $("#back").on("click", function(){
        window.history.back();
    });

    objForm = $('#registerForm');

    $('button[type="submit"]').on("click", function(e) {
        e.preventDefault();

        if(!validation()) {
            return;
        }

        console.log('hi');
        objForm.submit();

    })


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
</script>


<%@include file="../includes/footer.jsp" %>