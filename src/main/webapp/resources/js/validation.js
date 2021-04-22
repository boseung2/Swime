console.log("validate.js ...")

src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js";




function checkLength(input, min, max, textPlaceDiv, textPlace, msg) {
    if(input === undefined) return;
    let stringLength = getByte(input.value);

    if (stringLength === 0 || stringLength === undefined) {
        showErrorMsg(textPlaceDiv, textPlace, msg + "의 값이 유효하지 않습니다");
    }
    if (stringLength > max){
        showErrorMsg(textPlaceDiv, textPlace, msg + "의 글자수가 " + max + "보다 큽니다");
        return false;
    }
    if (stringLength < min){
        showErrorMsg(textPlaceDiv, textPlace, msg + "의 글자수는 " + (min - 1) + "보다 커야 합니다");
        return false;
    }
    return true
}





function getByte(str) {
    let byte = 0;
    for (let i=0; i<str.length; ++i) {
        (str.charCodeAt(i) > 127) ? byte += 3 : byte++ ;
    }
    return byte;
}

// function validatePassword(password, confirm_password){
//
//     if(!isEqual(password, confirm_password)) {
//         confirm_password.setCustomValidity("비밀번호가 일치하지 않습니다");
//         console.log("비밀번호가 일치하지 않습니다");
//     }
// }

function isEqual(password, confirm_password){
    console.log(password.value === confirm_password.value);
    if(password.value === confirm_password.value) return true;
    else if(!(password.value === confirm_password.value)) return false;
}

function isNull(){
    for (let i = 0; i < arguments.length; i++) {
        if(arguments[i].value === null || arguments[i].value === '' || arguments[i].value === undefined) return true;
    }
    return false;
}

function isChecked() {
    for (let i = 0; i < arguments.length; i++) {
        if(arguments[i].checked === true) return true;
    }
    return false;
}


function showErrorMsg(textPlaceDiv, textPlace, msg) {
    $(textPlaceDiv).show();
    $(textPlace).html(msg);
}