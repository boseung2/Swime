<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../../includes/tagLib.jsp" %>

<link href="/resources/css/minicard.css" rel="stylesheet">

<c:set var="defaultImg" value="https://streamyard.com/resources/assets/images/docs/connect-a-facebook-group/connect-a-facebook-group.jpg"/>

<c:set var="cardTitleLength" value="9"/>


<h1>스터디</h1>
<hr>

<div class="container">
    <!-- Content Row -->
    <form id="paging" action="/user/details/groupWithPaging" method="get">
        <h2>생성한 스터디</h2>

        <div class="row" id="make"></div>
        <div id="makepagi"></div>

        <input type="hidden" name="pageNum" id="pageNum1" value="${pageMaker1.cri.pageNum}">
        <input type="hidden" name="amount" id="amount1" value="${pageMaker1.cri.amount}">

        <h2>예정된 스터디</h2>
        <div class="row">
            <c:forEach var="GroupVo" items="${joinList}">
                <div class="col-md-4 mb-5">
                    <div class="card h-100">
                        <div class="card-body" data-sn="${GroupVo.sn}">
                            <div class="card-body-top">
                                <div class="uploadResult">
                                    <img class="img-fluid rounded mb-4 mb-lg-0" src="${!empty group.picture ? '/display?fileName=' += group.picture : defaultImg}" alt="">
                                </div>
                                <div>
                                    <div>
                                        <h2 class="card-title" style="font-size: 25px; margin-bottom: 0px;">
                                                ${fn:length(GroupVo.name) > cardTitleLength
                                                        ? fn:substring(GroupVo.name,0,8) += '...'
                                                        : GroupVo.name}
                                        </h2>
                                        <span class="flex-container">
                                            <c:forEach var="tag" items="${GroupVo.tags}">
                                                <div class="mini-card-tag" style="margin: 4px; padding: 6px;">
                                                        ${tag}
                                                </div>
                                            </c:forEach>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body-bottom">
                                <p><i class="fas fa-users"></i> ${GroupVo.attendCount}명</p>
                                <p class="card-text ratingPlace" id="stars${GroupVo.sn}" data-rating='${GroupVo.rating}' data-ratingcount="${GroupVo.ratingCount}">(스타)</p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="pagination">
            <c:if test="${pageMaker2.prev}">
                <li class="paginate_button previous">
                    <a href="${pageMaker2.startPage - 1}">&laquo;</a>
                </li>
            </c:if>

            <c:forEach var="num" begin="${pageMaker2.startPage}" end="${pageMaker2.endPage}">
                <li class="paginate_button">
                    <a href="#" data-kind="pageNum2" class="${pageMaker2.cri.pageNum == num ? "active" : ""}">${num}</a>
                </li>
            </c:forEach>

            <c:if test="${pageMaker2.next}">
                <li class="paginate_button next">
                    <a href="${pageMaker2.endPage + 1}">&raquo;</a>
                </li>
            </c:if>
        </div>
        <input type="hidden" name="pageNum" id="pageNum2" value="${pageMaker2.cri.pageNum}">
        <input type="hidden" name="amount" id="amount2" value="${pageMaker2.cri.amount}">

        <h2>종료된 스터디</h2>
        <div class="row">
            <c:forEach var="GroupVo" items="${wishList}">
                <div class="col-md-4 mb-5">
                    <div class="card h-100">
                        <div class="card-body" data-sn="${GroupVo.sn}">
                            <div class="card-body-top">
                                <div class="uploadResult">
                                    <img class="img-fluid rounded mb-4 mb-lg-0" src="${!empty group.picture ? '/display?fileName=' += group.picture : defaultImg}" alt="">
                                </div>
                                <div>
                                    <div>
                                        <h2 class="card-title" style="font-size: 25px; margin-bottom: 0px;">
                                                ${fn:length(GroupVo.name) > cardTitleLength
                                                        ? fn:substring(GroupVo.name,0,8) += '...'
                                                        : GroupVo.name}
                                        </h2>
                                        <span class="flex-container">
                                            <c:forEach var="tag" items="${GroupVo.tags}">
                                                <div class="mini-card-tag" style="margin: 4px; padding: 6px;">
                                                        ${tag}
                                                </div>
                                            </c:forEach>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body-bottom">
                                <p><i class="fas fa-users"></i> ${GroupVo.attendCount}명</p>
                                <p class="card-text ratingPlace" id="stars${GroupVo.sn}" data-rating='${GroupVo.rating}' data-ratingcount="${GroupVo.ratingCount}">(스타)</p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="pagination">
            <c:if test="${pageMaker3.prev}">
                <li class="paginate_button previous">
                    <a href="${pageMaker3.startPage - 1}">&laquo;</a>
                </li>
            </c:if>

            <c:forEach var="num" begin="${pageMaker3.startPage}" end="${pageMaker3.endPage}">
                <li class="paginate_button">
                    <a href="#" data-kind="pageNum3" class="${pageMaker3.cri.pageNum == num ? "active" : ""}">${num}</a>
                </li>
            </c:forEach>

            <c:if test="${pageMaker3.next}">
                <li class="paginate_button next">
                    <a href="${pageMaker3.endPage + 1}">&raquo;</a>
                </li>
            </c:if>
        </div>
        <input type="hidden" name="pageNum" id="pageNum3" value="${pageMaker3.cri.pageNum}">
        <input type="hidden" name="amount" id="amount3" value="${pageMaker3.cri.amount}">

        <h2>관심 스터디</h2>
        <div class="row">
            <c:forEach var="GroupVo" items="${wishList}">
                <div class="col-md-4 mb-5">
                    <div class="card h-100">
                        <div class="card-body" data-sn="${GroupVo.sn}">
                            <div class="card-body-top">
                                <div class="uploadResult">
                                    <img class="img-fluid rounded mb-4 mb-lg-0" src="${!empty group.picture ? '/display?fileName=' += group.picture : defaultImg}" alt="">
                                </div>
                                <div>
                                    <div>
                                        <h2 class="card-title" style="font-size: 25px; margin-bottom: 0px;">
                                                ${fn:length(GroupVo.name) > cardTitleLength
                                                        ? fn:substring(GroupVo.name,0,8) += '...'
                                                        : GroupVo.name}
                                        </h2>
                                        <span class="flex-container">
                                            <c:forEach var="tag" items="${GroupVo.tags}">
                                                <div class="mini-card-tag" style="margin: 4px; padding: 6px;">
                                                        ${tag}
                                                </div>
                                            </c:forEach>
                                        </span>
                                    </div>
                                </div>
                            </div>
                            <div class="card-body-bottom">
                                <p><i class="fas fa-users"></i> ${GroupVo.attendCount}명</p>
                                <p class="card-text ratingPlace" id="stars${GroupVo.sn}" data-rating='${GroupVo.rating}' data-ratingcount="${GroupVo.ratingCount}">(스타)</p>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>
        </div>
        <div class="pagination">
            <c:if test="${pageMaker3.prev}">
                <li class="paginate_button previous">
                    <a href="${pageMaker3.startPage - 1}">&laquo;</a>
                </li>
            </c:if>

            <c:forEach var="num" begin="${pageMaker3.startPage}" end="${pageMaker3.endPage}">
                <li class="paginate_button">
                    <a href="#" data-kind="pageNum3" class="${pageMaker3.cri.pageNum == num ? "active" : ""}">${num}</a>
                </li>
            </c:forEach>

            <c:if test="${pageMaker3.next}">
                <li class="paginate_button next">
                    <a href="${pageMaker3.endPage + 1}">&raquo;</a>
                </li>
            </c:if>
        </div>
        <input type="hidden" name="pageNum" id="pageNum4" value="${pageMaker3.cri.pageNum}">
        <input type="hidden" name="amount" id="amount4" value="${pageMaker3.cri.amount}">


    </form>

