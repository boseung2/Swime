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

    function getAttendListWithPaging(stdSn, callback, error) {

        // stdSn, pageNum(1), amount(10) 필요
        console.log("getAttendListWithPaging stdSn = " + stdSn);

        $.get("/study/attendList/" + stdSn + '/' + 1 + '/' + 10, function (result) {
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

    function getBanList(stdSn, callback, error) {

        console.log("getBanList stdSn = " + stdSn);

        $.get("/study/banList/" + stdSn, function (result) {
            if (callback) {
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
        getWaitingList : getWaitingList,
        getAttendListWithPaging : getAttendListWithPaging,
        getBanList : getBanList
    };
})();