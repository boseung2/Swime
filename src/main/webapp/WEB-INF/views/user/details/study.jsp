<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../../includes/tagLib.jsp" %>

<link href="/resources/css/minicard.css" rel="stylesheet">

<c:set var="defaultImg" value="https://streamyard.com/resources/assets/images/docs/connect-a-facebook-group/connect-a-facebook-group.jpg"/>

<c:set var="cardTitleLength" value="9"/>

<style>
    .mb-5, .my-5 {
        margin-bottom: 1rem!important;
    }

    .mini-card-tag {
        background-color: #f1f1f1;
        padding: 2px;
        font-size: 15px;
        border-radius: 0.5rem;
        width: 80px;
        height: 25px;
        text-align: center;
    }
</style>


<%--<h2>스터디</h2>--%>


<%--<div class="container">--%>
    <!-- Content Row -->
    <div class="subContainer">
        <div class="h3cover" >
            <h4 class="h3title">생성한 스터디</h4>
        </div>
        <div class="subBody">
            <div class="row" id="make"></div>
            <div id="makepagi"></div>
            <input type="hidden" name="pageNum" id="pageNum1" value="1">
            <input type="hidden" name="amount" id="amount1" value="6">
        </div>
    </div>

    <div class="subContainer">
        <div class="h3cover">
            <h4 class="h3title">예정된 스터디</h4>
        </div>
        <div class="subBody">

    <div class="row" id="before"></div>
    <div id="beforepagi"></div>

    <input type="hidden" name="pageNum" id="pageNum2" value="1">
    <input type="hidden" name="amount" id="amount2" value="6">
        </div>
    </div>

<div class="subContainer">
    <div class="h3cover">
        <h4 class="h3title">종료된 스터디</h4>
    </div>
    <div class="subBody">
    <div class="row" id="after"></div>
    <div id="afterpagi"></div>
    <input type="hidden" name="pageNum" id="pageNum3" value="1">
    <input type="hidden" name="amount" id="amount3" value="6">
    </div>
</div>

<div class="subContainer">
    <div class="h3cover">
        <h4 class="h3title">관심 스터디</h4>
    </div>
    <div class="subBody">
    <div class="row" id="wish"></div>
    <div id="wishpagi"></div>

    <input type="hidden" name="pageNum" id="pageNum4" value="1">
    <input type="hidden" name="amount" id="amount4" value="6">
    </div>
</div>
<%--</div>--%>


