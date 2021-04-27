console.log("studyAttendService Module.....");

let studyAttendService = (function(){

    function get(param, callback, error) {

        console.log("getAttend grpSn = " + param.grpSn);
        console.log("getAttend stdSn = " + param.stdSn);
        console.log("getAttend userId = " + param.userId);

        $.get("/study/getAttend/" + param.grpSn + "/" + param.userId + "/" + param.stdSn, function (result) {
            if (callback) {
                console.log("getAttend result = " + result);
                callback(result);
            }
        }).fail(function (xhr, status, err) {
            if (error) {
                error();
            }
        })
    }

    function attend(param, callback, error){

        console.log('attend 호출됨');

        console.log("attend stdSn = " + param.stdSn);
        console.log("attend userId = " + param.userId);

        $.ajax({
            type:'post',
            url : '/study/attend',
            data : JSON.stringify(param),
            contentType : "application/json; charset = utf-8",
            success : function(result, status, xhr) {
                if (callback) {
                    callback(result);
                }
            },
            error : function(xhr, status, er) {
                if(error) {
                    error(er);
                }
            }
        })
    }

    function cancel(param, callback, error){

        console.log('cancel 호출됨');

        console.log("cancel stdSn = " + param.stdSn);
        console.log("cancel userId = " + param.userId);

        $.ajax({
            type:'post',
            url : '/study/cancel',
            data : JSON.stringify(param),
            contentType : "application/json; charset = utf-8",
            success : function(result, status, xhr) {
                if (callback) {
                    callback(result);
                }
            },
            error : function(xhr, status, er) {
                if(error) {
                    error(er);
                }
            }
        })
    }

    return {
        get : get,
        attend : attend,
        cancel : cancel
    };
})();