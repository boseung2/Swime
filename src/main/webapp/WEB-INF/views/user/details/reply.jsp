<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../../includes/tagLib.jsp" %>

<link href="/resources/css/minicard.css" rel="stylesheet">

<div class="subContainer">
    <div class="h3cover" >
        <%--    <h3 class="h3title">생성한 스터디</h3>--%>
        <h4 class="h3title">작성댓글</h4>
    </div>
    <div class="subBody">
    <!-- Content Row -->

    <div class="row" id="write"></div>
    <div id="pagiwrite"></div>

    <input type="hidden" name="pageNum" id="pageNum1" value="1">
    <input type="hidden" name="amount" id="amount1" value="6">

    <h2 hidden>좋아요를 누른 댓글</h2>

    <div class="row" id="wish"></div>
    <div id="pagiwish"></div>

    <input type="hidden" name="pageNum" id="pageNum2" value="1">
    <input type="hidden" name="amount" id="amount2" value="6">


</div>
</div>

<script>

    $(document).ready(function () {
        write();
        // ajax("writeContents", 1, 6);
    });

    function write() {
        // console.log("write 함수");
        let writePlace = $("#write");
        let pagiPlace = $("#pagiwrite");
        let pageNum1 = $("#pageNum1");


        useAjax("writeReply", $(pageNum1)[0].value, 6, writePlace, pagiPlace, pageNum1, "write");
    }

    function useAjax(url, pageNum, amount, place, pagiPlace, pageNumInput, kind) {
        // console.log("ajax");
        $.ajax({
            url: '/profile/' + url + ".json",
            type: 'GET',
            data: {
                id : '${id}',
                pageNum : pageNum,
                amount : amount
            },
            success: function(result) {
                // console.log(result);
                showHtmlByAjax(result, place, pagiPlace, pageNum, kind);
                pagiActive(pageNumInput);
                cardActive();
            },
            error : function (msg) {

            }
        });
    }

    function showHtmlByAjax(result, place, pagiPlace, pageNum, kind) {
        // console.log(result);
        if(result.list.length === 0){
            $(place).html("데이터가 없습니다");
            return;
        }

        let resultStr1 = "";
        let resultStr2 = "";
        for (let i = 0; i < result.list.length; i++) {
            resultStr1 += convertHtml(result.list[i]);
        }
        resultStr2 += makePagi(result.replyCnt, pageNum, kind);

        $(place).html(resultStr1);
        $(pagiPlace).html(resultStr2);
    }

    function convertHtml(obj) {

        let brdSn = obj.brdSn;
        let cnt = obj.cnt;
        let commentGroup = obj.commentGroup;
        let content = obj.content;
        let name = obj.name;
        let regDate = obj.regDate;
        let sn = obj.sn;
        let status = obj.status;
        let updDate = obj.updDate;
        let userId = obj.userId;

        let grpSn = obj.grpSn;




        let str = "" +
            // "<div class='col-md-4 mb-5'>" +
            "<div class='mb-2'>"+
            "    <div class='card h-100'>" +
            "        <div class='card-body' data-sn='" + brdSn + "' data-grpSn='" + grpSn + "' data-userId='" + userId + "'>" +
            "            <div class='card-body-top' style='display:flex;'>" +
            "                <div class='uploadResult'>" +
            "                    <img class='img-fluid rounded mb-4 mb-lg-0' src='' alt=''>" +
            "                </div>" +
            "                <div>" +
            "                    <div>" +
            // "                        <h2 class='card-title' style='font-size: 25px; margin-bottom: 0px;'>" +
            "                        <h4 class='card-title' style='font-size: 16px; margin-bottom: 0px;'>" +
            "                            " + (content.length > 8 ? content.slice(0,9) : content) +
            "                        </h4>" +
            "                        <div class='card-content' hidden>" +
            "                               " + /*(content.length > 60 ? content.slice(0,59) : content)*/"a" +
            "                        </div>" +
            "                    </div>" +
            "                </div>" +
            "            </div>" +
            // "            <div class='card-body-bottom' style='flex-direction: column;height: 70px;'>" +
            "            </div>" +
            "        </div>" +
            "    </div>" +
            "</div>"
        ;
        // let str = "???";

        return str;
    }

    function makePagi(Cnt, pageNum, kind) {
        // console.log(Cnt);
        // console.log(pageNum);
        // console.log(kind);
        let endNum = Math.ceil(pageNum / 5.0) * 5;

        let startNum = endNum - 4;

        let prev = startNum != 1;
        let next = false;

        if(endNum * 6 >= Cnt) {
            endNum = Math.ceil(Cnt / 6.0);
        }

        if(endNum * 6 < Cnt) {
            next = true;
        }

        // console.log("startNum = " + startNum + ", endNum = " + endNum + ", prev = " + prev + ", next = " + next);
        // console.log(pageNum + "/" + "5" + "*" + " 5 = " + (pageNum / 5.0 * 5));

        let str = '<ul class="pagination pagination-sm">';

        if(prev) {
            str += "<li id='rating-item' class='page-item'><a id='rating-link' class='page-link' href='#' data-type='" + kind + "' data-btn='prev'>Previous</a></li>"
        }

        for(let i= startNum ; i <= endNum; i++) {

            let active = pageNum == i ? "active" : "";
            // "+i+"
            str += "" +
                "<li id='rating-item' class='page-item "+active+" '>" +
                "   <a id='rating-link' class='page-link' href='#' data-type='" + kind + "' data-pagenum='" + i + "'>"+i+"</a>" +
                "</li>";
        }

        if(next) {
            str += "<li id='rating-item' class='page-item'><a id='rating-link' class='page-link' href='#' data-type='" + kind + "' data-btn='next'>Next</a></li>";
        }

        str += "</ul></div>";

        return str;
    }

    // board/get?sn=595&userId=toy@naver.com&grpSn=
    function cardActive() {
        $(".card-body").on("click", function () {
            // console.log("click");

            $(location).attr('href', '/board/get?sn=' + this.dataset.sn + "&userId=" + this.dataset.userid + "&grpSn="+0);
        });
    }

    function pagiActive(pageNumInput){
        // console.log("pagi");

        $("#rating-item > #rating-link").unbind("click");

        $("#rating-item > #rating-link").on("click", function (e) {
            // console.log("click");
            // console.log(pageNumInput);
            // console.log(this.dataset.type);

            if(this.dataset.btn === 'prev'){
                $(pageNumInput)[0].value = parseInt($(pageNumInput)[0].value) - 1;
            }
            else if(this.dataset.btn === 'next'){
                $(pageNumInput)[0].value = parseInt($(pageNumInput)[0].value) + 1;
            }
            else{
                $(pageNumInput)[0].value = this.dataset.pagenum;
            }

            if(this.dataset.type === 'write'){
                write();
            }

        });
    }



</script>
