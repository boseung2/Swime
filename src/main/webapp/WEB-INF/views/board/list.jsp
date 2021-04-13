<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<%@include file="../includes/header.jsp" %>

<style>

    #notice{
        color: red;
    }
    #role{
        color: #005cbf;
    }
  .board {
      width: 800px;
      height: 150px;
      background-color: #efefef;
      margin-bottom: 10px;
  }

  div div{
      margin-left: 10px;
      visibility: visible;
  }
  .profile{
      width: 30px;
      height: 30px;
  }
  .inline{
      display: inline-block;
  }
  #date{
      float: right;
      margin-right: 50px;
  }
  svg{
      margin-left: 13px;
  }
  .width{
      width: 550px;
  }

</style>

<div class="container">

    <c:forEach items="${list}" var="board">
    <div class="board">
        <div id="notice"><b>[필독]</b></div>
        <div class="inline"><img class="profile" src=resources/css/ alt="error"></div>
        <div class="inline"><c:out value="${board.name}" /></div>
        <div class="inline" id="role">모임장</div>
        <div class="inline" id="date"> <fmt:formatDate pattern="yyyy-mm-dd hh:mm"
                                                       value="${board.regDate}"/></div>

        <div class="width"><b><c:out value="${board.title}"/></b></div>
        <div class="width"><c:out value="${board.content}"/></div>

        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-right-text-fill" viewBox="0 0 16 16">
            <path d="M16 2a2 2 0 0 0-2-2H2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h9.586a1 1 0 0 1 .707.293l2.853 2.853a.5.5 0 0 0 .854-.353V2zM3.5 3h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1 0-1zm0 2.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1 0-1zm0 2.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1 0-1z"/>
        </svg>
        <div class="inline"><b style="color: #005cbf">5</b></div>

        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
            <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
        </svg>
        <div class="inline"><b style="color: #005cbf">5</b></div>
    </div>
    </c:forEach>

</div>


<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Modal Header</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <p>처리가 완료되었습니다.</p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>
</div>



<script type="text/javascript">

    $(document).ready(function(){

        let result = '<c:out value="${result}"/>';

        checkModal(result);

        function checkModal(result) {
            if(result === '') {
                return;
            }
            if(parseInt(result) > 0) {
                $('.modal-body').html('게시글 ' + parseInt(result) + "번이 등록되었습니다.");
            }
            $("#myModal").modal("show");

            $("#regBtn").on("click", function() {
                self.location = "/board/register";
            })
        }
    })


</script>


<%@include file="../includes/footer.jsp" %>