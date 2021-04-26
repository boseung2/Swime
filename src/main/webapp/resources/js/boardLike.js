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
    }//end add

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
        remove:remove
    }

})(); //end boardLikeService