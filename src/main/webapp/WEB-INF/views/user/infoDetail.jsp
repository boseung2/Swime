<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>

<%@include file="../user/details/info.jsp" %>

<%@include file="../includes/footer.jsp" %>

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
        $(this).addClass('active')
        console.log(this.id +" click!!")

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