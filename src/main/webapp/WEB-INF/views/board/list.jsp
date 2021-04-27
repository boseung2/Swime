<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>

<style>

    img{
        border-radius: 70%;
        width: 40px;
        height: 40px;
    }

    #notice{
        color: red;
    }
    #role{
        color: #005cbf;
    }
  .board {
      /*width: 800px;*/
      height: 150px;
      background-color: #efefef;
      margin-bottom: 12px;
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
  #regBtn{
      /*float: right;*/
      /*margin-right: 320px;*/
      float: right;
      background: #007bff;
      color: white;
  }
  .pagination{
    text-align: left;
  }


</style>

<!-- Page Content -->
    <div class="container">

        <h3 style="display: inline-block">게시판</h3>
        <button id="regBtn" type="button" class="btn btn-xs pull-right">글쓰기</button>

    <div class="row">
        <c:forEach items="${list}" var="board">

            <div class="board">
                <div id="notice"><b>[필독]</b></div>
                <div style="display: none"><c:out value="${board.sn}"/>번</div>
                <div class="inline"><img class="profile" src="../../../resources/img/img_avatar2.png" alt="error"></div>
                <div class="inline"><c:out value="${board.name}" /></div>
                <div class="inline" id="role"><c:out value="${board.grpRole}"/></div>

                <div class="inline" id="date">
                    <fmt:formatDate pattern="YYYY-MM-dd HH:mm" value="${board.regDate}"/>
                </div>
<%--                <c:out value="${board.sn}"/>--%>
<%--                "/board/get?sn=<c:out value="${board.sn}"/>"--%>
                <div class="width">
                    <b>
                        <a class="move" href='<c:out value="${board.sn}"/>'>
                    <c:out value="${board.title}"/></a>
                    </b>
                </div>

                <div class="width"><c:out value="${board.content}"/></div>

                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-right-text-fill" viewBox="0 0 16 16">
                    <path d="M16 2a2 2 0 0 0-2-2H2a2 2 0 0 0-2 2v8a2 2 0 0 0 2 2h9.586a1 1 0 0 1 .707.293l2.853 2.853a.5.5 0 0 0 .854-.353V2zM3.5 3h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1 0-1zm0 2.5h9a.5.5 0 0 1 0 1h-9a.5.5 0 0 1 0-1zm0 2.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1 0-1z"/>
                </svg>
                <div class="inline"><b style="color: #005cbf"><c:out value="${board.replyCnt}"/> </b></div>

                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-heart-fill" viewBox="0 0 16 16">
                    <path fill-rule="evenodd" d="M8 1.314C12.438-3.248 23.534 4.735 8 15-7.534 4.736 3.562-3.248 8 1.314z"/>
                </svg>
                <div class="inline"><b style="color: #005cbf"><c:out value="${board.likeCnt}"/> </b></div>
            </div>
        </c:forEach>
    </div> <!--row-->

        <!-- pageination -->
        <div class="pagination">

            <c:if test="${pageMaker.prev}">
                <li class="pagination_button previous">
                    <a href="${pageMaker.startPage - 1}">이전</a>
                </li>
            </c:if>

            <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
                <li class="pagination_button" ${pageMaker.cri.pageNum == num? "active" : ""}>
                    <a href="${num}">${num}</a>
                </li>
            </c:forEach>

            <c:if test="${pageMaker.next}">
                <li class="pagination_button next">
                    <a href="${pageMaker.endPage + 1}">다음</a></li>
            </c:if>

        </div> <!--end Pagination-->

        <form id="actionForm" action="/board/list" method="get">
<%--            <input type="hidden" id="sn" name="sn" value="<c:out value="${board.sn}"/> ">--%>
            <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
            <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
        </form>

    </div> <!-- container -->





<script type="text/javascript">

    $(document).ready(function(){

        let result = '<c:out value="${result}"/>';

        history.replaceState({},null,null);

        checkModal(result);

        function checkModal(result){
            //  || history.state
            if(result === ''){
                return;
            }

            if(parseInt(result) > 0){
                $(".modal-body").html("게시글 " + parseInt(result) + "번이 등록되었습니다");
            }

            $("#myModal").modal("show");
        }

        $("#regBtn").on("click", function(){

            self.location = "/board/register";
        });

        let actionForm = $("#actionForm");

        $(".pagination_button a").on("click", function(e){
            e.preventDefault();
            console.log('click');
            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });

        $('.move').on("click", function(e) {
            e.preventDefault();
            actionForm.append("<input type='hidden' name='sn' value='" + $(this).attr("href") + "'>");
            actionForm.attr("action", "/board/get");
            actionForm.submit();
        })




    });

</script>


<%@include file="../includes/footer.jsp" %>
