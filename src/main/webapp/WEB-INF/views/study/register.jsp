<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<%@include file="../includes/header.jsp" %>

<script src="https://polyfill.io/v3/polyfill.min.js?features=default"></script>
<style type="text/css">
    /* Always set the map height explicitly to define the size of the div
     * element that contains the map. */
    /* 지도 사이즈 */
    #map {
        width: 100%;
        height: 400px;
    }

    /* Optional: Makes the sample page fill the window. */
    html,
    body {
        height: 100%;
        margin: 0;
        padding: 0;
    }

    /* 검색창 */
    .controls {
        background-color: #fff;
        border-radius: 2px;
        border: 1px solid transparent;
        box-shadow: 0 2px 6px rgba(0, 0, 0, 0.3);
        box-sizing: border-box;
        font-family: Roboto;
        font-size: 15px;
        font-weight: 300;
        height: 29px;
        margin-left: 17px;
        margin-top: 10px;
        outline: none;
        padding: 0 11px 0 13px;
        text-overflow: ellipsis;
        width: 50%;
    }

    .controls:focus {
        border-color: #4d90fe;
    }

    .title {
        font-weight: bold;
    }

    #infowindow-content {
        display: none;
    }

    #map #infowindow-content {
        display: inline;
    }
</style>

<div class="container">
    <h2>스터디 만들기</h2>
    <hr/>
    <form role="form" id="registerForm" action="/study/register" method="post">
        <div class="form-group">
            <label for="grpSn">그룹번호</label>
            <input type="text" class="form-control" id="grpSn" name="grpSn" value="${grpSn}" readonly="readonly">
        </div>
        <div class="form-group">
            <label for="representation">작성자</label>
            <input type="text" class="form-control" id="representation" name="representation" value="${pinfo.username}" readonly="readonly">
        </div>
        <div class="form-group">
            <label for="name">스터디명</label>
            <input type="text" class="form-control" id="name" name="name" required>
        </div>
        <div class="form-group">
            <label for="startDate">시작일자</label>
            <input type="date" class="form-control" id="startDate" name="startDate" required>
        </div>
        <div class="form-group">
            <input type="checkbox" id="repeat" onclick="repeatFunction()">정기 스터디
        </div>
        <div class="form-group" id="formEndDate" hidden="true">
            <label for="endDate">종료일자</label>
            <input type="date" class="form-control" id="endDate" name="endDate">
        </div>
        <div class="form-group" id="formRepeatCycle" hidden="true">
            <label for="repeatCycle">반복주기</label>
            <select class="form-control" id="repeatCycle" name="repeatCycle">
                <option>(선택)</option>
                <option value="STCY01" hidden="true">매주</option>
                <option value="STCY02" hidden="true">격주</option>
                <option value="STCY03" hidden="true">매월</option>
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
            <input type="time" class="form-control" id="startTime" name="startTime" required>
        </div>
        <div class="form-group">
            <label for="endTime">종료시간</label>
            <input type="time" class="form-control" id="endTime" name="endTime" required>
        </div>
        <div class="form-group">
            <label for="information">상세 정보</label>
            <textarea class="form-control" rows="5" id="information" name="information" required></textarea>
        </div>
        <input type="hidden" class="form-control" id="onOff" name="onOff" value="STOF02">
        <div class="form-group">
            <input type="checkbox" id="onOffCheck" onclick="checkOn()">온라인스터디
        </div>
        <div class="form-group" id="formUrl" hidden="true">
            <label for="onUrl">온라인 스터디 링크 추가</label>
            <input type="text" class="form-control" id="onUrl" name="onUrl" value="http://">
        </div>

        <div class="form-group" id="formPlace">
            <label for="placeId">스터디 장소 추가</label>
