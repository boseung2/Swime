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
                socket.send(param.receiver + "," + param.kind + "," + param.url + "," + param.content);

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
        register : register
    };
})();