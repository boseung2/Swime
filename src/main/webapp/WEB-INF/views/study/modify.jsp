<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="../includes/header.jsp" %>

<div class="container">
    <h2>스터디 수정</h2>
    <hr/>
    <form role="form" id="modifyForm" action="/study/modify" method="post">
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
            <input type="text" class="form-control" id="name" name="name" value="${study.name}" required>
        </div>
        <div class="form-group">
            <label for="startDate">시작일자</label>
            <input type="date" class="form-control" id="startDate" name="startDate" value="${study.startDate}" required>
        </div>
        <div class="form-group" hidden="true">
            <input type="checkbox" id="repeat" onclick="repeatFunction()">정기 스터디
        </div>
        <div class="form-group" id="formEndDate" hidden="true">
            <label for="endDate">종료일자</label>
            <input type="date" class="form-control" id="endDate" name="endDate" value="${study.endDate}">
        </div>
        <div class="form-group" id="formRepeatCycle" hidden="true">
            <label for="repeatCycle">반복주기</label>
            <select class="form-control" id="repeatCycle" name="repeatCycle" value="${study.repeatCycle}">
                <option>(선택)</option>
                <option value="STCY01">매주</option>
                <option value="STCY02">격주</option>
                <option value="STCY03">매월</option>
            </select>
        </div>
        <div class="form-group" id="formRepeatDay" hidden="true">
            <label for="repeatDay">반복요일</label>
            <input type="hidden" class="form-control" id="repeatDay" name="repeatDay">
            <input type="checkbox" value="월" class="day">월
            <input type="checkbox" value="화" class="day">화
            <input type="checkbox" value="수" class="day">수
            <input type="checkbox" value="목" class="day">목
            <input type="checkbox" value="금" class="day">금
            <input type="checkbox" value="토" class="day">토
            <input type="checkbox" value="일" class="day">일
        </div>
        <div class="form-group">
            <label for="startTime">시작시간</label>
            <input type="time" class="form-control" id="startTime" name="startTime" value="${study.startTime}" required>
        </div>
        <div class="form-group">
            <label for="endTime">종료시간</label>
            <input type="time" class="form-control" id="endTime" name="endTime" value="${study.endTime}" required>
        </div>
        <div class="form-group">
            <label for="information">상세 정보</label>
            <textarea class="form-control" rows="5" id="information" name="information" required>${study.information}</textarea>
        </div>
        <input type="hidden" class="form-control" id="onOff" name="onOff" value="${study.onOff}">
        <div class="form-group">
            <input type="checkbox" id="onOffCheck" onclick="checkOn()">온라인스터디
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
            <input type="text" class="form-control" id="capacity" name="capacity" value="${study.capacity}" required>
        </div>
<%--        <button>설문 등록하기</button>--%>
<%--        <button>설문 수정하기</button>--%>
        <br>

        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        <input type="hidden" name="userId" value="${pinfo.username}">
        <input type="hidden" name="pageNum" value="${cri.pageNum}">
        <input type="hidden" name="amount" value="${cri.amount}">

        <c:if test="${pinfo.username eq study.representation}">
            <button type="submit" class="btn btn-primary">수정</button>
        </c:if>
        <a href="/study/get?userId=${pinfo.username}&pageNum=${cri.pageNum}&amount=${cri.amount}&sn=${study.sn}" class="btn btn-primary">취소</a>

    </form>
</div>


<%@include file="../includes/footer.jsp" %>

