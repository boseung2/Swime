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
                if (callback) {
                    callback(result);
                }
            },
            error: function (xhr, status, er) {
                if (error) {
                    error(er)
                }
            }
        })
    }
    return{
        add:add
    };
})();