<%--            <input type="button" value="장소 검색" onclick="showMap()"/>--%>
            <input type="text" class="form-control" id="placeName" hidden="true" readonly/>
            <input type="text" class="form-control" id="placeId" name="placeId" hidden="true" required readonly/>
        </div>

        <div style="display: none">
            <input
                    id="pac-input"
                    class="controls"
                    type="text"
                    placeholder="장소를 입력해주세요"
            />
        </div>
        <div id="map"></div>

        <div class="form-group">
            <label for="expense">지참금</label>
            <select class="form-control" id="expenseSelect" name="expenseSelect">
                <option>(선택)</option>
                <option value="없음">없음</option>
                <option value="추후공지">추후공지</option>
                <option value="직접입력">직접입력</option>
            </select>
            <input type="text" class="form-control" id="expense" name="expense" placeholder="원 단위로 숫자만 입력해주세요." hidden="true">
        </div>
        <div class="form-group">
            <label for="capacity">모집 인원</label>
            <input type="text" class="form-control" id="capacity" name="capacity" required>
        </div>

        <!-- 설문 등록 -->
        <div class="form-group">
            <input type="checkbox" id="surveyCheck"> 가입 질문 사용하기
        </div>
        <div class="form-group questionForm" hidden="true">
            <label for="question1">질문 1.</label>
            <input type="text" class="form-control" id="question1" name="question1">
        </div>
        <div class="form-group  questionForm" hidden="true">
            <label for="question2">질문 2.</label>
            <input type="text" class="form-control" id="question2" name="question2">
        </div>
        <div class="form-group  questionForm" hidden="true">
            <label for="question3">질문 3.</label>
            <input type="text" class="form-control" id="question3" name="question3">
            <br>
            <span style="color:gray; font-size: small">- 가입 질문은 3개까지 가능합니다.</span><br>
            <span style="color:gray; font-size: small">- 멤버의 개인정보(성명, 연락처, 주소, 학교, 직장명, 출생지 등)를 확인할 수 있는 질문은 타인의 사생활을 침해할 수 있으며, 스터디 운영 목적과 무관하게 임의로 수집 및 이용한 개인정보는 법률적 문제가 발생할 수 있으므로 스터디 가입 질문은 최소한의 내용으로 작성해주시기 바랍니다.</span>
        </div>

        <hr/>

        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
        <input type="hidden" name="userId" value="${pinfo.username}">
        <input type="hidden" name="pageNum" value="<c:out value='${cri.pageNum}'/>">
        <input type="hidden" name="amount" value="<c:out value='${cri.amount}'/>">
        <button type="submit" class="btn btn-primary">등록</button>
        <a href="/group/get?pageNum=${cri.pageNum}&amount=${cri.amount}&sn=${grpSn}" class="btn btn-primary">취소</a>

    </form>
</div>

<%@include file="../includes/footer.jsp" %>

