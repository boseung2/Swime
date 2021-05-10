<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../includes/tagLib.jsp" %>
<html>
<head>
    <title>Title</title>
    <style>
        .modal{
            position:absolute;
            width:100%;
            height:100%;
            background: rgba(0,0,0,0.8);
            top:0;
            left:0;
            display:none;
        }

        .modal_content{
            margin: auto;
        }

    </style>
</head>
<body>
test


    <button>모달창</button>

    <div class="modal">
        <div class="modal_content" title="클릭하면 창이 닫힙니다.">
            여기에 모달창 내용을 적어줍니다.<br>
            이미지여도 좋고 글이어도 좋습니다.
        </div>
    </div>

</body>
</html>

<%--<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js" crossorigin="anonymous"></script>--%>
<%--<script src="https://d3js.org/d3-color.v1.min.js"></script>--%>
<%--<script src="https://d3js.org/d3-interpolate.v1.min.js"></script>--%>
<%--<script src="https://d3js.org/d3-scale-chromatic.v1.min.js"></script>--%>

<script>
    $("button").click(function(){
        $(".modal").fadeIn();
    });

    $(".modal_content").click(function(){
        $(".modal").fadeOut();
    });


</script>