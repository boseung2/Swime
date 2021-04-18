<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@include file="../includes/header.jsp" %>

<div class="container">
    <h2>스터디 수정</h2>
    <hr/>
    <form role="form" action="/study/modify" method="post">
        <div class="form-group">
            <label for="sn">스터디번호</label>
            <input type="text" class="form-control" id="sn" name="sn" value="${study.sn}" readonly="readonly">
        </div>
        <div class="form-group">
            <label for="grpSn">그룹번호</label>
            <input type="text" class="form-control" id="grpSn" name="grpSn" value="${study.grpSn}" readonly="readonly">
        </div>
        <div class="form-group">
            <label for="representation">작성자</label>
            <input type="text" class="form-control" id="representation" name="representation" value="${study.representation}" readonly="readonly">
        </div>
        <div class="form-group">
            <label for="name">스터디명</label>
            <input type="text" class="form-control" id="name" name="name" value="${study.name}">
        </div>
        <div class="form-group">
            <label for="startDate">시작일자</label>
            <input type="date" class="form-control" id="startDate" name="startDate" value="${study.startDate}">
        </div>
        <div class="form-group">
            <label for="endDate">종료일자</label>
            <input type="date" class="form-control" id="endDate" name="endDate" value="${study.endDate}">
        </div>
        <div class="form-group">
            <label for="repeatCycle">반복주기</label>
            <select class="form-control" id="repeatCycle" name="repeatCycle" value="${study.repeatCycle}">
                <option>(선택)</option>
                <option value="STCY01">매주</option>
                <option value="STCY02">격주</option>
                <option value="STCY03">매월</option>
            </select>
        </div>
        <div class="form-group">
            <button id="mon" value="false">월</button>
            <button id="tue" value="false">화</button>
            <button id="wed" value="false">수</button>
            <button id="thu" value="false">목</button>
            <button id="fri" value="false">금</button>
            <button id="sat" value="false">토</button>
            <button id="sun" value="false">일</button>
        </div>
        <div class="form-group">
            <label for="startTime">시작시간</label>
            <input type="time" class="form-control" id="startTime" name="startTime" value="${study.startTime}">
        </div>
        <div class="form-group">
            <label for="endTime">종료시간</label>
            <input type="time" class="form-control" id="endTime" name="endTime" value="${study.endTime}">
        </div>
        <div class="form-group">
            <label for="information">상세 정보</label>
            <textarea class="form-control" rows="5" id="information" name="information">${study.information}</textarea>
        </div>
        <div class="form-group">
            <input type="checkbox" id="onOff" onclick="checkOnOff()">온라인스터디
        </div>
        <div class="form-group" id="formUrl" hidden="true">
            <label for="onUrl">온라인 스터디 링크 추가</label>
            <input type="text" class="form-control" id="onUrl" name="onUrl" value="${study.onUrl}">
        </div>
        <div class="form-group" id="formPlace">
            <label for="placeId">스터디 장소 추가</label>
            <input type="text" class="form-control" id="placeId" name="placeId" value="${study.placeId}">
        </div>
        <div class="form-group">
            <label for="expense">지참금</label>
            <input type="text" class="form-control" id="expense" name="expense" value="${study.expense}">
        </div>
        <div class="form-group">
            <label for="capacity">모집 인원</label>
            <input type="text" class="form-control" id="capacity" name="capacity" value="${study.capacity}">
        </div>
        <button>설문 등록하기</button>
        <button>설문 수정하기</button>
        <br>

        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

        <button type="submit" class="btn btn-primary">수정</button>
        <button type="submit" class="btn btn-primary">삭제</button>
        <button type="reset" class="btn btn-primary">취소</button>
    </form>
</div>


<%@include file="../includes/footer.jsp" %>

<script type="text/javascript">

    let onOffCheck = document.getElementById("onOff");
    let formUrl = document.getElementById("formUrl");
    let formPlace = document.getElementById("formPlace");

    function checkOnOff() {
        formUrl.hidden = !onOffCheck.checked;
        formPlace.hidden = onOffCheck.checked;
    }

    $(document).ready(function() {
    })
</script>