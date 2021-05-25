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
    <h3 style="margin-top: 30px;">스터디 만들기</h3>
    <hr/>
    <form role="form" id="registerForm" action="/study/register" method="post">
        <div class="form-group" hidden="true">
            <label for="grpSn">그룹번호</label>
            <input type="text" class="form-control" id="grpSn" name="grpSn" value="${grpSn}" readonly="readonly">
        </div>
        <div class="form-group" hidden="true">
            <label for="representation">작성자</label>
            <input type="text" class="form-control" id="representation" name="representation" value="${pinfo.username}" readonly="readonly">
        </div>
        <div class="form-group">
            <label for="name"><strong>스터디명</strong></label>
            <input type="text" class="form-control" id="name" name="name" required>
        </div>
        <div class="form-group" style="width: 33%; float:left">
            <label for="startDate"><strong>시작일자</strong></label>
            <input type="date" class="form-control" id="startDate" name="startDate" required>
        </div>
        <div class="form-group" style="width: 33%; float:left;">
            <label for="startTime"><strong>시작시간</strong></label>
            <input type="time" class="form-control" id="startTime" name="startTime" required>
        </div>
        <div class="form-group" style="width: 33%; float:left;">
            <label for="endTime"><strong>종료시간</strong></label>
            <input type="time" class="form-control" id="endTime" name="endTime" required>
        </div>
        <div class="form-group">
            <input type="checkbox" id="repeat" onclick="repeatFunction()">정기 스터디
        </div>
        <div class="form-group" id="formEndDate" hidden="true" style="width: 33%; float: left">
            <label for="endDate"><strong>종료일자</strong></label>
            <input type="date" class="form-control" id="endDate" name="endDate">
        </div>
        <div class="form-group" id="formRepeatCycle" hidden="true" style="width: 33%; float: left">
            <label for="repeatCycle"><strong>반복주기</strong></label>
            <select class="form-control" id="repeatCycle" name="repeatCycle">
                <option>(선택)</option>
                <option value="STCY01" hidden="true">매주</option>
                <option value="STCY02" hidden="true">격주</option>
                <option value="STCY03" hidden="true">매월</option>
            </select>
        </div>
        <div class="form-group" id="formRepeatDay" hidden="true" style="width: 33%; float: left">
            <label for="repeatDay"><strong>반복요일</strong></label><br>
            <input type="hidden" class="form-control" id="repeatDay" name="repeatDay">
            <input type="checkbox" value="월" class="day">월
            <input type="checkbox" value="화" class="day">화
            <input type="checkbox" value="수" class="day">수
            <input type="checkbox" value="목" class="day">목
            <input type="checkbox" value="금" class="day">금
            <input type="checkbox" value="토" class="day">토
            <input type="checkbox" value="일" class="day">일
        </div>
        <div class="form-group" style="clear: both">
            <label for="information"><strong>상세 정보</strong></label>
            <textarea class="form-control" rows="5" id="information" name="information" required></textarea>
        </div>
        <input type="hidden" class="form-control" id="onOff" name="onOff" value="STOF02">
        <div class="form-group">
            <input type="checkbox" id="onOffCheck" onclick="checkOn()"> 온라인스터디
        </div>
        <div class="form-group" id="formUrl" hidden="true">
            <label for="onUrl"><strong>온라인 스터디 링크 추가</strong></label>
            <input type="text" class="form-control" id="onUrl" name="onUrl" value="http://">
        </div>

        <div class="form-group" id="formPlace" style="margin-bottom: 0px">
            <label for="placeId"><strong>스터디 장소 추가</strong></label>
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

        <div class="form-group" style="margin-top: 16px;">
            <label for="expense"><strong>지참금</strong></label>
            <select class="form-control" id="expenseSelect" name="expenseSelect">
                <option>(선택)</option>
                <option value="없음">없음</option>
                <option value="추후공지">추후공지</option>
                <option value="직접입력">직접입력</option>
            </select>
            <input type="text" class="form-control" id="expense" name="expense" placeholder="원 단위로 숫자만 입력해주세요." hidden="true">
        </div>
        <div class="form-group">
            <label for="capacity"><strong>모집 인원</strong></label>
            <input type="text" class="form-control" id="capacity" name="capacity" required>
        </div>

        <!-- 설문 등록 -->
        <div class="form-group">
            <input type="checkbox" id="surveyCheck"> 가입 질문 사용하기
        </div>
        <div class="form-group questionForm" hidden="true">
            <label for="question1"><strong>질문 1.</strong></label>
            <input type="text" class="form-control" id="question1" name="question1">
        </div>
        <div class="form-group  questionForm" hidden="true">
            <label for="question2"><strong>질문 2.</strong></label>
            <input type="text" class="form-control" id="question2" name="question2">
        </div>
        <div class="form-group  questionForm" hidden="true">
            <label for="question3"><strong>질문 3.</strong></label>
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

<!-- 이벤트 처리 -->
<script type="text/javascript" src="/resources/js/register.js"></script>
<!-- 유효성검사 -->
<script type="text/javascript" src="/resources/js/studyValidation.js"></script>

<script>
    $(document).ready(function() {
        let formObj = $('#registerForm');

        $('button[type="submit"]').on("click", function(e) {
            e.preventDefault();

            // 유효성 검사
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

    // 시작시간 초기화
    hours += 1;
    hours = hours == 24 ? "00" : hours;
    hours = hours < 10 ? "0" + hours : hours;

    $('#startTime').val(hours + ":00");

    // 종료시간 초기화
    $('#endTime').val(hours + ":00");

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
                "<div style='float:right'><input type='button' onclick='placeSelected()' id='placeSelect' value='선택'></input></div>" +
                "</div>"
            )

            infowindow.open(map, marker);
        });
    }
</script>


<!-- 월 10만건 이상 유료 -->
<!-- Async script executes immediately and must be after any DOM elements used in callback. -->
<script src="https://maps.googleapis.com/maps/api/js?key=${key}&callback=initMap&libraries=places&v=weekly" async></script>
