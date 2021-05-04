console.log('validation check....');

function validation() {

    if($('#name').val() == "" || $('#name').val().replaceAll(" ", "").length == 0) {
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

    // 시작일자와 시작시간이 현재날짜와 시간보다 커야함
    // 시작일자
    let startDate = $('#startDate').val();

    // 현재날짜
    let temp = new Date();
    let currDate = temp.getFullYear() + "-";
    currDate += ((temp.getMonth() + 1) < 10 ? "0" : "") + (temp.getMonth() + 1) + "-";
    currDate += (temp.getDate() < 10 ? "0" : "") + temp.getDate();

    // 시작시간
    let startTime = $('#startTime').val();

    // 현재시간
    let currTime = (temp.getHours() < 10 ? "0" : "") + temp.getHours() + ":";
    currTime += (temp.getMinutes() < 10 ? "0" : "") + temp.getMinutes();


    if(startDate < currDate) {
        alert('시작일자가 현재날짜보다 이전일 수 없습니다.');
        return false;
    }else if(startDate == currDate) {

        // 시작일자와 현재날짜가 같고, 시작시간이 현재시간보다 앞선 경우
        if(startTime < currTime) {
            alert('시작일자가 현재날짜보다 이전일 수 없습니다.');
            return false;
        }
    }

    // 반복주기가 선택일때 빈문자열로 초기화
    if ($('#repeatCycle').val() === '(선택)') {
        $('#repeatCycle').val("");
    }

    // 정기스터디이면
    if($('#repeat').is(":checked")) {
        // 종료일자가 시작일자보다 커야함
        let date1 = new Date($('#startDate').val());
        let date2 = new Date($('#endDate').val());

        if(date1 === date2) {
            alert("정기스터디에서 시작일자와 종료일자는 같을 수 없습니다.")
            return false;
        }else if(date1 > date2) {
            alert('시작 일자가 종료 일자보다 빠를 수 없습니다.');
            return false;
        }

        // 매주/격주일때 반복요일 하나는 필수
        if($('#repeatCycle').val() =='STCY01' || $('#repeatCycle').val() =='STCY02') {
            if($('#repeatDay').val().length < 1) {
                alert('반복요일을 선택해주세요.');
                return false;
            }
        }
    }else {
        // 정기스터디 아니면 시작일자와 종료일자를 동일하게
        $('#endDate').val($('#startDate').val());
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


    if($('#information').val() == "" || $('#information').val().replaceAll(" ", "").length == 0) {
        alert("상세정보를 입력해주세요");
        return false;
    } else if($('#information').val().length > 1000) {
        alert("상세정보를 1000자 이하로 작성해주세요");
        return false;
    }else {
        let infoTemp = $('#information').val().trim().toString();
        infoTemp = removeTag(infoTemp);
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

    // 지참금 선택일때 빈문자열로 초기화
    if ($('#expenseSelect').val() === '(선택)') {
        $('#expenseSelect').val("");
    }

    if($('#expense').val().length > 10) {
        alert("지참금 정보는 10자 이내여야합니다.");
        return false;

    }else if($('#expenseSelect').val() === '직접입력') {
        let str = $('#expense').val();

        if(str.length <= 0) {
            alert('금액을 입력해주세요');
            return false;
        }
        
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

    // 가입질문 사용하는 경우
    if($('#surveyCheck')[0].checked) {

        if($('#question1').val() === '' && $('#question2').val() === '' && $('#question3').val() === '') {
            alert('가입 질문은 최소 한개 이상 입력되어야합니다.');
            return false;
        }else if($('#question1').val().length > 50 || $('#question2').val().length > 50 || $('#question3').val().length > 50) {
            alert('가입 질문은 50자 이내여야합니다.');
            return false;
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