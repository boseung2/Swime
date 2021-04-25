<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../../includes/tagLib.jsp" %>

<c:set var="defaultImg" value="https://streamyard.com/resources/assets/images/docs/connect-a-facebook-group/connect-a-facebook-group.jpg"/>

<c:set var="cardTitleLength" value="10"/>

<h1>모임</h1>
<hr>

<div class="container">
    <!-- Content Row -->
    <h2>생성한 모임</h2>
    <div class="row">
        <c:forEach var="GroupVo" items="${ownerList}">
            <div class="col-md-4 mb-5">
                <div class="card h-100">
                    <div class="card-body">
                        <div style="display:flex;">
                            <div class="uploadResult">
                                <img class="img-fluid rounded mb-4 mb-lg-0" src="${!empty group.picture ? '/display?fileName=' += group.picture : defaultImg}" alt="">
                            </div>
                            <div>
                                <div>
        <%--                            <h2 class="card-title">${fn:length(GroupVo.name) }--%>
        <%--                            <h2 class="card-title" style="font-size: 25px;">${GroupVo.name}--%>
                                    <h2 class="card-title" style="font-size: 25px; margin-bottom: 0px;">
                                            ${fn:length(GroupVo.name) > cardTitleLength
                                            ? fn:substring(GroupVo.name,0,9) += '...'
                                            : GroupVo.name}
                                    </h2>
                                    <span class="flex-container" style="display: flex;">
                                        <div style="
                                            background-color: #fccaca;
                                            margin: 2px;
                                            padding: 2px;
                                            font-size: 15px;
                                            border-radius: 0.5rem;
                                            width: 80px;
                                            height: 25px;
                                            text-align:center;">
                                            tag
                                        </div>
                                    </span>
                                </div>
                            </div>
                        </div>
<%--                        <div>--%>
<%--                            <div>--%>
                                <div style="display: flex; height: 20px;margin-top: 10px">
                                    <p><i class="fas fa-users"></i> ${GroupVo.attendCount}명</p>
<%--                                    <p class="card-text ratingPlace" id="stars1323" data-rating='' data-ratingcount="1">(스타)</p>--%>
                                    <p class="card-text ratingPlace" id="stars${GroupVo.sn}" data-rating='${GroupVo.rating}' data-ratingcount="${GroupVo.ratingCount}">(스타)</p>
                                </div>
<%--                            </div>--%>
<%--                        </div>--%>
<%--                        <div class="card-footer">--%>
<%--                            <a href="/group/get?sn=${GroupVo.sn}" class="btn btn-primary btn-sm move">More Info</a>--%>
<%--                        </div>--%>
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
                    <div class="card-body">
                        <div class="uploadResult">
                            <img class="img-fluid rounded mb-4 mb-lg-0" src="${!empty group.picture ? '/display?fileName=' += group.picture : defaultImg}" alt="">
                        </div>
                        <div class="flex-container" style="display: flex;">
                            <div style="background-color: #f1f1f1;margin: 2px;padding: 2px;font-size: 15px;border-radius: 0.5rem;width: 80px;height: 25px; text-align:center;">
                                tag
                            </div>
                        </div>
                        <h2 class="card-title">${GroupVo.name}<span style="color:gray;font-size:20px;">[cat]</span></h2>
                        <p class="card-text ratingPlace" id="stars1213" data-rating='' data-ratingcount="1"></p>
                        <p class="card-text"><i class="fas fa-map-marker-alt"></i> aaaa bbb</p>
                        <p><i class="fas fa-users"></i> 참여자수
                        <p class="card-text">설명

                    </div>
                    <div class="card-footer">
                        <a href="/group/get?sn=${GroupVo.sn}" class="btn btn-primary btn-sm move">More Info</a>
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
                    <div class="card-body">
                        <div class="uploadResult">
                            <img class="img-fluid rounded mb-4 mb-lg-0" src="${!empty group.picture ? '/display?fileName=' += group.picture : defaultImg}" alt="">
                        </div>
                        <div class="flex-container" style="display: flex;">
                            <div style="background-color: #f1f1f1;margin: 2px;padding: 2px;font-size: 15px;border-radius: 0.5rem;width: 80px;height: 25px; text-align:center;">
                                tag
                            </div>
                        </div>
                        <h2 class="card-title">${GroupVo.name}<span style="color:gray;font-size:20px;">[cat]</span></h2>
                        <p class="card-text ratingPlace" id="stars123" data-rating='' data-ratingcount="1"></p>
                        <p class="card-text"><i class="fas fa-map-marker-alt"></i> aaaa bbb</p>
                        <p><i class="fas fa-users"></i> 참여자수
                        <p class="card-text">설명

                    </div>
                    <div class="card-footer">
                        <a href="/group/get?sn=${GroupVo.sn}" class="btn btn-primary btn-sm move">More Info</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<endPoint id="end" style="width: 0;height: 0;float: left;"/>

<br>---------asdsadasdsd-------------
<c:forEach var="GroupVo" items="${ownerList}">
    ${GroupVo}
</c:forEach>

<script>
    if($("#end")[0] !== undefined){
        // $("#height").css("height", $("#end").offset().top - $("#height").offset().top);
    }
</script>