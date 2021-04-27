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

    return {
        get : get
    };
})();