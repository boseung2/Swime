console.log("boardList Module");

let boardListService = (function(){

    function getList(param, callback, error){

        let grpSn = param.grpSn;
        let page = param.page || 1;

        console.log("BrdParam : " + JSON.stringify(param));
        console.log("BrdGrpSN : " + grpSn);
        console.log("BrdPage : " + page);

        $.getJSON("/board/list/" + grpSn + "/" + page + ".json",
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

    };


    function boardDisplayTime(timeValue){
        let today = new Date();

        let gap = today.getTime() - timeValue;

        let dateObj = new Date(timeValue);

        let str = "";

        if(gap < (1000 * 60 * 60 * 24)){
            let hh = dateObj.getHours();
            let mi = dateObj.getMinutes();
            let ss = dateObj.getSeconds();

            return [(hh > 9 ? '' : '0') + hh, ':', (mi > 9? '' : '0') + mi, ':',
                (ss > 9 ? '' : '0') + ss].join('');
        }else{
            let yy = dateObj.getFullYear();
            let mm = dateObj.getMonth() +1;
            let dd = dateObj.getDate();

            return [yy, '-', (mm > 9 ? '':'0') + mm, '-', (dd > 9? '' : '0') +dd].join('');
        }
    };


    return {
        getList:getList,
        boardDisplayTime : boardDisplayTime
    };
})();