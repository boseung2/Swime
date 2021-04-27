console.log("studyMemberService Module.....");

let studyMemberService = (function(){

    function getAttendList(stdSn, callback, error) {

        console.log("getAttendList stdSn = " + stdSn);

        $.get("/study/attendList/" + stdSn, function (result) {
            if (callback) {
                callback(result);
            }
        }).fail(function (xhr, status, err) {
            if (error) {
                error();
            }
        })
    }

    function getWaitingList(stdSn, callback, error) {

        console.log("getWaitingList stdSn = " + stdSn);

        $.get("/study/waitingList/" + stdSn, function (result) {
            if (callback) {
                console.log("getAttendList result = " + result);
                callback(result);
            }
        }).fail(function (xhr, status, err) {
            if (error) {
                error();
            }
        })
    }

    return {
        getAttendList : getAttendList,
        getWaitingList : getWaitingList
    };
})();