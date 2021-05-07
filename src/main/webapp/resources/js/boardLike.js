console.log("boardLike Module")

let boardLikeService = (function(){

    function add(boardLike, callback, error){
        console.log("boardAdd......");

        console.log(boardLike.brdSn);
        console.log(boardLike.userId);
        $.ajax({
            type: 'POST',
            url: '/board/createLike',
            data: JSON.stringify(boardLike),
            contentType : "application/json; charset = utf-8",
            success : function(result, status, xhr){
                if(callback){
                    //result :..
                    console.log(result);
                    callback(result)
                }
            },
            error : function(xhr, status, er){
                console.log(xhr);
                console.log(status);
                console.log(er);
                if(error){
                    error(er);
                }
            }

        });
    }//end add

    function getLike(param, callback, error){

        console.log("brdSn : " + param.brdSn);
        console.log("userId : " + param.userId);

        $.get("/board/like/" + param.brdSn + "/" + param.userId, function (result) {

            if (callback) {
                console.log("js/likeResult : " + result);
                callback(result);
            }
        }).fail(function (xhr, status, err) {
            if (error) {
                error();
            }
        })

    }

    //remove 필요 없고 한번에 추가 삭제 가능 나중에 이거 지우기.
    function remove(boardLike, callback, error){
        console.log("boardAdd......");

        console.log(boardLike.brdSn);
        console.log(boardLike.userId);
        $.ajax({
            type: 'POST',
            url: '/board/removeLike',
            data: JSON.stringify(boardLike),
            contentType : "application/json; charset = utf-8",
            success : function(result, status, xhr){
                if(callback){
                    //result : success 나오는군..
                    console.log("success : "+result);
                    callback(result)
                }
            },
            error : function(xhr, status, er){
                console.log(xhr);
                console.log(status);
                console.log(er);
                if(error){
                    error(er);
                }
            }

        });
    }//end remove

        return{
        add:add,
        getLike:getLike,
        remove:remove
    }

})(); //end boardLikeService