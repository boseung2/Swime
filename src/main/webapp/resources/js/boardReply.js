console.log("Reply Module")

let replyService = (function() {
    //댓글 생성
    function add(reply, callback, error) {
        console.log("reply..........");

        $.ajax({
            type: 'post',
            url: '/replies/new',
            data: JSON.stringify(reply),
            contentType: "application/json; charset=utf-8",
            success: function (result, status, xhr) {
                console.log("boardReplyJs : "+ result);
                if (callback) {
                    callback(result);
                }
            },
            error: function (xhr, status, er) {
                if (error) {
                    error(er)
                }
            }
        });
    }

    //댓글 조회
    function getList(param, callback, error){
        let brdSn = param.brdSn;
        let page = param.page || 1;
        //let test = param.test;
        $.getJSON("/replies/pages/" + brdSn + "/" + page + ".json",
            function(data){
            if(callback){
                console.log("data");
                console.log(data);
                callback(data);
                //test();
            }
        }).fail(function(xhr, status, err){
            if(error){
                error();
            }
        });
    }
    //댓글 삭제
    function remove(sn, brdSn, userId, callback, error){
        console.log("js/userId : " + userId);
        $.ajax({
            type : 'delete',
            url : '/replies/' +sn +'/'+ brdSn,
            data : JSON.stringify({sn:sn, brdSn:brdSn, userId:userId}),
            contentType : "application/json; charset=utf-8",
            success : function(deleteResult, status, xhr){
                if(callback){
                    callback(deleteResult);
                }
            },
            error : function(xhr, status, er){
                if(error){
                    error(er)
                }
            }
        });
    }
    //댓글 업데이트
    function update(reply, callback, error){
        console.log("sn: " + reply.sn);

        $.ajax({
            type : 'put',
            url : '/replies/' + reply.sn,
            data : JSON.stringify(reply),
            contentType: "application/json; charset=utf-8",
            success : function(result, status, xhr){
                if(callback){
                    callback(result);
                }
            },
            erorr : function(xhr, status, er){
                if(error){
                    error(er);
                }
            }
        });
    }
    //특정 댓글 조회
    function get(sn, callback, error){
        $.get("/replies/" + sn + ".json", function(result){
            if(callback){
                callback(result)
            }
        }).fail(function(xhr, status, err){
            if(error){
                error();
            }
        });
    }
    //날짜
    function displayTime(timeValue){
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

            return [yy, '-', (mm > 9 ? '':'0') + mm, '/', (dd > 9? '' : '0') +dd].join('');
        }
    };


    return{
        add:add,
        getList:getList,
        remove:remove,
        update:update,
        get:get,
        displayTime:displayTime
    };
})();