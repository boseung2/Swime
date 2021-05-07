// 시작일자, 종료일자 선택될때마다 반복주기 새로 넣고, 반복주기 option 없애주고, 체크박스 없애주기
$('#startDate, #endDate').on('change', function(){

    // 정기스터디일 때 시작일자가 종료일자보다 크면 alert
    if($('#repeat')[0].checked === true) {
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

        // 종료일자의 min을 초기화
        let min = new Date($('#startDate').val());
        min.setDate(min.getDate() + 1);

        let minYear = min.getFullYear();
        let minMonth = (min.getMonth()+1 < 10 ? "0" : "") + (min.getMonth()+1);
        let minDay = (min.getDate() < 10 ? "0" : "") + min.getDate();

        $('#endDate').attr("min", minYear + "-" + minMonth + "-" + minDay);

        // 종료일자의 max를 초기화
        let max = new Date($('#startDate').val());
        max.setMonth(max.getMonth() + 6);

        let maxYear = max.getFullYear();
        let maxMonth = (max.getMonth()+1 < 10 ? "0" : "") + (max.getMonth()+1);
        let maxDay = (max.getDate() < 10 ? "0" : "") + max.getDate();

        $('#endDate').attr("max", maxYear + "-" + maxMonth + "-" + maxDay);
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
    let repeatCheck = $('#repeat')[0].checked;

    console.log("repeatCheck = " + repeatCheck);

    // 정기스터디이면 true
    // 체크 true -> 종료일자/반복주기/반복요일 보여주기 (hidden = false)
    // 체크 false -> 종료일자/반복주기/반복요일 숨기기 (hidden = true)
    $('#formEndDate')[0].hidden = !repeatCheck;
    $('#formRepeatCycle')[0].hidden = !repeatCheck;

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

        $('#endDate').val(end.getFullYear() + "-" + endMonth + "-" + endDt);
        $('#endDate').attr("min", end.getFullYear() + "-" + endMonth + "-" + endDt);

        // 최대 6개월
        $('#endDate').attr("max", maxEnd.getFullYear() + "-" + maxEndMonth + "-" + maxEndDate)
        $('#repeatCycle').val('(선택)');

        // 필수 속성 정의 -> 유효성 검사
    }
    if(repeatCheck == false) {
        // 정기스터디 취소시 데이터도 모두 지우기
        $('#repeatCycle').val('(선택)');

        // select도 모두 hidden 처리
        $('option[value="STCY01"]').attr('hidden', 'true');
        $('option[value="STCY02"]').attr('hidden', 'true');
        $('option[value="STCY03"]').attr('hidden', 'true');

        // 요일 값 제거
        $('#repeatDay').val('');

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

function checkOn() {
    let on = $('#onOffCheck')[0].checked;
    console.log("on = " + on);

    $('#formUrl')[0].hidden = !on;
    $('#formPlace')[0].hidden = on;

    if(on === true) { // 온라인
        $('#onOff').val("STOF01");
        console.log("온오프 = " + $('#onOff').val());
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
        $('#onOff').val("STOF02");
        console.log("온오프 = " + $('#onOff').val());

        $('#placeId').attr("required", "required");
        $('#onUrl').removeAttr("required");

        $('#onUrl').val("");

        // 지도 보여주기
        $('#map').removeAttr("hidden");
    }
}

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
    $('input[value="선택"]').attr("hidden", true);
}

// 지참금 변경시
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

// 설문 사용 클릭시
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
