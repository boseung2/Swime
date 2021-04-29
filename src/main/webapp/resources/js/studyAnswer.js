console.log("studyAnswerService Module.....");

let studyAnswerService = (function(){

    function register(answerList, callback, error) {

        console.log("register answer");

        $.ajax({
            type:'post',
            url : '/study/answer/register',
            data : JSON.stringify(answerList),
            contentType : "application/json; charset = utf-8",
            success : function(result, status, xhr) {
                if (callback) {
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
        register : register
    };
})();