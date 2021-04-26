<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../../includes/tagLib.jsp" %>


<div id="test1">

</div>
<div id="button">
    button
</div>

<script>
    $(document).ready(function () {
        function tajax(){
            $.ajax({
                url:"/user/details/group/joinListWithPaging",
                data : {
                    id : '${MemberVo.id}',
                    amount : 6,
                    pageNum : 1
                },
                success:function(result) {
                    console.dir(result);
                    $("#test1").html("result");
                }
            });
        }


        $("#button").on("click", function () {
            tajax();
        });
    });


</script>