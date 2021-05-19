console.log("chatService Module.....");

let chatService = (function(){

    function getList(userId, callback, error) {

        $.get("/chat/ajaxList?userId=" + userId, function (result) {
            if (callback) {
                callback(result);
            }
        }).fail(function (xhr, status, err) {
            if (error) {
                error();
            }
        })
    }

    function getMsg(chatRoomId, callback, error) {
        $.get("/chat/getMsg?chatRoomId=" + chatRoomId, function (result) {
            if (callback) {
                callback(result);
            }
        }).fail(function (xhr, status, err) {
            if (error) {
                error();
            }
        })
    }

    function registerRoom(param, callback, error) {

        console.log("senderId = " + param.senderId);
        console.log("receiverId = " + param.receiverId);
        console.log("contents = " + param.contents);

        $.ajax({
            type : 'post',
            url : '/chat/register',
            data : JSON.stringify(param),
            contentType : "application/json; chatset=utf-8",
            success : function(result, status, xhr) {
                if(callback) {
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
        getList : getList,
        getMsg : getMsg,
        registerRoom : registerRoom
    };
})();