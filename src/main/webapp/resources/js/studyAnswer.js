console.log("studyAnswerService Module.....");

let studyAnswerService = (function(){

    function get(param, callback, error) {

        console.log("get answers");
        console.log("userId = " + param.userId);
        console.log("stdSn = " + param.stdSn);

        $.get("/study/answer/get/" + param.userId + "/" + param.stdSn , function (result) {
            if (callback) {
                callback(result);
            }
        }).fail(function (xhr, status, err) {
            if (error) {
                error();
            }
        })

    }

    function register(answerList, callback, error) {

        console.log("register answer");

        $.ajax({
            type:'post',
            url : '/study/answer/register',
            data : JSON.stringify(answerList),
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

    function remove(param, callback, error) {

        console.log("remove answer");

        $.ajax({
            type:'post',
            url : '/study/answer/remove',
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
        register : register,
        remove : remove
    };
})();