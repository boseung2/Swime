console.log("studySurveyService Module.....");

let studySurveyService = (function(){

    function getSurveyList(stdSn, callback, error) {

        console.log("getSurveyList stdSn = " + stdSn);

        $.get("/study/survey/get/" + stdSn, function (result) {
            if (callback) {
                callback(result);
            }
        }).fail(function (xhr, status, err) {
            if (error) {
                error();
            }
        })
    }

    return {
        getSurveyList : getSurveyList
    };
})();