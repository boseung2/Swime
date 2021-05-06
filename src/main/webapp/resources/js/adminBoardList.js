console.log("adminBoardList Module");

let adminBoardListService = (function(){

    function adminBoardList(param, callback, error){

        let brdSn = param.grpSn;
        let page = param.page || 1;

        console.log("BrdParam : " + JSON.stringify(param));
        console.log("BrdGrpSN : " + brdSn);
        console.log("BrdPage : " + page);

        $.getJSON("/serviceCenter/admin/" + brdSn + "/" + page + ".json",
            function(data){
                if(callback) {
                    //boardCnt 변수명 이따가 확인하기
                    console.log("js/boardCnt : "+data.boardCnt);
                    console.log("js/boardList"+data.list);
                    callback(data.boardCnt, data.list);
                }
            })
            .fail(function(xhr, status, err){
                if(error){
                    error();
                }
            });

    }

    return {
        adminBoardList:adminBoardList
    }
})();