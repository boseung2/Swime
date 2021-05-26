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
    <h3 style="margin-top: 30px;">스터디 수정</h3>
    <hr/>
    <form role="form" id="modifyForm" action="/study/modify" method="post">
        <div class="form-group" hidden="true">
            <label for="sn">스터디번호</label>
            <input type="text" class="form-control" id="sn" name="sn" value="${study.sn}" readonly="readonly">
        </div>
        <div class="form-group" hidden="true">
            <label for="grpSn">그룹번호</label>
            <input type="text" class="form-control" id="grpSn" name="grpSn" value="${study.grpSn}" readonly="readonly">
        </div>
        <div class="form-group" hidden="true">
            <label for="representation">작성자</label>
            <input type="text" class="form-control" id="representation" name="representation" value="${study.representation}" readonly="readonly">
        </div>
        <div class="form-group">
            <label for="name"><strong>스터디명</strong></label>
            <input type="text" class="form-control" id="name" name="name" value="${study.name}" required>
        </div>
        <div class="form-group" style="width: 33%; float:left">
            <label for="startDate"><strong>시작일자</strong></label>
            <input type="date" class="form-control" id="startDate" name="startDate" value="${study.startDate}" required>
        </div>
        <div class="form-group" style="width: 33%; float:left">
            <label for="startTime"><strong>시작시간</strong></label>
            <input type="time" class="form-control" id="startTime" name="startTime" value="${study.startTime}" required>
        </div>
        <div class="form-group" style="width: 33%; float:left">
            <label for="endTime"><strong>종료시간</strong></label>
            <input type="time" class="form-control" id="endTime" name="endTime" value="${study.endTime}" required>
        </div>
        <div class="form-group">
            <input type="checkbox" id="repeat" onclick="repeatFunction()">정기 스터디
        </div>
        <div class="form-group" id="formEndDate" hidden="true" style="width: 33%; float:left">
            <label for="endDate"><strong>종료일자</strong></label>
            <input type="date" class="form-control" id="endDate" name="endDate" value="${study.endDate}">
        </div>
        <div class="form-group" id="formRepeatCycle" hidden="true" style="width: 33%; float:left">
            <label for="repeatCycle"><strong>반복주기</strong></label>
            <select class="form-control" id="repeatCycle" name="repeatCycle" value="${study.repeatCycle}">
                <option>(선택)</option>
                <option value="STCY01" hidden="true">매주</option>
                <option value="STCY02" hidden="true">격주</option>
                <option value="STCY03" hidden="true">매월</option>
            </select>
        </div>
        <div class="form-group" id="formRepeatDay" hidden="true" style="width: 33%; float:left">
            <label for="repeatDay"><strong>반복요일</strong></label><br>
            <input type="hidden" class="form-control" id="repeatDay" name="repeatDay" value="${study.repeatDay}">
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
            <textarea class="form-control" rows="5" id="information" name="information" required>${study.information}</textarea>
        </div>
        <input type="hidden" class="form-control" id="onOff" name="onOff" value="${study.onOff}">
        <div class="form-group">
            <input type="checkbox" id="onOffCheck" onclick="checkOn()">온라인스터디
        </div>
        <div class="form-group" id="formUrl" hidden="true">
            <label for="onUrl"><strong>온라인 스터디 링크 추가</strong></label>
            <input type="text" class="form-control" id="onUrl" name="onUrl" value="${study.onUrl}">
        </div>
        <div class="form-group" id="formPlace" style="margin-bottom: 0px">
            <label for="placeId"><strong>스터디 장소 추가</strong></label>
            <input type="text" class="form-control" id="placeName" hidden="true" readonly/>
            <input type="text" class="form-control" id="placeId" name="placeId" value="${study.placeId}" hidden="true" readonly/>
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
                <option value="(선택)">(선택)</option>
                <option class="expense" value="없음">없음</option>
                <option class="expense" value="추후공지">추후공지</option>
                <option value="직접입력">직접입력</option>
            </select>
            <input type="text" class="form-control" id="expense" name="expense" placeholder="원 단위로 숫자만 입력해주세요." hidden="true" value="${study.expense}">
        </div>
        <div class="form-group">
            <label for="capacity"><strong>모집 인원</strong></label>
            <input type="text" class="form-control" id="capacity" name="capacity" value="${study.capacity}" required>
        </div>

        <!-- 설문 등록 -->
        <div class="form-group">
            <input type="checkbox" id="surveyCheck"> 가입 질문 사용하기
        </div>
        <div class="form-group questionForm" hidden="true">
            <label for="question1"><strong>질문 1.</strong></label>
            <input type="text" class="form-control" id="question1" name="question1" value="${question1.question}">
        </div>
        <div class="form-group  questionForm" hidden="true">
            <label for="question2"><strong>질문 2.</strong></label>
            <input type="text" class="form-control" id="question2" name="question2" value="${question2.question}">
        </div>
        <div class="form-group  questionForm" hidden="true">
            <label for="question3"><strong>질문 3.</strong></label>
            <input type="text" class="form-control" id="question3" name="question3" value="${question3.question}">
            <br>
            <span style="color:gray; font-size: small">- 가입 질문은 3개까지 가능합니다.</span><br>
            <span style="color:gray; font-size: small">- 멤버의 개인정보(성명, 연락처, 주소, 학교, 직장명, 출생지 등)를 확인할 수 있는 질문은 타인의 사생활을 침해할 수 있으며, 스터디 운영 목적과 무관하게 임의로 수집 및 이용한 개인정보는 법률적 문제가 발생할 수 있으므로 스터디 가입 질문은 최소한의 내용으로 작성해주시기 바랍니다.</span>
        </div>

        <hr/>

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

