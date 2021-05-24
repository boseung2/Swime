console.log("noticeService Module.....");

let noticeService = (function(){

    function register(param, callback, error){

        console.log(param.sender);
        console.log(param.receiver);
        console.log(param.kind);
        console.log(param.url);
        console.log(param.content);

        $.ajax({
            type:'post',
            url : '/notice/register',
            data : JSON.stringify(param),
            contentType : "application/json; charset = utf-8",
            success : function(result, status, xhr) {
            if (callback) {

                console.log("notice register = " + result);

                // 실시간 알림 전송
                noticeSocket.send(param.receiver + "," + param.kind + "," + param.url + "," + param.content);

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

    function getList(userId, callback, error) {
        $.getJSON("/notice/list/" + userId + ".json",
            function(data) {
                if(callback) {
                    callback(data);
                }
            }).fail(function(xhr, status, err) {
            if(error) {
                error();
            }
        })
    }

    function modify(param, callback, error){

        $.ajax({
            type:'post',
            url : '/notice/modify/',
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
        register : register,
        getList : getList,
        modify : modify
    };
})();