<%--
  Created by IntelliJ IDEA.
  User: JungHyungJin
  Date: 2021-04-20
  Time: 오후 1:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../../includes/tagLib.jsp" %>


<!-- Page Content -->
<div class="container">
    <c:if test="${!empty MemberVo}">
        <!-- Heading Row -->
        <div class="row align-items-center my-5">
            <div class="col-lg-7">
                <div>
                    <img id="imgPlace" class="img-fluid rounded mb-4 mb-lg-0" alt="">
                        <%--                    <img id="imgPlace" class="img-fluid rounded mb-4 mb-lg-0" src="/display?fileName=${MemberVo.picture}" alt="">--%>
                        <%--                    <img id="imgPlace" class="img-fluid rounded mb-4 mb-lg-0" src="${!empty MemberVo.picture ? '/display?fileName=' += MemberVo.picture : '사진없음'}" alt="">--%>
                </div>
                <div>${MemberVo.name}</div>
            </div>
            <!-- /.col-lg-8 -->

        </div>
        <!-- /.row -->

        <!-- nav -->
        <div class="topnav">
            <a id="groupWithPaging" class="active">모임(공사중)</a>
            <a id="group" >모임</a>
            <a id="study" >스터디</a>
            <a id="written" >작성한 글</a>
            <a id="reply" >작성한 댓글</a>
            <a id="profile" >프로필</a>
        </div>
        <!-- /nav -->

        <div id="content">
            컨테츠 표시구역
        </div>
    </c:if>
    <c:if test="${empty MemberVo}">
        <h1>그런 사용자는 존재하지 않습니다!!!</h1>
    </c:if>

</div>







<script>
    $(document).ready(function (){
        let profileImg = $("#imgPlace")[0];

        let defaultImg = 'http://placehold.it/900x400';
        let userImg = '/display?fileName=' + "${MemberVo.picture}".replace("s_", '');

        profileImg.src = "${MemberVo.picture}" === 'myPicture.jpeg' || "${MemberVo.picture}" === ''
            ? defaultImg : userImg;

        contentAjax($("#group")[0]);
    });

    $(".topnav > a").click(function() {
        $(".topnav > a").removeClass('active');
        $(this).addClass('active');
        console.log(this.id +" click!!");

        contentAjax(this);
    });

    function contentAjax(obj) {
        $.ajax({
            url:"/user/details/" + obj.id,
            data : {
                id : '${MemberVo.id}'
            },
            success:function(result) {
                $("#content").html(result);
            }
        });
    }
</script>