<script>
    <!-- 설문 사용 클릭시 -->
    $('#surveyCheck').on("click", function() {

        if($('#surveyCheck')[0].checked) { // 가입질문 사용시

            // 질문 form 보여주기
            let formList = $('.questionForm');
            for(let i = 0; i < formList.length; i ++) {
                formList[i].hidden = false;
            }
        } else { // 가입질문 사용 안하면

            // 질문 form 숨기기
            let formList = $('.questionForm');
            for(let i = 0; i < formList.length; i ++) {
                formList[i].hidden = true;
            }

            // 질문 값 삭제하기
            $('#question1').val("");
            $('#question2').val("");
            $('#question3').val("");
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


<!-- 유효성검사 -->
<script type="text/javascript" src="/resources/js/studyValidation.js"></script>
<script>
    $(document).ready(function() {
        let formObj = $('#registerForm');

        $('button[type="submit"]').on("click", function(e) {
            e.preventDefault();

            if(!validation()) {
                return;
            }

            formObj.submit();
        })
    })
</script>

<!-- 날짜 -->
<script type="text/javascript">

    // 오늘 날짜와 시간
    let today = new Date();

    // 오늘 년도
    let year = today.getFullYear();

    // 오늘 월
    let month = today.getMonth();
    if(month < 10) month = "0" + (month+1);

    // 오늘 날짜
    let date = today.getDate();
    if(date < 10) date = "0" + date;

    // 오늘 시간
    let hours = today.getHours();

    // 시작일자 초기화
    $('#startDate').val(year + "-" + month + "-" + date);
    $('#startDate').attr("min", year + "-" + month + "-" + date);

    // 종료일자 초기화
    $('#endDate').val(year + "-" + month + "-" + date);
    $('#endDate').attr("min", year + "-" + month + "-" + date);

    // 시작시간 초기화
    hours += 1;
    hours = hours == 24 ? "00" : hours;
    hours = hours < 10 ? "0" + hours : hours;

    $('#startTime').val(hours + ":00");

    // 종료시간 초기화
    $('#endTime').val(hours + ":00");


    <!-- 반복주기/요일 -->
    let repeat = $('#repeat');

    let formEndDate = $('#formEndDate');
    let formRepeatCycle = $('#formRepeatCycle');
    let formRepeatDay = $('#formRepeatDay');

    let endDate = $('#endDate');
    let repeatCycle = $('#repeatCycle');
    let repeatDay = $('#repeatDay');


    // 시작일자, 종료일자 선택될때마다 반복주기 새로 넣고, 반복주기 option 없애주고, 체크박스 없애주기
    $('#startDate, #endDate').on('change', function(){

        // 시작일자와 종료일자가 같지않으면 정기스터디이므로 시작일자가 종료일자보다 크면 alert
        if($('#startDate').val() !== $('#endDate').val()) {
            let start = new Date($('#startDate').val());
            let end = new Date($('#endDate').val());

            if(end < start) {
                alert('시작일자는 종료일자보다 클 수 없습니다.');

                //종료일자를 시작일자+1로 초기화
                let temp = new Date($('#startDate').val());
                temp.setDate(temp.getDate() + 1);

                let year = temp.getFullYear();
                let month = (temp.getMonth()+1 < 10 ? "0" : "") + (temp.getMonth()+1);
                let date = (temp.getDate() < 10 ? "0" : "") + temp.getDate();

                $('#endDate').val(year + "-" + month + "-" + date);
            }
        }

        // 빈복주기 옵션 추가
        setRepeatCycle();

        // 반복주기 옵션 초기화
        $('#repeatCycle').val("(선택)");

        // 반복요일값 초기화
        $('#repeatDay').val("");

        // 체크박스 체크 해제
        let days= $('input[class="day"]');
        for (let i = 0;  i < days.length; i ++) {
            days[i].checked = false;
        }

        // 반복요일 form 숨기기
        $('#formRepeatDay').attr("hidden", true);
    })


    // 반복주기가 바뀌고, 매주/격주일때 반복요일 출력
    $('#repeatCycle').on('change', function(){

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

    // 반복주기 옵션 추가 함수
    function setRepeatCycle() {
        let start = new Date($('#startDate').val());
        let end = new Date($('#endDate').val());

        // 매주
        if((end-start) / (1000 * 24 * 60 * 60) >= 7) {
            $('option[value="STCY01"]').removeAttr("hidden");
        }else {
            $('option[value="STCY01"]').attr("hidden", "true");
        }
        // 격주
        if((end-start) / (1000 * 24 * 60 * 60) >= 14) {
            $('option[value="STCY02"]').removeAttr("hidden");
        }else {
            $('option[value="STCY02"]').attr("hidden", "true");
        }

        // 매월
        // 시작일자보다 종료일자가 최소 28일이 커야하고, 달이 달라야 매월 select 생김
        if((end-start) / (1000 * 24 * 60 * 60) >= 28 && start.getMonth() !== end.getMonth()) {
            $('option[value="STCY03"]').removeAttr("hidden");
        }else {
            $('option[value="STCY03"]').attr("hidden", "true");
        }
    }

    // 정기스터디 버튼 클릭 처리함수
    function repeatFunction() {
        let repeatCheck = repeat[0].checked;

        console.log("repeatCheck = " + repeatCheck);

        // 정기스터디이면 true
        // 체크 true -> 종료일자/반복주기/반복요일 보여주기 (hidden = false)
        // 체크 false -> 종료일자/반복주기/반복요일 숨기기 (hidden = true)
        formEndDate[0].hidden = !repeatCheck;
        formRepeatCycle[0].hidden = !repeatCheck;

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

            // endDate는 startDate와 같게한다.
            endDate.val($('#startDate').val());

            repeatCycle.val('(선택)');

            // select도 모두 hidden 처리
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
            onOff.val("STOF01");
            console.log("온오프 = " + onOff.val());
            $('#onUrl').val('http://');

            $('#onUrl').attr("required", "required");
            $('#placeId').removeAttr("required");

            // place 값 제거
            $('#placeId').val("");
            $('#placeName').val("");

            // 장소 이름 지우기
            $('#placeName').attr("hidden", true);

            // 지도 제거
            $('#map').attr("hidden", true);

            // 검색창 글자 제거
            $('#pac-input').val("");

            // 말풍선 제거
            $('button[title="닫기"]').click();

        }
        if(on === false) { // 오프라인
            onOff.val("STOF02");
            console.log("온오프 = " + onOff.val());

            $('#placeId').attr("required", "required");
            $('#onUrl').removeAttr("required");

            $('#onUrl').val("");

            // 지도 보여주기
            $('#map').removeAttr("hidden");
        }
    }
</script>

<!-- 구글맵 -->
<script>

    function initMap() {
        // 지도 설정
        const map = new google.maps.Map(document.getElementById("map"), {
            center: { lat: 37.5704121, lng: 126.9853267 },
            zoom: 13,
        });

        // 검색창
        const input = document.getElementById("pac-input");
        const autocomplete = new google.maps.places.Autocomplete(input);
        autocomplete.bindTo("bounds", map);

        // Specify just the place data fields that you need.
        autocomplete.setFields(["place_id", "geometry", "name", "formatted_address", "url"]);
        map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

        // 말풍선 정보
        const infowindow = new google.maps.InfoWindow();
        const infowindowContent = document.getElementById("infowindow-content");
        infowindow.setContent(infowindowContent);

        // 마커
        const marker = new google.maps.Marker({ map: map });
        marker.addListener("click", () => { // 마커 클릭시
            infowindow.open(map, marker);
        });
        autocomplete.addListener("place_changed", () => { // 장소 선택시
            infowindow.close();
            const place = autocomplete.getPlace(); // 장소 세부정보 받아오기

            if (!place.geometry || !place.geometry.location) {
                return;
            }

            if (place.geometry.viewport) {
                map.fitBounds(place.geometry.viewport);
            } else {
                map.setCenter(place.geometry.location);
                map.setZoom(17);
            }
            // Set the position of the marker using the place ID and location.
            // 장소 세팅
            marker.setPlace({
                placeId: place.place_id,
                location: place.geometry.location,
            });

            marker.setVisible(true);

            infowindow.setContent(
                "<div>" +
                "<strong><span id='place-name'>" + place.name + "</span></strong><br>" +
                "<span id='place-id' hidden='true'>" + place.place_id +"</span>" +
                "<strong>주소: </strong><span>" + place.formatted_address + "</span><br>" +
                "<strong>URL: </strong><a href='" + place.url + "'>구글맵 바로가기</a><br>" +
                "<input type='button' onclick='placeSelected()' id='placeSelect' value='선택'></input>" +
                "</div>"
            )

            infowindow.open(map, marker);
        });
    }
</script>

<script>
    function placeSelected() {
        console.log('장소가 선택되었음');

        // 선택된 것 보여줌
        let placeName = document.getElementById("placeName");
        let placeId = document.getElementById("placeId");

        placeName.value = document.getElementById("place-name").innerText;
        placeId.value = document.getElementById("place-id").innerText;

        // placeResult 보여주기
        $('#placeName').removeAttr("hidden");

        console.log("placeId= " + $('#placeId').val());

        // 선택 버튼 없애기
        $('#placeSelect').attr("hidden", true);

    }
</script>


<!-- 월 10만건 이상 유료 -->
<!-- Async script executes immediately and must be after any DOM elements used in callback. -->
<script src="https://maps.googleapis.com/maps/api/js?key=${key}&callback=initMap&libraries=places&v=weekly" async></script>
