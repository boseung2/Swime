console.log("studyAttendService Module.....");

let studyAttendService = (function(){

    function get(param, callback, error) {

        console.log("getAttend grpSn = " + param.grpSn);
        console.log("getAttend stdSn = " + param.stdSn);
        console.log("getAttend userId = " + param.userId);

        $.get("/study/attend/get/" + param.grpSn + "/" + param.userId + "/" + param.stdSn, function (result) {
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
            url : '/study/attend/register',
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

        console.log("cancel stdSn = " + param.stdSn);
        console.log("cancel userId = " + param.userId);

        $.ajax({
            type:'post',
            url : '/study/attend/cancel',
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

    function ban(param, callback, error){

        console.log("ban stdSn = " + param.stdSn);
        console.log("ban userId = " + param.userId);

        $.ajax({
            type:'post',
            url : '/study/attend/ban',
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

    function cancelBan(param, callback, error){

        console.log("cancelBan stdSn = " + param.stdSn);
        console.log("cancelBan userId = " + param.userId);

        $.ajax({
            type:'post',
            url : '/study/attend/cancelBan',
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

    function reject(param, callback, error){

        console.log("reject stdSn = " + param.stdSn);
        console.log("reject userId = " + param.userId);

        $.ajax({
            type:'post',
            url : '/study/attend/reject',
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
        cancel : cancel,
        ban : ban,
        cancelBan : cancelBan,
        reject : reject
    };
})();