<script>
    $(document).ready(function () {
        getMakeList("make");
        getMakeList("before");
        getMakeList("after");
        getMakeList("wish");
    });

    function cardClick() {
        $(".card-body").on("click", function () {
            console.log("click");
            $(location).attr('href', '/study/get?sn=' + this.dataset.sn + '&userId=' + '${MemberVo.id}');
        });
    }

    function getMakeList(obj) {
        let url, pageNum, amount;
        let place, pagiPlace, type;

        if(obj === 'make'){
            // ajax 통신을 위한 변수
            url = "makeStudy";
            pageNum = $("#pageNum1")[0].value;
            amount = $("#amount1")[0].value;

            place = $("#make")[0];
            pagiPlace = $("#makepagi")[0];
            type = obj;
        }
        else if(obj === 'before'){
            // ajax 통신을 위한 변수
            url = "beforeStudy";
            pageNum = $("#pageNum2")[0].value;
            amount = $("#amount2")[0].value;

            place = $("#before")[0];
            pagiPlace = $("#beforepagi")[0];
            type = obj;
        }
        else if(obj === 'after'){
            // ajax 통신을 위한 변수
            url = "afterStudy";
            pageNum = $("#pageNum3")[0].value;
            amount = $("#amount3")[0].value;

            place = $("#after")[0];
            pagiPlace = $("#afterpagi")[0];
            type = obj;
        }
        else if(obj === 'wish'){
            // ajax 통신을 위한 변수
            // console.log("wish");
            url = "wishStudy";
            pageNum = $("#pageNum4")[0].value;
            amount = $("#amount4")[0].value;

            place = $("#wish")[0];
            pagiPlace = $("#wishpagi")[0];
            type = obj;
        }



        $.ajax({
            url: '/profile/' + url + ".json",
            type: 'GET',
            data: {
                id : '${id}',
                pageNum : pageNum,
                amount : amount
            },
            success: function(result) {
                c = result;

                htmlByajax(result, place, pagiPlace, type, pageNum);
                cardClick();
                pagiActive();
            },
            error : function (msg) {

            }
        });
    }

    function htmlByajax(result, obj, obj2, kind, pageNum) {
        let list = result.list;
        let count = result.count;


        let cardstr = "";
        for (let i = 0; i < list.length ; i++) {
            cardstr += makeCard(list[i]);
        }

        let pagiStr = makePagi(count, pageNum, kind);

        $(obj).html(cardstr);
        $(obj2).html(pagiStr);

    }

    function makeCard(obj) {
        // console.log(obj);

        let defaultImg = "${defaultImg}";
        let sn = obj.sn;
        let grpSn = obj.grpSn;
        let representation = obj.representation;
        let representationName = obj.representationName;
        let name = obj.name;
        let startDate = obj.startDate;
        let endDate = obj.endDate;
        let repeatCycle = obj.repeatCycle;
        let startTime = obj.startTime;
        let endTime = obj.endTime;
        let repeatDay = obj.repeatDay;
        let information = obj.information;
        let onOff = obj.onOff;
        let onUrl = obj.onUrl;
        let placeId = obj.placeId;
        let expense = obj.expense;
        let capacity = obj.capacity;
        let attendants = obj.attendants;
        let status = obj.status;
        let regDate = obj.regDate;
        let updDate = obj.updDate;

        onOff = onOff === 'STOF02' ? '오프라인' : '온라인';
        name = name.length > 9 ? name.slice(0,8) + '...' : name;

        startDate = startDate.slice(0, 10);
        if(endDate.substring(0, 10) !== startDate.substring(0, 10)){
            endDate = endDate.slice(0, 10);
        }else {
            endDate = "";
        }


        let str = "" +
            "<div class='col-md-4 mb-5'>" +
            "    <div class='card h-100'>" +
            "        <div class='card-body' data-sn='" + sn + "'>" +
            "            <div class='card-body-top' style='display:flex;'>" +
            "                <div class='uploadResult'>" +
            "                    <img class='img-fluid rounded mb-4 mb-lg-0' src='" + defaultImg +"' alt=''>" +
            "                </div>" +
            "                <div>" +
            "                    <div>" +
            "                        <h2 class='card-title' style='font-size: 20px; margin-bottom: 0px;'>" +
            "                            " + name +
            "                        </h2>" +
            "                        <span class='flex-container'>" +
            "                            <div class='mini-card-tag' style='margin: 4px; padding: 6px;'>" +
            "                                " + onOff +
            "                            </div>" +
            "                        </span>" +
            "                    </div>" +
            "                </div>" +
            "            </div>" +
            "            <div class='card-body-bottom' style='flex-direction: column;height: 70px;'>" +
            "                <p style='margin-bottom: 3px;'><i class='fas fa-users'></i> " + attendants + " / " + capacity + "명</p>" +
            "                <p style='margin-bottom: 3px;'><i class='far fa-calendar-check'></i> " + startDate + "</p>" +
            // (endDate !== null ? "<p style='margin-bottom: 3px;'><i class='far fa-calendar-times'></i> " + endDate + "</p>" : "<i class='far fa-calendar-times'> 종료일이 없습니다</i>") +
            (endDate !== "" ? "<p style='margin-bottom: 3px;'><i class='far fa-calendar-times'></i> " + endDate + "</p>" : "") +
            // "                <p style='margin-bottom: 3px;'><i class='far fa-calendar-times'></i> " + endDate + "</p>" +
            // "                <p class='card-text ratingPlace' id='stars' data-rating='' data-ratingcount=''>(스타)</p>\n" +
            "            </div>" +
            "        </div>" +
            "    </div>" +
            "</div>";
        return str;
    }



    function makePagi(Cnt, pageNum, kind) {
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

    function pagiActive(){

        $("#rating-item > #rating-link").unbind("click");

        $("#rating-item > #rating-link").on("click", function (e) {
            e.preventDefault();
            // console.log("click");
            // console.log(this.dataset.pagenum);
            // console.log(this.dataset.type);
            // console.dir(this);
            btnSwitch = true;

            let type;
            if(this.dataset.type === 'make'){
                type = "pageNum1";
            }
            else if(this.dataset.type === 'before'){
                type = "pageNum2";
            }
            else if(this.dataset.type === 'after'){
                type = "pageNum3";
            }
            else if(this.dataset.type === 'wish'){
                type = "pageNum4";
            }

            if(this.dataset.btn === 'prev'){
                $("#"+type)[0].value = parseInt($("#"+type)[0].value) - 1;
            }
            else if(this.dataset.btn === 'next'){
                $("#"+type)[0].value = parseInt($("#"+type)[0].value) + 1;
            }
            else{
                $("#"+type)[0].value = this.dataset.pagenum;
            }

            getMakeList(this.dataset.type);
            return;
        });
    }

</script>

