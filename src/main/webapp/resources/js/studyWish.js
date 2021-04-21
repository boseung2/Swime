console.log("studyWishService Module.....");

let studyWishService = (function(){

    function getWish(param, callback, error) {

        console.log("getwish stdSn = " + param.stdSn);
        console.log("getwish userId = " + param.userId);

        $.get("/study/wish/" + param.stdSn + "/" + param.userId, function (result) {
            if (callback) {
                console.log("studyWishService result = " + result);
                callback(result);
            }
        }).fail(function (xhr, status, err) {
            if (error) {
                error();
            }
        })
    }

    function wish(param, callback, error){

        console.log("wish stdSn = " + param.stdSn);
        console.log("wish userId = " + param.userId);

        $.ajax({
            type:'post',
            url : '/study/wish',
            data : JSON.stringify(param),
            contentType : "application/json; charset = utf-8",
            success : function(result, status, xhr) {
            if (callback) {
                console.log(result);
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
        getWish : getWish,
        wish : wish
    };
})();