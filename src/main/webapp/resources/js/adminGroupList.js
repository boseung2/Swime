console.log("groupList Module");

let adminGroupListService = (function(){
    function adminGroupList(page,amount, callback, error){

        // let grpSn = param.grpSn;
        // let page = param.page || 1;
        console.log("js/page : " + page);
        console.log("js/amount : " + amount);


        $.getJSON("/admin/manageGroup/" + page + "?amount=" + amount,
            function(data){
                if(callback) {
                    //boardCnt 변수명 이따가 확인하기
                    console.log("js/groupCnt : "+data.groupCnt);
                    console.log("js/groupList"+data.list);
                    callback(data.groupCnt, data.list);
                }
            })
            .fail(function(xhr, status, err){
                if(error){
                    error();
                }
            });
    } // end groupList

    function adminDelete(dataArr, callback, error){

        let jsonString = JSON.stringify(dataArr);
        console.log(jsonString);
        console.log(dataArr);

        $.ajax({
            type : 'POST',
            //traditional : true,
            url : '/admin/group/dataArr',
            data :  JSON.stringify(dataArr),
            contentType : "application/json; charset=utf-8",
            success : function(deleteResult, status, xhr){
                if(callback){
                    callback(deleteResult);
                }
            },
            error : function(xhr, status, er){
                if (error){
                    error(er)
                }
            }
        });

    }// end adminDelete


    function groupDisplayTime(timeValue) {

        let date = new Date(timeValue);

        let year = date.getFullYear().toString().slice(-2); //년도 뒤에 두자리
        let month = ("0" + (date.getMonth() + 1)).slice(-2); //월 2자리 (01, 02 ... 12)
        let day = ("0" + date.getDate()).slice(-2); //일 2자리 (01, 02 ... 31)
        let hour = ("0" + date.getHours()).slice(-2); //시 2자리 (00, 01 ... 23)
        let minute = ("0" + date.getMinutes()).slice(-2); //분 2자리 (00, 01 ... 59)
        let second = ("0" + date.getSeconds()).slice(-2); //초 2자리 (00, 01 ... 59)

        let returnDate = year + "/" + month + "/" + day + " "+ hour + ":" + minute + ":" + second;

        return returnDate;

    } // end boardDisplayTime


    return {
        adminGroupList:adminGroupList,
        groupDisplayTime:groupDisplayTime,
        adminDelete:adminDelete
    }
})();