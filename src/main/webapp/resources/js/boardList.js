console.log("boardList Module");

let boardListService = (function(){

    function getList(param, callback, error){

        let grpSn = param.grpSn;
        let page = param.page || 1;

        console.log("BrdParam : " + param);
        console.log("BrdGrpSN : " + grpSn);
        console.log("BrdPage : " + page);

        $.getJSON("/board/list/" + grpSn + "/" + page + ".json",
            function(data){
                if(callback) {
                    //boardCnt 변수명 이따가 확인하기
                    callback(data.boardCnt, data.list);
                }
            }),fail(function(xhr, status, err){
                if(error){
                    error();
                }
        });
    }
    return {
        getList:getList
    };
})();