</div>


<script>

    $(document).ready(function () {
        getMakeList();

    });

    function cardClick() {
        $(".card-body").on("click", function () {
            console.log("click");
            $(location).attr('href', '/study/get?sn=' + this.dataset.sn + '&userId=' + '${MemberVo.id}');
        });
    }
    var c;
    function getMakeList() {
        $.ajax({
            url: '/profile/makeStudy' + ".json",
            type: 'GET',
            data: {
                id : '${MemberVo.id}',
                pageNum : 1,
                amount : 6
            },
            success: function(result) {
                c = result;

                innerHTML(result, $("#make")[0], $("#makepagi")[0]);
                cardClick();
            },
            error : function (msg) {

            }
        });
    }

    function innerHTML(result, obj, obj2) {
        let list = result.list;
        let count = result.count;


        let cardstr = "";
        for (let i = 0; i < list.length ; i++) {
            cardstr += makeCard(list[i]);
        }
        makePagi(count);
        $(obj).html(cardstr);
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
        // endDate = endDate.slice(0, 10);


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
            "                        <h2 class='card-title' style='font-size: 25px; margin-bottom: 0px;'>" +
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
            "                <p style='margin-bottom: 3px;'><i class='far fa-calendar-times'></i> " + endDate + "</p>" +
            // "                <p class='card-text ratingPlace' id='stars' data-rating='' data-ratingcount=''>(스타)</p>\n" +
            "            </div>" +
            "        </div>" +
            "    </div>" +
            "</div>";
        return str;
    }



    function makePagi(ratingCnt, obj) {

        let pageNum = 1;
        let groupRatingPageFooter = $("#makepagi");


        let endNum = Math.ceil(pageNum / 5.0) * 5;
        let startNum = endNum - 4;

        let prev = startNum != 1;
        let next = false;

        if(endNum * 5 >= ratingCnt) {
            endNum = Math.ceil(ratingCnt / 5.0);
        }

        if(endNum * 5 < ratingCnt) {
            next = true;
        }

        let str = '<ul class="pagination">';

        if(prev) {
            str += "<li id='rating-item' class='page-item'><a id='rating-link' class='page-link' href='"+(startNum - 1)+"'>Previous</a></li>"
        }

        for(let i= startNum ; i <= endNum; i++) {

            let active = pageNum == i ? "active" : "";

            str += "<li id='rating-item' class='page-item "+active+" '><a id='rating-link' class='page-link' href='"+i+"'>"+i+"</a></li>";
        }

        if(next) {
            str += "<li id='rating-item' class='page-item'><a id='rating-link' class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
        }

        str += "</ul></div>";


        groupRatingPageFooter.html(str);


    }


</script>

