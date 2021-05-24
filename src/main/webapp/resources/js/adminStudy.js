console.log("adminStudyService Module.....");

let adminStudyService = (function(){

    function getTotalList(param, callback, error){

        let pageNum = param.pageNum;
        let amount = param.amount;

        console.log("pageNum = " + pageNum);
        console.log("amount = " + amount);

        $.get("/admin/manage-study/totalList/" + pageNum + "/" + amount, function(result){
            if(callback) {
                callback(result.studyCnt, result.studyList);
            }
        })
        .fail(function(xhr, status, err){
            if(error){
                error();
            }
        });

    }

    return {
        getTotalList:getTotalList
    }
})();