<!-- 유효성검사 -->
<script>
    $(document).ready(function() {
        let formObj = $('#modifyForm');

        $('button[type="submit"]').on("click", function(e) {
            e.preventDefault();

            if(!validation()) {
                return;
            }

            formObj.submit();
        })
    })
    function validation() {

        if($('#name').val() == "") {
            alert("스터디명을 입력해주세요");
            return false;
        } else if($('#name').val().length > 30) {
            alert("스터디명을 30자 이하로 작성해주세요");
            return false;
        }

        if($('#startDate').val() == "") {
            alert("시작일자를 입력해주세요");
            return false;
        }
        if($('#startTime').val() == "") {
            alert("시작시간을 입력해주세요");
            return false;
        }
        if($('#endTime').val() == "") {
            alert("종료시간을 입력해주세요");
            return false;
        }else {
            let date1 = new Date($('#startDate').val() + ' ' + $('#startTime').val());
            let date2 = new Date($('#startDate').val() + ' ' + $('#endTime').val());

            if(date1 > date2) {
                alert("종료시간이 시작시간보다 빠를 수 없습니다.");
                return false;
            }
        }

        if($('#information').val() == "") {
            alert("상세정보를 입력해주세요");
            return false;
        } else if($('#information').val().lenth > 400) {
            alert("상세정보를 400자 이하로 작성해주세요");
            return false;
        }

        if($('#onOff').val() === 'STOF01') { // 온라인일 경우
            if ($('#onUrl').val() == '') {
                alert("온라인 링크를 입력해주세요.");
                return false;
            } else if (getByte($('#onUrl').val()) > 300) {
                alert("온라인 링크 정보가 너무 큽니다.");
                return false;
            }
        } else if ($('#onOff').val() === 'STOF02'){// 오프라인일 경우
            if ($('#placeId').val() == '') {
                alert("장소 정보를 입력해주세요.");
                return false;
            } else if (getByte($('#placeId').val()) > 40) {
                alert("장소 정보가 너무 큽니다.");
                return false;
            }
        }

        if($('#expense').val().length > 10) {
            alert("지참금 정보가 너무 큽니다.");
            return false;
        }

        if($('#capacity').val() == '') {
            alert("모집인원을 설정해주세요.");
            return false;
        }else {
            let str = $('#capacity').val();
            let flag = true;

            for(let i = 0; i < str.length; i ++) {
                if(isNaN(parseInt(str[i]))) flag = false;
            }

            if(flag == false) {
                alert("숫자만 입력해주세요.");
                return false;
            }else {
                if(parseInt(str) < 2) {
                    alert("모집인원은 2명 이상이어야합니다.");
                    return false;
                }else if (parseInt(str) > 99) {
                    alert("모집인원은 99명 이하이어야합니다.");
                    return false;
                }
            }
        }

        return true;
    }

    function getByte(str) {
        let byte = 0;
        for (let i=0; i<str.length; ++i) {
            (str.charCodeAt(i) > 127) ? byte += 3 : byte++ ;
        }
        return byte;
    }
</script>

<script type="text/javascript">

    $(document).ready(function() {
        console.log("${study.onOff}");

        if("STOF01" === "${study.onOff}") {
            //온라인 스터디에 체크
            onOffCheck.attr("checked", "checked");

            // formUrl 보여주기
            formUrl[0].hidden = false;
            formPlace[0].hidden = true;
        }
        if("STOF02" === "${study.onOff}") {
            //온라인 스터디에 체크
            onOffCheck.removeAttr("checked");

            // formPlace 보여주기
            formUrl[0].hidden = true;
            formPlace[0].hidden = false;
        }
    })

    <!-- 온오프라인 -->
    let onOffCheck = $('#onOffCheck');
    let onOff = $('#onOff');
    let formUrl = $('#formUrl');
    let formPlace = $('#formPlace');


    function checkOn() {
        let on = onOffCheck[0].checked;
        console.log("on = " + on);

        formUrl[0].hidden = !on;
        formPlace[0].hidden = on;

        if(on === true) { // 온라인
            $('#onOff').val("STOF01");
            console.log("온오프 = " + onOffCheck.val());

            $('#onUrl').attr("required", "required");
            $('#placeId').removeAttr("required");

            $('#placeId').val("");
        }
        if(on === false) { // 오프라인
            $('#onOff').val("STOF02");
            console.log("온오프 = " + onOffCheck.val());

            $('#placeId').attr("required", "required");
            $('#onUrl').removeAttr("required");

            $('#onUrl').val("");
        }
    }
</script>