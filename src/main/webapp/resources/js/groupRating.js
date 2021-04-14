console.log("GroupRating Module.....");
let groupRatingService = (function(){

    function add (groupRating, callback, error) {
        console.log("groupRating......")

        $.ajax({
            type : 'post',
            url : '/rating/new',
            data : JSON.stringify(groupRating),
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

    function getList(param, callback, error) {

        let sn = param.sn;
        let page = param.page || 1;

        $.getJSON("/rating/pages/" + sn + "/" + page + ".json",
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

    function remove(sn, callback, error) {
        $.ajax({
            type : 'delete',
            url : '/rating/' + sn,
            success : function(deleteResult, status, xhr) {
                if(callback) {
                    callback(defaultResult);
                }
            },
            error : function(xhr, status, er) {
                if(error) {
                    error(er);
                }
            }
        })
    }

    function update(groupRating, callback, error) {
        console.log("sn:" + groupRating.sn);

        $.ajax({
            type : 'put',
            url : '/rating/' + groupRating.sn,
            data : JSON.stringify(groupRating),
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

    function get(sn, callback, error) {

        $.get('/rating/' + sn + ".json", function(result) {

            if(callback) {
                callback(result);
            }
        }).fail(function(xhr, status, err) {
            if(error) {
                error();
            }
        })
    }

    return {
        add : add,
        getList : getList,
        remove : remove,
        update : update,
        get : get
    };
})();