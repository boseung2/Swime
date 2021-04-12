<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>

<form role="form" action="/group/register" method="post">
    <div class="form-group">
        <label for="sido">시도</label>
        <input type="text" class="form-control" id="sido">
        <label for="sigungu">시군구</label>
        <input type="text" class="form-control" id="sigungu">
        <label for="name">모임 이름</label>
        <input type="text" class="form-control" id="name">
        <label for="tags">태그</label>
        <input type="text" class="form-control" id="tags">
        <label for="capacity">정원</label>
        <input type="number" class="form-control" id="capacity">
    </div>
    <div class="form-group">
        <label>정보</label><br>
        <textarea rows="3" name="info"></textarea>
    </div>
    <div class="form-group">
        <label for="picture">대표사진</label>
        <input type="password" class="form-control" id="picture">
        <button type="submit">등록</button>
        <button type="reset">취소</button>
    </div>
</form>






<%@include file="../includes/footer.jsp" %>