<!-- 이벤트 처리 -->
<script type="text/javascript" src="/resources/js/register.js"></script>
<!-- 유효성검사 -->
<script type="text/javascript" src="/resources/js/studyValidation.js"></script>


<script>
    // 제출시
    $(document).ready(function() {
        let formObj = $('#modifyForm');

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

<script>
    $(document).ready(function() {

        // 정기스터디 보여주기
        // 시작일자보다 종료일자가 크면 정기스터디
        let startDateVal = new Date($('#startDate').val());
        let endDateVal = new Date($('#endDate').val());

        if(startDateVal < endDateVal){

            // 정기스터디 체크, 종료일자, 반복주기 보여주기
            $('#repeat').prop("checked", true);
            $('#formEndDate').removeAttr("hidden");
            $('#formRepeatCycle').removeAttr("hidden");

            // 반복주기 옵션 select 추가
            let start = new Date($('#startDate').val());
            let end = new Date($('#endDate').val());

            if((end-start) / (1000 * 24 * 60 * 60) >= 7) { // 매주
                $('option[value="STCY01"]').removeAttr("hidden");
            }
            if((end-start) / (1000 * 24 * 60 * 60) >= 14) { // 격주
                $('option[value="STCY02"]').removeAttr("hidden");
            }

            // 매월
            // 시작일자보다 종료일자가 최소 28일이 커야하고, 달이 달라야 매월 select 생김
            if((end-start) / (1000 * 24 * 60 * 60) >= 28 && start.getMonth() !== end.getMonth()) {
                $('option[value="STCY03"]').removeAttr("hidden");
            }

            // 반복주기 보여주기
            if("STCY01" === "${study.repeatCycle}") {
                $('option[value="STCY01"]').attr("selected", true);
            }else if("STCY02" === "${study.repeatCycle}") {
                $('option[value="STCY02"]').attr("selected", true);
            }else if("STCY03" === "${study.repeatCycle}") {
                $('option[value="STCY03"]').attr("selected", true);
            }

            // 반복요일 보여주기
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

        //온오프라인 보여주기
        console.log("${study.onOff}");

        if("STOF01" === "${study.onOff}") {
            //온라인 스터디에 체크
            $('#onOffCheck').attr("checked", "checked");

            // formUrl 보여주기
            $('#formUrl')[0].hidden = false;
            $('#formPlace')[0].hidden = true;

            // 지도 hidden 처리
            $('#map').attr("hidden", true);

            //placeName hidden 처리
            $('#placeName').attr("hidden", true);
        }
        if("STOF02" === "${study.onOff}") {
            //온라인 스터디에 체크 없애기
            $('#onOffCheck').removeAttr("checked");

            // formPlace 보여주기
            $('#formUrl')[0].hidden = true;
            $('#formPlace')[0].hidden = false;

            // placeName 보여주기
            $('#placeName').removeAttr("hidden");
        }

        // 지참금 보여주기
        // null인경우 (선택) 출력
        if("" === "${study.expense}") {
            $('option[value="(선택)"]').prop("selected", true);

        }
        // 직접 입력인 경우 금액입력창 보여주기
        else if("없음" !== "${study.expense}" && "추후공지" !== "${study.expense}") {
            $('option[value="직접입력"]').prop("selected", true);
            $('#expense').removeAttr("hidden");
        }
        else {
            let selectList = $('option[class="expense"]');

            // 그 외의 경우 옵션 선택
            for(let i = 0; i < selectList.length; i++) {
                if(selectList[i].value === "${study.expense}") {
                    selectList[i].selected = true;
                }
            }
        }

        // 질문 하나라도 있으면 설문 보여주기
        if("${question1}" !== '' || "${question2}" !== '' || "${question3}" !== '') {

            // 체크박스 체크
            $('#surveyCheck').attr("checked", true);

            // 질문 form 보여주기
            let formList = $('.questionForm');
            for(let i = 0; i < formList.length; i ++) {
                formList[i].hidden = false;
            }
        }

    })
</script>

<!-- 구글 맵 -->
<script>
    window.onload = function () {
        if("${study.placeId}" !== "") { // 이전 정보가 있으면 해당 장소를 출력
            initMap("${study.placeId}");
        }else {
            // 없으면 기본 지도를 출력
            registerMap();
        }
    }
</script>

<script>
    function initMap(oldPlaceId) {
        // 기존 place 정보가 있으면 placeId 사용

        const map = new google.maps.Map(document.getElementById("map"), {
            center: { lat: -33.866, lng: 151.196 },
            zoom: 15,
        });

        const request = {
            placeId: oldPlaceId,
            fields: ["name", "formatted_address", "place_id", "geometry", "url"],
        };

        const infowindow = new google.maps.InfoWindow();
        const service = new google.maps.places.PlacesService(map);


        service.getDetails(request, (place, status) => { // 세부정보 가져오기
            if (
                status === google.maps.places.PlacesServiceStatus.OK &&
                place &&
                place.geometry &&
                place.geometry.location
            ) {

                // 가져온 세부 정보로 지도 띄우기
                const map = new google.maps.Map(document.getElementById("map"), {
                    center: place.geometry.location,
                    zoom: 15,
                });

                // 검색창
                const input = document.getElementById("pac-input");
                const autocomplete = new google.maps.places.Autocomplete(input);
                autocomplete.bindTo("bounds", map);

                // 필요한 정보
                autocomplete.setFields(["place_id", "geometry", "name", "formatted_address", "url"]);
                map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

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

                    // 마커에 위치 다시 세팅
                    marker.setPlace({
                        placeId: place.place_id,
                        location: place.geometry.location,
                    });

                    marker.setVisible(true);

                    // 말풍선 다시 세팅
                    infowindow.setContent(
                        "<div>" +
                        "<strong><span id='place-name'>" + place.name + "</span></strong><br>" +
                        "<span id='place-id' hidden='true'>" + place.place_id +"</span>" +
                        "<strong>주소: </strong><span>" + place.formatted_address + "</span><br>" +
                        "<strong>URL: </strong><a href='" + place.url + "'>구글맵 바로가기</a><br>" +
                        "<div style='float:right'><input type='button' onclick='placeSelected()' value='선택'></input></div>" +
                        "</div>"
                    )

                    infowindow.open(map, marker);
                });

                const marker = new google.maps.Marker({ // 마커 위치 설정
                    map,
                    position: place.geometry.location,
                });

                marker.setVisible(true);

                infowindow.setContent(
                    "<div><strong>" +
                    place.name +
                    "</strong><br>" +
                    "<strong>주소: </strong><span>" + place.formatted_address + "</span><br>" +
                    "<strong>URL: </strong><a href='" + place.url + "'>구글맵 바로가기</a><br>" +
                    "</div>"
                )

                infowindow.open(map, marker);

                document.getElementById("placeName").value = place.name;
            }
        });
    }
</script>


<script>
    function registerMap() {
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
                "<div style='float:right'><input type='button' onclick='placeSelected()' value='선택'></div>" +
                "</div>"
            )

            infowindow.open(map, marker);
        });
    }
</script>

<script
        src="https://maps.googleapis.com/maps/api/js?key=${key}&libraries=places&v=weekly"
        async
></script>