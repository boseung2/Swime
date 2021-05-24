let adminBoardListService = (function(){

    function adminBoardList(page, amount, bbs, sort, active,
                            keyword, searchResult, callback, error){
        //let page = param.page || 1;
        //let amount2 = amount || 10;

        console.log("adminBoardListCall........")
        console.log("js/page : " + page);
        console.log("js/amount : " + amount);
        console.log("js/bbs : " + bbs);
        console.log("js/sort : " + sort);
        console.log("js/active : " + active);
        console.log("js/keyword : " + keyword);
        console.log("js/searchResult :" + searchResult);
        // + "/?amount="+amount2
        $.getJSON("/admin/manageBoard/" + page + "?amount="+amount
            + "&bbs=" + bbs + "&sort=" + sort + "&active=" + active
            + "&keyword=" + keyword + "&searchResult=" + searchResult,
            function(data){
                console.log(data);
                console.dir(data);
                if(callback) {
                    if(data.boardCompare === 'isBoard'){
                        callback(data.board.boardCnt,
                            data.board.list,
                            data.boardCompare);
                    }else{
                        callback(data.reply.replyCnt,
                            data.reply.list,
                            data.replyCompare);
                    }
                    //console.log(data.reply.replyCnt);
                    // console.log(data.reply.list);
                    // console.log(data.compare);
                }
            })
            .fail(function(xhr, status, err){
                if(error){
                    error();
                }
            });

    }// end adminBoardList

    function adminBoardDelete(dataArr, bbs, callback, error){
        //traditional : 배열 보낼 때 [] 보내지는데 없애준다.
        console.log("js/"+bbs);
        let test = JSON.stringify(dataArr);
        console.log(test);

        $.ajax({
            type : 'POST',
            //traditional : true,
            url : '/admin/board/dataArr/'+"?bbs="+bbs,
            data :  JSON.stringify(dataArr),
            contentType : "application/json; charset=utf-8",
            success : function(deleteResult, status, xhr){
                let result = 'delete'+deleteResult;
                if(callback){
                    callback(result);
                }
            },
            error : function(xhr, status, er){
                if (error){
                    error(er)
                }
            }
        });

    }// end adminDelete

    function adminBoardUpdate(dataArr, bbs, callback, error){

        console.log("js/updateDataArr : "+dataArr);
        console.log("js/updateBbs : "+bbs);

        $.ajax({
            type : 'POST',
            url : '/admin/board/toActive/'+'?bbs='+bbs,
            data : JSON.stringify(dataArr),
            contentType: "application/json; charset=utf-8",
            success : function(result, status, xhr){
                let updateResult = 'update'+result;
                if(callback){
                    callback(updateResult);
                }
            },
            erorr : function(xhr, status, er){
                if (error){
                    error(er)
                }
            }
        });
    }

    function boardDisplayTime(timeValue) {

        let date = new Date(timeValue);

        let year = date.getFullYear().toString().slice(-2); //년도 뒤에 두자리
        let month = ("0" + (date.getMonth() + 1)).slice(-2); //월 2자리 (01, 02 ... 12)
        let day = ("0" + date.getDate()).slice(-2); //일 2자리 (01, 02 ... 31)
        let hour = ("0" + date.getHours()).slice(-2); //시 2자리 (00, 01 ... 23)
        let minute = ("0" + date.getMinutes()).slice(-2); //분 2자리 (00, 01 ... 59)
        let second = ("0" + date.getSeconds()).slice(-2); //초 2자리 (00, 01 ... 59)

        let returnDate = year + "/" + month + "/" + day + " "+ hour + ":" + minute + ":" + second;

        return returnDate;

    }


    return {
        adminBoardList:adminBoardList,
        boardDisplayTime:boardDisplayTime,
        adminBoardDelete:adminBoardDelete,
        adminBoardUpdate:adminBoardUpdate
    }
})();



