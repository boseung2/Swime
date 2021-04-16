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
