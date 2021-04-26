<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>

<style>
    @media screen and (max-width: 500px) {
        .topnav a {
            float: none;
            display: block;
            text-align: left;
            font-size: 13px;
            height: 40px;
        }

        .header-right {
            float: none;
        }
    }
    .content {
        min-height: calc(100vh - 26vh);
    }

    footer {
        margin-top: 30px;
    }

    /*.card-cat {*/
    /*    background-color: #f1f1f1;*/
    /*    margin: 2px;*/
    /*    padding: 2px;*/
    /*    font-size: 15px;*/
    /*    border-radius: 0.5rem;*/
    /*    width: 80px;*/
    /*    height: 25px;*/
    /*    text-align:center;*/
    /*}*/

    .uploadResult > img {
        height: 70px;
    }
</style>

<div class="content">
    <%@include file="../user/details/info.jsp" %>
</div>

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