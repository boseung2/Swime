<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>

<!-- Page Content -->
<div class="container">

    <!-- Heading Row -->
    <div class="row align-items-center my-5">
        <div class="col-lg-7">
            <img class="img-fluid rounded mb-4 mb-lg-0" src="http://placehold.it/900x400" alt="">
            <sec:authentication property="principal.memberVO.name"/>
        </div>
        <!-- /.col-lg-8 -->

    </div>
    <!-- /.row -->

    <!-- nav -->
    <div class="topnav">
        <a id="group" href="#" class="active">모임</a>
        <a id="study" href="#">스터디</a>
        <a id="written" href="#">작성한 글</a>
        <a id="reply" href="#">작성한 댓글</a>
        <a id="profile" href="#">프로필 수정</a>
    </div>
    <!-- /nav -->

    <div id="content">
        변화되는부분임!!!
    </div>
</div>





<%--    <div id="info">--%>
<%--        <h4> 정보</h4>--%>
<%--        <p>그룹정보</p>--%>
<%--    </div>--%>
<%--    <div id="member">--%>
<%--        <h4> 모임멤버</h4>--%>
<%--&lt;%&ndash;        <c:forEach items="${attendList}" var="member" varStatus="status">&ndash;%&gt;--%>
<%--&lt;%&ndash;            <img src="../../../resources/image/img_avatar2.png" alt="Avatar" class="avatar">&ndash;%&gt;--%>
<%--&lt;%&ndash;            <span><c:out value="${member.name}"/></span>&ndash;%&gt;--%>
<%--&lt;%&ndash;            <span><c:out value="${member.grpRole}"/></span>&ndash;%&gt;--%>
<%--&lt;%&ndash;            <c:if test="${status.count % 3 == 0}">&ndash;%&gt;--%>
<%--&lt;%&ndash;                <br>&ndash;%&gt;--%>
<%--&lt;%&ndash;            </c:if>&ndash;%&gt;--%>
<%--&lt;%&ndash;        </c:forEach>&ndash;%&gt;--%>
<%--    </div>--%>


<%--    <!-- Call to Action Well -->--%>
<%--    <div class="card text-white bg-secondary my-5 py-4 text-center">--%>
<%--        <div class="card-body">--%>
<%--            <p class="text-white m-0">This call to action card is a great place to showcase some important information or display a clever tagline!</p>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</div>--%>

<%--<script type="text/javascript">--%>
<%--    $(document).ready(function() {--%>

<%--        let operForm = $('#operForm');--%>

<%--        $("button[data-oper='modify']").on("click", function(e) {--%>
<%--            operForm.attr('action', '/group/modify').submit();--%>
<%--        })--%>

<%--    })--%>
<%--</script>--%>

<%--<script>--%>
<%--    let group_btn;--%>
<%--    let study_btn;--%>
<%--    let content_place;--%>

<%--    window.onload = function () {--%>

<%--        content_place = document.getElementById("content");--%>
<%--        group_btn = document.getElementById("group");--%>
<%--        study_btn = document.getElementById("study");--%>


<%--        group_btn.onclick = function (){--%>
<%--            console.log("group");--%>
<%--            content_place.innerHTML = "그룹";--%>

<%--        }--%>

<%--        study_btn.onclick = function (){--%>
<%--            console.log("study");--%>
<%--            content_place.innerHTML = "스터디";--%>
<%--        }--%>

<%--    }--%>
<%--</script>--%>

<%--<script src="./js/jquery-1.11.3.min.js"></script>--%>

<script type="text/javascript">
    $(document).ready(function() {
        $.ajax({url:"/user/details/group",
            success:function(result) {
                $("#content").html(result);
            }});
    });

    $("#group").click(function() {
        $.ajax({url:"/user/details/group",
            success:function(result) {
                $("#content").html(result);
            }});
    });

    $("#study").click(function() {
        $.ajax({url:"/user/details/study",
            success:function(result) {
                $("#content").html(result);
            }});
    });

    $("#written").click(function() {
        $.ajax({url:"/user/details/written",
            success:function(result) {
                $("#content").html(result);
            }});
    });

    $("#reply").click(function() {
        $.ajax({url:"/user/details/reply",
            success:function(result) {
                $("#content").html(result);
            }});
    });

    $("#profile").click(function() {
        $.ajax({url:"/user/details/profile",
            success:function(result) {
                $("#content").html(result);
            }});
    });
</script>



<%@include file="../includes/footer.jsp" %>
