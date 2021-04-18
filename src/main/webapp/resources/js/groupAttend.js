console.log("Group Attend Module.....");
let groupAttendService = (function() {

    function add(attend, callback, error) {
        console.log("attend....");

        $.ajax({
            type : 'post',
            url : '/groupAttend/new',
            data : JSON.stringify(attend),
            contentType : "application/json; chatset=utf-8",
            success : function(result, status, xhr) {
                if(callback) {
                    callback(result);
                }
            },
            error : function(xhr, status, er) {
                if(error) {
                    error(er);
                }
            }
        })
    }

    function getList(param, callback, error) {

        let grpSn = param.grpSn;

        $.getJSON("/groupAttend/page/" + grpSn + ".json",
            function(data) {
                if(callback) {
                    callback(data);
                }
            }).fail(function(xhr, status, err) {
                if(error) {
                    error();
                }
        })
    }

    function withdraw(attend, callback, error) {

        console.log("sn:" + attend.sn);

        $.ajax({
            type : 'put',
            url : '/groupAttend/withdraw/' + attend.sn,
            data : JSON.stringify(attend),
            contentType : "application/json; charset=utf-8",
            success : function(result, status, xhr) {
                if(callback) {
                    callback(result);
                }
            }, error : function(xhr, status, er) {
                if(error) {
                    error(er);
                }
            }
        })
    }

    return {
            add : add,
            getList : getList,
            withdraw : withdraw
    };

})();