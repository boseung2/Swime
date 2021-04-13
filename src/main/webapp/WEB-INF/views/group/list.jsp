<%@ page language="java" contentType="text/html; charset=UTF-8"
        pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>

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
                        <img class="img-fluid rounded mb-4 mb-lg-0" src="http://placehold.it/900x400" alt="">
                        <p class="card-text"><c:out value="${group.tags}"/></p>
                        <h2 class="card-title"><c:out value="${group.name}"/></h2>
                        <p class="card-text"><c:out value="${group.sido}"/><c:out value="${group.sigungu}"/></p>
                        <p class="card-text"><c:out value="${group.description}"/></p>
                    </div>
                    <div class="card-footer">
                        <a href="/group/get?sn=<c:out value="${group.sn}"/>" class="btn btn-primary btn-sm">More Info</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
    <!-- /.row -->

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
<!-- /.container -->

<script type="text/javascript">
    $(document).ready(function(){
        let result = '<c:out value="${result}"/>';

        checkModal(result);

        history.replaceState({}, null, null);

        function checkModal(result) {

            if(result === '' || history.state) {
                return;
            }

            if(parseInt(result) > 0) {
                $('.modal-body').html('모임 ' + parseInt(result) + "번이 등록되었습니다.");
            }

            $("#myModal").modal("show");

            $("#regBtn").on("click", function() {
                self.location = "/group/register";
            })
        }
    })
</script>

<%@include file="../includes/footer.jsp" %>