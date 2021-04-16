<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>

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


    <div class="pagination">
        <c:if test="${pageMaker.prev}">
            <a class="paginate_button" href="${pageMaker.startPage-1}">&laquo;</a>
        </c:if>

        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <a href="${num}" class="paginate_button ${pageMaker.cri.pageNum == num ? "active":""}">${num}</a>
        </c:forEach>

        <c:if test="${pageMaker.next}">
            <a class="paginate_button" href="${pageMaker.endPage+1}">&raquo;</a>
        </c:if>
    </div>

    <!-- 스터디 삭제 확인 모달 -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="myModalLabel">Modal title</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">정상적으로 처리되었습니다.</div>
                <div class = "modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
                </div>
            </div>
        </div>
    </div>

    <form id="actionForm" action="/study/list" method="get">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
        <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
        <input type="hidden" name="grpSn" value="${grpSn}">
    </form>
</div>

<script type="text/javascript">
    $(document).ready(function() {

        <!-- 스터디 삭제 후 모달 창-->
        let result = '<c:out value="${result}"/>';

        checkModal(result);

        history.replaceState({}, null, null);


        function checkModal(result) {
            if(result === '' || history.state) {
                return;
            }

            if("success" === result) {
                $(".modal-body").html("스터디가 정상적으로 삭제되었습니다.");
            }

            $("#myModal").modal("show");
        }

        let actionForm = $("#actionForm");

        $(".paginate_button").on("click", function(e) {
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
