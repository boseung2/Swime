<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>

<div class="container">
    <h2>모임 만들기</h2>
    <hr/>
    <form role="form" action="/group/register" method="post">
        <div class="form-group">
            <label for="userId">아이디</label>
            <input type="text" class="form-control" id="userId" name="userId">
        </div>
        <div class="form-group">
            <label for="category">카테고리</label>
            <select class="form-control" id="category" name="category">
                <option>------</option>
                <option value="GRCA01">프론트엔드</option>
                <option value="GRCA02">백엔드</option>
                <option value="GRCA03">앱 개발</option>
                <option value="GRCA04">게임 개발</option>
                <option value="GRCA05">프로그래밍 언어</option>
                <option value="GRCA06">알고리즘</option>
                <option value="GRCA07">데이터 사이언스</option>
                <option value="GRCA08">데이터베이스</option>
                <option value="GRCA09">컴퓨터 사이언스</option>
                <option value="GRCA10">개발 도구</option>
                <option value="GRCA11">교양 · 기타</option>
            </select>
        </div>
        <div class="form-group">
            <label for="name">모임이름</label>
            <input type="text" class="form-control" name="name" id="name">
        </div>
        <div class="form-group">
            <label for="picture">대표사진</label>
            <input type="text" class="form-control" id="picture" name="picture">
        </div>
        <div class="form-group">
            <label for="description">한줄소개</label>
            <textarea class="form-control" rows="1" id="description" name="description"></textarea>
        </div>
        <div class="form-group">
            <label for="info">정보 (모임에 대해 자세히 적어주세요)</label>
            <textarea class="form-control" rows="5" id="info" name="info"></textarea>
        </div>
        <div class="form-row">
            <div class="col">
            <label for="sido">시/도</label>
            <select class="form-control" id="sido" name="sido">
                <option value="LOSI01">1</option>
                <option value="LOSI02">2</option>
                <option value="LOSI03">3</option>
                <option value="LOSI04">4</option>
            </select>
            </div>
            <div class="col">
                <label for="sigungu">시/군/구</label>
                <select class="form-control" id="sigungu" name="sigungu">
                    <option value="LOGU01">1</option>
                    <option value="LOGU01">2</option>
                    <option value="LOGU01">3</option>
                    <option value="LOGU01">4</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="tags">태그</label>
            <input type="text" class="form-control" name="tags" id="tags">
        </div>
        <button type="submit" class="btn btn-primary">등록</button>
        <button type="reset" class="btn btn-primary">취소</button>
    </form>
</div>






<%@include file="../includes/footer.jsp" %>
