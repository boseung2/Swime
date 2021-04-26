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
        <div class="form-group">
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
                <option value="STCY01" hidden="true">매주</option>
                <option value="STCY02" hidden="true">격주</option>
                <option value="STCY03" hidden="true">매월</option>
            </select>
        </div>
        <div class="form-group" id="formRepeatDay" hidden="true">
            <label for="repeatDay">반복요일</label>
            <input type="hidden" class="form-control" id="repeatDay" name="repeatDay" value="${study.repeatDay}">
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
            <select class="form-control" id="expenseSelect" name="expenseSelect">
                <option>(선택)</option>
                <option class="expense" value="없음">없음</option>
                <option class="expense" value="추후공지">추후공지</option>
                <option class="expense" value="직접입력">직접입력</option>
            </select>
            <input type="text" class="form-control" id="expense" name="expense" placeholder="원 단위로 숫자만 입력해주세요." hidden="true" value="${study.expense}">
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

<!-- 지참금 보여주기 -->
<script>
    $(document).ready(function() {
        if("(선택)" !== "${study.expense}" && "없음" !== "${study.expense}" && "추후공지" !== "${study.expense}") {
            $('option[value="직접입력"]').prop("selected", true);
            $('#expense').removeAttr("hidden");
        }

        console.log("지참금 = " + "${study.expense}");

        let selectList = $('option[class="expense"]');

        for(let i = 0; i < selectList.length; i++) {
            if(selectList[i].value === "${study.expense}") {
                selectList[i].selected = true;
            }
        }
    })
</script>

<!-- 지참금 변경시-->
<script>
    $('#expenseSelect').on("change", function(){
        console.log("expense select clicked = " + $(this).val());

        if($(this).val() === '직접입력') {
            $('#expense').val("");
            $('#expense').removeAttr('hidden');
        }else {
            // 직접입력이 아닐 경우
            $('#expense').attr('hidden', 'true');
            $('#expense').val($(this).val());
        }
    })
</script>

<!-- 정기스터디 보여주기 -->
<script>
    $(document).ready(function() {

        if($('#endDate').val() !== ''){ // endDate 존재하면
            $('#repeat').prop("checked", true);
            $('#formEndDate').removeAttr("hidden");
            $('#formRepeatCycle').removeAttr("hidden");

            // 반복주기 select 추가
            let start = new Date($('#startDate').val());
            let end = new Date($('#endDate').val());

            if((end-start) / (1000 * 24 * 60 * 60) > 7) { // 매주
                $('option[value="STCY01"]').removeAttr("hidden");
            }
            if((end-start) / (1000 * 24 * 60 * 60) > 15) { // 격주
                $('option[value="STCY02"]').removeAttr("hidden");
            }

            // 매월
            let flag = false;
            for(let i = start.getMonth()+2; i < end.getMonth()+1; i++) {
                console.log("start = " + start.getMonth()+2);
                console.log("i = " + i);
                console.log("end = " + end.getMonth()+1);

                if(start.getDate() <= new Date(end.getFullYear(), i, 0)) { // 해당 월의 말일
                    flag = true;
                    break;
                }
            }
            if(!flag && start.getMonth() < end.getMonth()  && start.getDate() <= end.getDate()){
                flag = true;
            }

            if(flag) {
                $('option[value="STCY03"]').removeAttr("hidden");
            }

            console.log("반복주기 = " + "${study.repeatCycle}");
            console.log("반복주기 = " + "${study.repeatDay}");

            if("STCY01" === "${study.repeatCycle}") {
                $('option[value="STCY01"]').attr("selected", true);
            }else if("STCY02" === "${study.repeatCycle}") {
                $('option[value="STCY02"]').attr("selected", true);
            }else if("STCY03" === "${study.repeatCycle}") {
                $('option[value="STCY03"]').attr("selected", true);
            }

            if("STCY01" === "${study.repeatCycle}" || "STCY02" === "${study.repeatCycle}") {
                $('#formRepeatDay').removeAttr("hidden");

                let dayList = "${study.repeatDay}".split(",");

                let dayCheckBoxes = $('input[class="day"]');

                for(let i = 0; i < dayList.length; i++) {
                    for(let j = 0; j < dayCheckBoxes.length; j++) {
                        if(dayList[i] === dayCheckBoxes[j].value) {
                            dayCheckBoxes[j].checked = true;
                            break;
                        }
                    }
                }
            }

        }
    })
