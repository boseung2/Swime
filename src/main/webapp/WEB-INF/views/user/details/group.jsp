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
        <h4 class="h3title">생성한 모임</h4>
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
        <h4 class="h3title">가입한 모임</h4>
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
        <h4 class="h3title">관심 모임</h4>
    </div>
    <div class="subBody">
        <div class="row" id="after"></div>
        <div id="afterpagi"></div>
        <input type="hidden" name="pageNum" id="pageNum3" value="1">
        <input type="hidden" name="amount" id="amount3" value="6">
    </div>
</div>

<%--</div>--%>


<script>
    $(document).ready(function () {
        getMakeList("make");
        getMakeList("join");
        getMakeList("wish");
    });

    function cardClick() {
        $(".card-body").on("click", function () {
            console.log("click");
            $(location).attr('href', '/group/get?sn=' + this.dataset.sn);
        });
    }

    function getMakeList(obj) {
        let url, pageNum, amount;
        let place, pagiPlace, type;

        if(obj === 'make'){
            // ajax 통신을 위한 변수
            url = "makeGroup";
            pageNum = $("#pageNum1")[0].value;
            amount = $("#amount1")[0].value;

            place = $("#make")[0];
            pagiPlace = $("#makepagi")[0];
            type = obj;
        }
        else if(obj === 'join'){
            // ajax 통신을 위한 변수
            url = "joinGroup";
            pageNum = $("#pageNum2")[0].value;
            amount = $("#amount2")[0].value;

            place = $("#before")[0];
            pagiPlace = $("#beforepagi")[0];
            type = obj;
        }
        else if(obj === 'wish'){
            // ajax 통신을 위한 변수
            url = "wishGroup";
            pageNum = $("#pageNum3")[0].value;
            amount = $("#amount3")[0].value;

            place = $("#after")[0];
            pagiPlace = $("#afterpagi")[0];
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

        console.log(list);
        console.log(count);


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
        let tags = obj.tags;
        let category = obj.category;
        let rating = obj.rating;
        let picture = obj.picture;
        let attendCount = obj.attendCount;
        let name = obj.name;

        name = name.length > 9 ? name.slice(0, 8) + '...' : name;

        picture = picture === null ? defaultImg : '/display?fileName=' + picture;

        console.log(sn);
        console.log(tags);
        console.log(category);
        console.log(rating);
        console.log(picture);
        console.log(attendCount);

        let tagStr = ""
        for (let i = 0; i < tags.length; i++) {
            tagStr += "" +
                "                            <div class='mini-card-tag' style='margin: 4px; padding: 6px;'>" +
                "                                " + tags +
                "                            </div>"
            ;
        }



        let str = "" +
            "<div class='col-md-4 mb-5'>" +
            "    <div class='card h-100'>" +
            "        <div class='card-body' data-sn='" + sn + "'>" +
            "            <div class='card-body-top' style='display:flex;'>" +
            "                <div class='uploadResult'>" +
            "                    <img class='img-fluid rounded mb-4 mb-lg-0' src='" + picture +"' alt=''>" +
            "                </div>" +
            "                <div>" +
            "                    <div>" +
            "                        <h2 class='card-title' style='font-size: 20px; margin-bottom: 0px;'>" +
            "                            " + name +
            "                        </h2>" +
            "                        <span class='flex-container'>" +
            "                           " + tagStr +
            "                        </span>" +
            "                    </div>" +
            "                </div>" +
            "            </div>" +
            "            <div class='card-body-bottom' style='flex-direction: column;height: 70px;'>" +
            "                <p style='margin-bottom: 3px;'><i class='fas fa-users'></i> " + attendCount + "명</p>" +
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
            else if(this.dataset.type === 'join'){
                type = "pageNum2";
            }
            else if(this.dataset.type === 'wish'){
                type = "pageNum3";
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




<script>
    $(".card-body").on("click", function () {
        $(location).attr('href', '/group/get?sn=' + this.dataset.sn);
    });

    $(document).ready(function() {
        let list = $('.ratingPlace');
        for (let i = 0; i < list.length; i++) {
            $(list[i]).html(star($(list[i]).data("rating")));
        }
    });

    function star(rating){
        let width = 80 * (rating / 5);
        let tag = ''
            +'<span class="star_score" id="netizen_point_tab_inner">'
            +'  <span class="st_off">'
            +'      <span class="st_on" style="width:' + width + 'px;">'
            +'      </span>'
            +'  </span>'
            +'</span>';
        return tag;
    }
</script>