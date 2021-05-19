console.log("VisitCounter Module...");

visitorCountRequest();

function visitorCountRequest() {
    $.ajax({
        url : "/adminData/countVisitor",
    }).done(function (result) {

    }).fail(function (result) {
        console.log("방문자 카운터에 문제가 발생했습니다. "+result);
    });
}