</script>

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
        }else {
            let nameTemp = $('#name').val().trim();
            $('#name').val(nameTemp);
        }

        if($('#startDate').val() == "") {
            alert("시작일자를 입력해주세요");
            return false;
        }
        if($('#startTime').val() == "") {
            alert("시작시간을 입력해주세요");
            return false;
        }

        // 정기스터디이면
        if($('#repeat').is(":checked")) {
            // 종료일자 필수
            if ($('#endDate').val() == "") {
                alert("종료 일자를 선택해주세요.")
                return false;
            } else {
                let date1 = new Date($('#startDate').val());
                let date2 = new Date($('#endDate').val());

                if (date1 > date2) {
                    alert('시작 일자가 종료 일자보다 빠를 수 없습니다.');
                    return false;
                }
            }

            // 매주/격주일때 반복요일 하나는 필수
            if ($('#repeatCycle').val() == 'STCY01' || $('#repeatCycle').val() == 'STCY02') {
                if ($('#repeatDay').val().length < 1) {
                    alert('반복요일을 선택해주세요.');
                    return false;
                }
            }
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
        } else if($('#information').val().length > 400) {
            alert("상세정보를 400자 이하로 작성해주세요");
            return false;
        }else {
            let infoTemp = $('#information').val().trim().toString();
            infoTemp = removeTag(infoTemp); // 태그 없애기
            $('#information').val(infoTemp);
        }

        if($('#onOff').val() === 'STOF01') { // 온라인일 경우
            if ($('#onUrl').val() == '') {
                alert("온라인 링크를 입력해주세요.");
                return false;
            } else if(!checkUrl($('#onUrl').val())) {
                alert("url 형식이 맞지 않습니다.");
                return false;
            } else if (getByte($('#onUrl').val()) > 300) {
                alert("온라인 링크 정보가 너무 큽니다.");
                return false;
            }
        } else if ($('#onOff').val() === 'STOF02'){// 오프라인일 경우
            if ($('#placeId').val() == '') {
                alert("장소 정보를 입력해주세요.");
                return false;
            } else if (getByte($('#placeId').val()) > 300) {
                alert("장소 정보가 너무 큽니다.");
                return false;
            }
        }

        if($('#expense').val().length > 10) {
            alert("지참금 정보는 10자 이내여야합니다.");
            return false;
        }else if($('#expenseSelect').val() === '직접입력') {
            let str = $('#expense').val();
            let flag = true;

            for(let i = 0; i < str.length; i ++) {
                if(isNaN(parseInt(str[i]))) {
                    flag = false;
                    break;
                }
            }

            if(flag == false) {
                alert("지참금에 숫자만 입력해주세요.");
                return false;
            }
        }

        if($('#capacity').val() == '') {
            alert("모집인원을 설정해주세요.");
            return false;
        }else {
            let str = $('#capacity').val();
            let flag = true;

            for(let i = 0; i < str.length; i ++) {
                if(isNaN(parseInt(str[i]))) {
                    flag = false;
                    break;
                }
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

    // url 형식인지 체크( http, https 를 포함하는 형식 )
    function checkUrl(url) {
        let expUrl = /^http[s]?\:\/\/./i;
        return expUrl.test(url);
    }

    // 태그 제거
    function removeTag(str) {
        return str.replace(/(<([^>]+)>)/ig,"");
    }

</script>

<script type="text/javascript">

    <!-- 반복주기/요일 -->
    let repeat = $('#repeat');

    let formEndDate = $('#formEndDate');
    let formRepeatCycle = $('#formRepeatCycle');
    let formRepeatDay = $('#formRepeatDay');

    let endDate = $('#endDate');
    let repeatCycle = $('#repeatCycle');
    let repeatDay = $('#repeatDay');


    // 종료일자 새로 선택될때마다 반복주기 다르게 보여주기
    $('#endDate').on('change', function(){
        let start = new Date($('#startDate').val());
        let end = new Date($('#endDate').val());

        // 매주
        if((end-start) / (1000 * 24 * 60 * 60) > 7) {
            $('option[value="STCY01"]').removeAttr("hidden");
        }else {
            $('option[value="STCY01"]').attr("hidden", "true");
        }
        // 격주
        if((end-start) / (1000 * 24 * 60 * 60) > 15) {
            $('option[value="STCY02"]').removeAttr("hidden");
        }else {
            $('option[value="STCY02"]').attr("hidden", "true");
        }
        // 매달
        let flag = false;
        for(let i = start.getMonth()+2; i < end.getMonth()+1; i++) {
            console.log("start = " + start.getMonth()+2);
            console.log("i = " + i);
            console.log("end = " + end.getMonth()+1);

            if(start.getDate() <= new Date(end.getFullYear(), i, 0)) { // 해당 월의 말일
                flag = true;
                break;
            }
        }
        if(!flag && start.getMonth() < end.getMonth()  && start.getDate() <= end.getDate()){
            flag = true;
        }

        if(flag) {
            $('option[value="STCY03"]').removeAttr("hidden");
        }else {
            $('option[value="STCY03"]').attr("hidden", "true");
        }
    })

    // 반복주기가 매주/격주일때 반복요일 출력
    $('#repeatCycle').on('change', function(){
        // alert('반복주기 선택됨');
        console.log("this.val = " + $(this).val());

        let cycle = $(this).val();
        if(cycle === 'STCY01' || cycle === 'STCY02') {
            $('#formRepeatDay').removeAttr("hidden");
        }else {
            $('#formRepeatDay').attr("hidden", "true");

            // 체크박스 없애기
            let dayList = $('input[class="day"]');

            for(let i = 0; i < dayList.length; i++) {
                if(dayList[i].checked === true) {
                    dayList[i].checked = false;
                }
            }
        }
    })

    <!-- 정기스터디 버튼 클릭시 -->
    function repeatFunction() {
        let repeatCheck = repeat[0].checked;

        console.log("repeatCheck = " + repeatCheck);

        // 정기스터디이면 true
        // 체크 true -> 종료일자/반복주기/반복요일 보여주기 (hidden = false)
        // 체크 false -> 종료일자/반복주기/반복요일 숨기기 (hidden = true)
        formEndDate[0].hidden = !repeatCheck;
        formRepeatCycle[0].hidden = !repeatCheck;
        // formRepeatDay[0].hidden = !repeatCheck;

        // 정기스터디이면 true
        if(repeatCheck == true) {
            // 기본 데이터 설정
            let end = new Date($('#startDate').val());
            end.setDate(end.getDate() + 1);

            console.log("end = " + end);

            // 최소 날짜 설정 (시작날짜 + 1일)
            let endMonth = end.getMonth()+1;
            if(endMonth < 10) endMonth = "0" + endMonth;
            let endDt = end.getDate();
            if(endDt < 10) endDt = "0" + endDt;


            // 최대 날짜 설정 (6개월)
            let maxEnd = new Date($('#startDate').val());
            maxEnd.setMonth(maxEnd.getMonth() + 6);
            console.log("maxEnd = " + maxEnd);

            let maxEndMonth = maxEnd.getMonth()+1;
            if(maxEndMonth < 10) maxEndMonth = "0" + maxEndMonth;
            let maxEndDate = maxEnd.getDate();
            if(maxEndDate < 10) maxEndDate = "0" + maxEndDate;

            endDate.val(end.getFullYear() + "-" + endMonth + "-" + endDt);
            endDate.attr("min", end.getFullYear() + "-" + endMonth + "-" + endDt);

            // 최대 6개월
            endDate.attr("max", maxEnd.getFullYear() + "-" + maxEndMonth + "-" + maxEndDate)
            repeatCycle.val('(선택)');

            // 필수 속성 정의 -> 유효성 검사
        }
        if(repeatCheck == false) {
            // 정기스터디 취소시 데이터도 모두 지우기
            endDate.val('');
            repeatCycle.val('(선택)');

            // 반복주기 select도 모두 hidden 처리
            $('option[value="STCY01"]').attr('hidden', 'true');
            $('option[value="STCY02"]').attr('hidden', 'true');
            $('option[value="STCY03"]').attr('hidden', 'true');

            // 요일 값 제거
            repeatDay.val('');

            // 요일 체크박스 제거
            let dayList = $('input[class="day"]');

            for(let i = 0; i < dayList.length; i++) {
                if(dayList[i].checked === true) {
                    dayList[i].checked = false;
                }
            }

            $('#formRepeatDay').attr('hidden', 'true');
        }
    }

    $(".day").on("click", function(e) {

        // 날짜가 클릭될때마다 전체 체크박스를 돌면서 결과값 새로 갱신

        let dayList = $('input[class="day"]');

        let days = [];

        for(let i = 0; i < dayList.length; i++) {
            if(dayList[i].checked === true) {
                days.push(dayList[i].value);
            }
        }

        console.log(days.join(','));

        $('#repeatDay').val(days.join(','));
    })


    <!-- 온오프라인 보여주기-->
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

    <!-- 온오프라인 체크시-->
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
            $('#onUrl').val('http://');

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