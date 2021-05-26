<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../../includes/tagLib.jsp" %>

<link href="/resources/css/minicard.css" rel="stylesheet">


<div class="subContainer">
    <div class="h3cover" >
        <%--    <h3 class="h3title">생성한 스터디</h3>--%>
        <h4 class="h3title">작성한 글</h4>
    </div>
    <div class="subBody">
        <!-- Content Row -->

    <div class="row" id="write"></div>
    <div id="pagiwrite"></div>

    <input type="hidden" name="pageNum" id="pageNum1" value="1">
    <input type="hidden" name="amount" id="amount1" value="6">

    <h2 hidden>좋아요를 누른글</h2>

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


        useAjax("writeContents", $(pageNum1)[0].value, 6, writePlace, pagiPlace, pageNum1, "write");
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
                //console.log(result);
                cardActive(result);
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
            console.log(result.list[i]);
            // console.log(result.list[i].userId);
            // console.log(result.list[i].grpSn);
        }
        resultStr2 += makePagi(result.boardCnt, pageNum, kind);

        $(place).html(resultStr1);
        $(pagiPlace).html(resultStr2);
    }

    function convertHtml(obj) {
        let attachList = obj.attachList;
        let content = obj.content;
        let grpRole = obj.grpRole;
        let grpSn = obj.grpSn;
        let likeCnt = obj.likeCnt;
        let name = obj.name;
        let picture = obj.picture;
        let regDate = obj.regDate;
        let replyCnt = obj.replyCnt;
        let sn = obj.sn;
        let title = obj.title;
        let topFix = obj.topFix;
        let updDate = obj.updDate;
        let userId = obj.userId;
        let status = obj.status;

        console.log(grpSn);
        console.log(userId);

        let str = "" +
            // "<div class='col-md-4 mb-5'>" +
            "<div class='mb-2'>" +

            "    <div class='card h-100'>" +
            "        <div class='card-body' data-sn='" + sn + "' data-grpSn='" + grpSn + "' data-userId='" + userId + "'>" +
            "            <div class='card-body-top' style='display:flex;'>" +
            "                <div class='uploadResult'>" +
            "                    <img class='img-fluid rounded mb-4 mb-lg-0' src='' alt=''>" +
            "                </div>" +
            "                <div>" +
            "                    <div>" +
            // "                        <h2 class='card-title' style='font-size: 25px; margin-bottom: 0px;'>" +
            "                        <h5 class='card-title' style='font-size: 16px; margin-bottom: 0px;'>" +
            "                            " + (title.length > 8 ? title.slice(0,9) : title) +
            "                        </h5>" +
            // "                        <div class='card-content'>" +
            // "                               " + (content.length > 60 ? content.slice(0,59) : content) +
            // "                        </div>" +
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

    //1.댓글 게시글 url : 유저아이디 모임번호 넣어놓기
    // board/get?sn=595&grpSn=1184&userId=test1@naver.com

    function cardActive(result) {

        console.log(result);

        $(".card-body").on("click", function () {

            console.log("click");
            console.log(this);
            // $(location).attr('href', '/board/get?sn=' + this.dataset.sn);
            $(location).attr('href', '/board/get?sn=' + this.dataset.sn + "&userId=" + this.dataset.userid + "&grpSn=" + this.dataset.grpsn);

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
