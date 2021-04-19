<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>



<!-- Page Content -->
<div class="container">
    <c:if test="${!empty MemberVo}">
        <!-- Heading Row -->
        <div class="row align-items-center my-5">
            <div class="col-lg-7">
                <img id="imgPlace" class="img-fluid rounded mb-4 mb-lg-0" src="/display?fileName=${MemberVo.picture}" alt="">
<%--                <img class="img-fluid rounded mb-4 mb-lg-0" src="/display?fileName=2021%5C04%5C19%2Fb9b4d22b-9d00-469c-92fb-eda4140920df_11.jpg" alt="">--%>
                <c:out value="${MemberVo.name}"/>
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
            <a id="profile" href="#">프로필</a>
        </div>
        <!-- /nav -->

        <div id="content">
            <%@include file="/WEB-INF/views/user/details/group.jsp" %>
        </div>
    </c:if>
    <c:if test="${empty MemberVo}">
        <h1>그런 사용자는 존재하지 않습니다!!!</h1>
    </c:if>

</div>

<script>
    $(".topnav > a").click(function() {

        $(".topnav > a").removeClass('active');
        $(this).addClass('active')
        console.log(this.id +" click!!")

        $.ajax({url:"/user/details/"+this.id ,
            data : {
                id : '${MemberVo.id}'
            },
            success:function(result) {
                $("#content").html(result);
            }});
    });


    console.log("${MemberVo.picture}");
</script>

<script>
    <%--  프로필수정 변수  --%>
    // let modifyMode;
    // let confirmPwd;
    // let password;
    // let confirm_password;
</script>



<%@include file="../includes/footer.jsp" %>
