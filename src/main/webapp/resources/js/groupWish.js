console.log("groupWish module......");
let groupWishService = (function(){

    function add (groupWish, callback, error) {

        $.ajax({
            type : 'post',
            url : '/groupWish/new',
            data : JSON.stringify(groupWish),
            contentType : "application/json; charset=utf-8",
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

    function get (groupWish, callback, error) {
        let grpSn = groupWish.grpSn;
        let userId = groupWish.userId;

        $.getJSON("/groupWish/get/" + grpSn + "/" + userId + ".json",
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

    function remove(groupWish, callback, error) {
        let grpSn = groupWish.grpSn;
        let userId = groupWish.userId;
        $.ajax({
            type : 'delete',
            url : '/groupWish/delete/' + grpSn + "/" + userId,
            success : function(deleteResult, status, xhr) {
                if(callback) {
                    callback(deleteResult);
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
        add : add,
        get : get,
        remove : remove,
    }
})();