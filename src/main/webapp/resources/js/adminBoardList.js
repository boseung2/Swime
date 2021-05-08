let adminBoardListService = (function(){

    function adminBoardList(page, amount, bbs, callback, error){
        //let page = param.page || 1;
        //let amount2 = amount || 10;

        console.log("adminBoardListCall........")
        console.log("js/page : " + page);
        console.log("js/amount : " + amount);
        console.log("js/bbs : " + bbs);
        // + "/?amount="+amount2
        $.getJSON("/admin/manageBoard/" + page + "?amount="+amount + "&bbs="+bbs,
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
        boardDisplayTime:boardDisplayTime
    }
})();




// let adminBoardListService = (function(){
//
//     function adminBoardList(page, amount, bbs, callback, error){
//         //let page = param.page || 1;
//         //let amount2 = amount || 10;
//
//         console.log("adminBoardListCall........")
//         console.log("js/page : " + page);
//         console.log("js/amount : " + amount);
//         console.log("js/bbs : " + bbs);
//         // + "/?amount="+amount2
//         $.getJSON("/admin/manageBoard/" + page + "?amount="+amount + "&bbs="+bbs,
//             function(data){
//                 // console.log(data);
//                 // console.dir(data);
//
//                 if(callback) {
//                     callback(data.boardCnt, data.list,
//                         data.replyCnt,data.replyList);
//                     console.log(data.board.boardCnt);
//                     console.log(data.board.list);
//                     console.log(data.compare);
//
//                 }
//             })
//             .fail(function(xhr, status, err){
//                 if(error){
//                     error();
//                 }
//             });
//
//     }// end adminBoardList
//
//     function boardDisplayTime(timeValue) {
//
//         let date = new Date(timeValue);
//
//         let year = date.getFullYear().toString().slice(-2); //년도 뒤에 두자리
//         let month = ("0" + (date.getMonth() + 1)).slice(-2); //월 2자리 (01, 02 ... 12)
//         let day = ("0" + date.getDate()).slice(-2); //일 2자리 (01, 02 ... 31)
//         let hour = ("0" + date.getHours()).slice(-2); //시 2자리 (00, 01 ... 23)
//         let minute = ("0" + date.getMinutes()).slice(-2); //분 2자리 (00, 01 ... 59)
//         let second = ("0" + date.getSeconds()).slice(-2); //초 2자리 (00, 01 ... 59)
//
//         let returnDate = year + "/" + month + "/" + day + " "+ hour + ":" + minute + ":" + second;
//
//         return returnDate;
//
//     }
//
//
//     return {
//         adminBoardList:adminBoardList,
//         boardDisplayTime:boardDisplayTime
//     }
// })();