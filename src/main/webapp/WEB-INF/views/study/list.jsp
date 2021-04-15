<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>
<style>
    * {
        box-sizing: border-box;
    }

    body {
        font-family: Arial, Helvetica, sans-serif;
    }

    /* Float four columns side by side */
    .column {
        float: left;
        width: 25%;
        padding: 0 10px;
    }

    /* Remove extra left and right margins, due to padding */
    .row {margin: 0 -5px;}

    /* Clear floats after the columns */
    .row:after {
        content: "";
        display: table;
        clear: both;
    }

    /* Responsive columns */
    @media screen and (max-width: 600px) {
        .column {
            width: 100%;
            display: block;
            margin-bottom: 20px;
        }
    }

    /* Style the counter cards */
    .card {
        box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
        padding: 16px;
        text-align: center;
        background-color: #f1f1f1;
    }
</style>

<div class="row">
    <c:forEach items="${list}" var="study">
    <c:set var="startDate" value="${study.startDate}"/>
    <c:set var="endDate" value="${study.endDate}"/>
    <c:set var="startTime" value="${study.startTime}"/>
    <c:set var="endTime" value="${study.endTime}"/>
        <div class="col-md-4 mb-5">
            <div class="card h-100">
                <div class="card-body">
                    <h2 class="card-title">${study.name}</h2>
                    <p class="card-text">${fn:substring(startDate,0,10)} ~ ${fn:substring(endDate,0,10)}</p>
                    <p class="card-text">${fn:substring(startTime,0,5)} ~ ${fn:substring(endTime,0,5)}</p>
                    <c:if test="${study.onOff eq 'STOF01'}"><p class="card-text">온라인 스터디</p></c:if>
                    <c:if test="${study.onOff eq 'STOF02'}"><p class="card-text">오프라인 스터디</p></c:if>
                    <p class="card-text">${study.expense}</p>
                    <c:if test="${study.attendants >= study.capacity}"><p class="card-text">모집 마감</p></c:if>
                    <c:if test="${study.attendants < study.capacity}"><p class="card-text">${study.attendants} / ${study.capacity}</p></c:if>
                </div>
                <div class="card-footer">
                    <a href="${study.sn}" class="move btn btn-primary btn-sm">더보기</a>
                </div>
            </div>
        </div>
    </c:forEach>


    <ul class="pagination">
        <c:if test="${pageMaker.prev}">
            <li class="paginate_button previous"><a href="${pageMaker.startPage-1}">Previous</a></li>
        </c:if>

        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <li class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""}"><a href="${num}">${num}</a></li>
        </c:forEach>

        <c:if test="${pageMaker.next}">
            <li class="paginate_button previous"><a href="${pageMaker.endPage+1}">Next</a></li>
        </c:if>
    </ul>

    <form id="actionForm" action="/study/list" method="get">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
        <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
        <input type="hidden" name="grpSn" value="${grpSn}">
    </form>
</div>

<script type="text/javascript">
    $(document).ready(function() {

        let actionForm = $("#actionForm");

        $(".paginate_button a").on("click", function(e) {
            e.preventDefault();

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        });

        $(".move").on("click", function(e) {
            e.preventDefault();

            actionForm.find("input[name='grpSn']").remove();
            actionForm.append("<input type='hidden' name='sn' value='" + $(this).attr("href") + "'>");
            actionForm.attr("action", "/study/get");
            actionForm.submit();
        })
    })
</script>

<%@include file="../includes/footer.jsp" %>
