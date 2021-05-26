<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../../includes/tagLib.jsp" %>


<link href="/resources/css/minicard.css" rel="stylesheet">

<c:set var="defaultImg" value="https://streamyard.com/resources/assets/images/docs/connect-a-facebook-group/connect-a-facebook-group.jpg"/>

<c:set var="cardTitleLength" value="9"/>




<h1>모임</h1>
<hr>

<div class="container">
    <!-- Content Row -->
    <form id="paging" action="/user/details/groupWithPaging" method="get">
        <h2>생성한 모임</h2>
        <div class="row">
            <c:forEach var="GroupVo" items="${ownerList}">
                <div class="col-md-4 mb-5">
                    <div class="card h-100">
                        <div class="card-body" data-sn="${GroupVo.sn}">
                            <div class="card-body-top" style="display:flex;">
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
        <div class="pagination pagination-sm">
            <c:if test="${pageMaker1.prev}">
                <li class="paginate_button previous">
                    <a href="${pageMaker1.startPage - 1}">&laquo;</a>
                </li>
            </c:if>

            <c:forEach var="num" begin="${pageMaker1.startPage}" end="${pageMaker1.endPage}">
                <li class="paginate_button">
                    <a href="#" data-kind="pageNum1" class="${pageMaker1.cri.pageNum == num ? "active" : ""}">${num}</a>
                </li>
            </c:forEach>

            <c:if test="${pageMaker1.next}">
                <li class="paginate_button next">
                    <a href="${pageMaker1.endPage + 1}">&raquo;</a>
                </li>
            </c:if>
        </div>
        <input type="hidden" name="pageNum" id="pageNum1" value="${pageMaker1.cri.pageNum}">
        <input type="hidden" name="amount" id="amount1" value="${pageMaker1.cri.amount}">

        <h2>가입한 모임</h2>
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
        <div class="pagination pagination-sm">
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

        <h2>관심 모임</h2>
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
        <div class="pagination pagination-sm">
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


    </form>

</div>



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

    $(".paginate_button a").on("click", function(e) {
        e.preventDefault();

        // actionForm.find("input[name='pageNum']").val($(this).attr("href"));
        // actionForm.submit();
        // console.dir($(this)[0]);
        // console.log($(this)[0].innerHTML);
        // console.log($(this)[0].dataset.kind);

        $("#"+$(this)[0].dataset.kind)[0].value = $(this)[0].innerHTML;
        // console.log($("#"+$(this)[0].dataset.kind)[0].value);


        $.ajax({
            url:"/user/details/groupWithPaging",
            data : {
                pageNum1 : $("#pageNum1")[0].value,
                pageNum2 : $("#pageNum2")[0].value,
                pageNum3 : $("#pageNum3")[0].value,
                amount1 : $("#amount1")[0].value,
                amount2 : $("#amount2")[0].value,
                amount3 : $("#amount3")[0].value,
                id : '${id}'
            },
            success:function(result) {
                $("#content").html(result);
            }
        });


        <%--$.ajax({--%>
        <%--    url:"/user/details/groupWithPaging",--%>
        <%--    data : {--%>
        <%--        id : '${id}',--%>
        <%--        pageNum : [--%>
        <%--            $("#pageNum1")[0].value,--%>
        <%--            $("#pageNum2")[0].value,--%>
        <%--            $("#pageNum3")[0].value--%>
        <%--        ],--%>
        <%--        amount : [--%>
        <%--            $("#amount1")[0].value,--%>
        <%--            $("#amount2")[0].value,--%>
        <%--            $("#amount3")[0].value--%>
        <%--        ],--%>
        <%--        test : '1234'--%>
        <%--    },--%>
        <%--    success:function(result) {--%>
        <%--        $("#content").html(result);--%>
        <%--    }--%>
        <%--});--%>
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

