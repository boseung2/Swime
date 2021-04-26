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