<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>
<c:set var="defaultImg" value="https://streamyard.com/resources/assets/images/docs/connect-a-facebook-group/connect-a-facebook-group.jpg"/>

<!-- Page Content -->
    <div class="container">
        <h2>모임 찾기</h2>
        <hr/>
    <!-- Content Row -->
    <div class="row">
        <c:forEach items="${list}" var="group">
            <div class="col-md-4 mb-5">
                <div class="card h-100">
                    <div class="card-body">
                        <div class="uploadResult">
                            <img class="img-fluid rounded mb-4 mb-lg-0" src="${!empty group.picture ? '/display?fileName=' += group.picture : defaultImg}" alt="">
                        </div>
                        <div class="flex-container" style="display: flex;">
                        <c:forEach items="${group.tags}" var="tag">
                            <div style="background-color: #f1f1f1;margin: 2px;padding: 2px;font-size: 15px;border-radius: 0.5rem;width: 80px;height: 25px; text-align:center;">
                            <b><c:out value="${tag}"/></b>
                            </div>
                        </c:forEach>
                        </div>
                        <h2 class="card-title"><c:out value="${group.name}"/><span style="color:gray;font-size:20px;">[<c:out value="${group.category}"/>]</span></h2>
                        <p class="card-text ratingPlace" id="stars${group.sn}" data-rating='<c:out value="${group.rating}"/>' data-ratingcount="<c:out value="${group.ratingCount}"/>"></p>
                        <p class="card-text"><i class="fas fa-map-marker-alt"></i> <c:out value="${group.sido}"/> <c:out value="${group.sigungu}"/></p>
                        <p><i class="fas fa-users"></i> <c:out value="${group.attendCount}"/>명</p>
                        <p class="card-text"><c:out value="${group.description}"/></p>

                    </div>
                    <div class="card-footer">
                        <a href="<c:out value="${group.sn}"/>" class="btn btn-primary btn-sm move">More Info</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <!-- /.row -->

    <!-- pagination -->
    <div class="pagination">
        <c:if test="${pageMaker.prev}">
            <li class="paginate_button previous">
            <a href="${pageMaker.startPage - 1}">&laquo;</a>
            </li>
        </c:if>

        <c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <li class="paginate_button">
                <a href="${num}" class="${pageMaker.cri.pageNum == num ? "active" : ""}">${num}</a>
            </li>
        </c:forEach>

        <c:if test="${pageMaker.next}">
            <li class="paginate_button next">
            <a href="${pageMaker.endPage + 1}">&raquo;</a>
            </li>
        </c:if>
    </div>
    <form id="actionForm" action="/group/list" method="get">
        <input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
        <input type="hidden" name="amount" value="${pageMaker.cri.amount}">
    </form>

    <!-- Modal -->
    <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
    aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">모임</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <p>처리가 완료되었습니다.</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- /.container -->

<script type="text/javascript">
    $(document).ready(function(){
        let result = '<c:out value="${result}"/>';

        checkModal(result);

        history.replaceState({}, null, null);

        function checkModal(result) {

            if (result === '' || history.state) {
                return;
            }

            if (parseInt(result) > 0) {
                $('.modal-body').html('모임 ' + parseInt(result) + "번이 등록되었습니다.");
            }

            $("#myModal").modal("show");
        }

        $("#regBtn").on("click", function() {
            self.location = "/group/register";
        })

        let actionForm = $("#actionForm");

        $(".paginate_button a").on("click", function(e) {

            e.preventDefault();

            console.log('click');

            actionForm.find("input[name='pageNum']").val($(this).attr("href"));
            actionForm.submit();
        })

        $('.move').on("click", function(e) {
            e.preventDefault();
            actionForm.append("<input type='hidden' name='sn' value='" + $(this).attr("href") + "'>");
            actionForm.attr("action", "/group/get");
            actionForm.submit();
        })
    })
</script>

<!-- 별 찍기 -->
<script>
    $(document).ready(function() {
        let list = $('.ratingPlace');
        for (let i = 0; i < list.length; i++) {
            $(list[i]).html(star($(list[i]).data("rating")) + '<b>' + $(list[i]).data("rating") + ' </b>(' + $(list[i]).data("ratingcount") + '개)');
        }
    })
    function star(rating){
        let width = 80 * (rating / 5);
        let tag = ''
            +'<span class="star_score" id="netizen_point_tab_inner">'
            +'  <span class="st_off">'
            +'      <span class="st_on" style="width:' + width + 'px;">'
            +'      </span>'
            +'  </span>'
            +'</span>';
        return tag;
    }
</script>