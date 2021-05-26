<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>

<link href="/resources/css/UserProfileDefault.css" rel="stylesheet">


<div class="content">
    <!-- Page Content -->
    <div class="container">
        <c:if test="${!empty MemberVo}">
            <!-- Heading Row -->
<%--            <div class="row align-items-center my-5">--%>
<%--                <div class="col-lg-7">--%>

            <div class="userContainer">


                    <div class="userbar">
                        <div class="userbarunder">

                        <img id="imgPlace" class="img-fluid mb-4 mb-lg-0" alt="" style="margin-right: 3rem" >
                            <%--                    <img id="imgPlace" class="img-fluid rounded mb-4 mb-lg-0" src="/display?fileName=${MemberVo.picture}" alt="">--%>
                            <%--                    <img id="imgPlace" class="img-fluid rounded mb-4 mb-lg-0" src="${!empty MemberVo.picture ? '/display?fileName=' += MemberVo.picture : '사진없음'}" alt="">--%>
                    <div id="namePlace">${MemberVo.name}</div>
                        </div>
                    </div>
<%--                </div>--%>
                <!-- /.col-lg-8 -->

<%--            </div>--%>
            <div class="topnav">
                <a id="group" class="active">모임</a>
<%--                <a id="groupWithPaging">모임 x</a>--%>
                <a id="study" >스터디</a>
                <a id="written" >작성한 글</a>
                <a id="reply" >작성한 댓글</a>
                <a id="profile" >프로필</a>
            </div>
            </div>
            <!-- /.row -->

            <!-- nav -->
            <!-- /nav -->

            <div id="content">
                컨테츠 표시구역
            </div>
        </c:if>
        <c:if test="${empty MemberVo}">
            <h1>그런 사용자는 존재하지 않습니다!!!</h1>
        </c:if>

    </div>

</div>

<script>


    $(document).ready(function (){

        if(${!empty MemberVo}){
            let profileImg = $("#imgPlace")[0];

            let defaultImg = 'http://placehold.it/900x400';
            let userImg = '/display?fileName=' + "${MemberVo.picture}".replace("s_", '');

            profileImg.src = "${MemberVo.picture}" === 'myPicture.jpeg' || "${MemberVo.picture}" === ''
                ? defaultImg : userImg;

            contentAjax($("#group")[0]);
        }

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


<%@include file="../includes/footer.jsp" %>





