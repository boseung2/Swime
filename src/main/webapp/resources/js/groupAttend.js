console.log("Group Attend Module.....");
let groupAttendService = (function() {

    function add(attend, callback, error) {
        console.log("attend....");
        console.log(attend);

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

    function getListWithBan(param, callback, error) {

        let grpSn = param.grpSn;

        $.getJSON("/groupAttend/pageWithBan/" + grpSn + ".json",
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

    function get(param, callback, error) {
        let grpSn = param.grpSn;
        let userId = param.userId;

        $.getJSON("/groupAttend/" + grpSn + "/" + userId + ".json",
            function(data) {
            console.log(data);
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

        $.ajax({
            type : 'put',
            url : '/groupAttend/withdraw',
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

    function changeLeader(sn, callback, error) {
        $.ajax({
            type : 'put',
            url : '/groupAttend/changeLeader/' + sn,
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

    function changeManager(sn, callback, error) {
        $.ajax({
            type : 'put',
            url : '/groupAttend/changeManager/' + sn,
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

    function cancelManager(sn, callback, error) {
        $.ajax({
            type : 'put',
            url : '/groupAttend/cancelManager/' + sn,
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

    function banPermanent(sn, callback, error) {
        $.ajax({
            type : 'put',
            url : '/groupAttend/banPermanent/' + sn,
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

    function ban(sn, callback, error) {
        $.ajax({
            type : 'delete',
            url : '/groupAttend/ban/' + sn,
            contentType : "application/json; charset=utf-8",
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

    function cancelBan(sn, callback, error) {
        $.ajax({
            type : 'delete',
            url : '/groupAttend/cancelBan/' + sn,
            contentType : "application/json; charset=utf-8",
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

    return {
            add : add,
            getList : getList,
            getListWithBan : getListWithBan,
            get : get,
            withdraw : withdraw,
            changeLeader : changeLeader,
            changeManager : changeManager,
            cancelManager : cancelManager,
            banPermanent : banPermanent,
            ban : ban,
            cancelBan : cancelBan
    };

})();