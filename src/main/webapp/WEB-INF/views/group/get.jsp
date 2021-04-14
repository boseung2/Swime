<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>

<!-- Page Content -->
<div class="container">

    <!-- Heading Row -->
    <div class="row align-items-center my-5">
        <div class="col-lg-7">
            <img class="img-fluid rounded mb-4 mb-lg-0" src="http://placehold.it/900x400" alt="">
        </div>
        <!-- /.col-lg-8 -->
        <div class="col-lg-5">
            <form id="operForm" action="group/modify" method="get">
                <input type="hidden" id="sn" name="sn" value="<c:out value="${group.sn}"/>">
                <input type="hidden" id="pageNum" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
                <input type="hidden" id="amount" name="amount" value="<c:out value="${cri.amount}"/>">
            </form>
            <h1 class="font-weight-light"><c:out value="${group.name}"/></h1>
            <div class="flex-container" style="display: flex;">
                <c:forEach items="${group.tags}" var="tag">
                    <div style="background-color: #f1f1f1;
                                        margin: 2px;
                                        padding: 2px;
                                        font-size: 10px;
                                        border-radius: 0.5rem;">
                        <c:out value="${tag}"/>
                    </div>
                </c:forEach>
            </div>
            <p>지역 <c:out value="${group.sido}"/> <c:out value="${group.sigungu}"/></p>
            <p>총인원 <c:out value="${group.attendCount}"/></p>
            <p>모임장 <c:out value="${group.userName}"/></p>
            <a class="btn btn-primary" href="#">모임 가입</a>
            <button data-oper="modify" class="btn btn-primary">모임 수정</button>
            <a class="btn btn-primary" href="#">❤</a>
        </div>
        <!-- /.col-md-4 -->
    </div>
    <!-- /.row -->

    <!-- nav -->
    <div class="topnav">
        <a href="#info" class="active">정보</a>
        <a href="#member">모임멤버</a>
        <a href="#rating">후기</a>
        <a href="#study">스터디</a>
        <a href="#board">게시판</a>
    </div>
    <!-- /nav -->

    <div id="info">
        <h4>정보</h4>
        <p><c:out value="${group.info}"/></p>
    </div>
    <br>

    <div id="member">
        <h4>모임멤버</h4>
        <c:forEach items="${attendList}" var="member" varStatus="status">
            <img src="../../../resources/image/img_avatar2.png" alt="Avatar" class="avatar">
            <span><c:out value="${member.name}"/></span>
            <span><c:out value="${member.grpRole}"/></span>
            <c:if test="${status.count % 3 == 0}">
                <br>
            </c:if>
        </c:forEach>
    </div>
    <br>

    <div id="groupRating">
        <h4>후기</h4>
        <a class="btn btn-primary" id="addRatingBtn">후기 작성</a>

        <ul class="rating">
            <li data-sn="12">
                <div>
                    <div class="header">
                        <strong>유저</strong>
                        <small>2018-01-01 11:11</small>
                    </div>
                    <p>평점 : 4.5</p>
                    <p>내용</p>
                </div>
            </li>
        </ul>
    </div>

    </div>
    <!-- container -->

    <!-- Call to Action Well -->
    <div class="card text-white bg-secondary my-5 py-4 text-center">
        <div class="card-body">
            <p class="text-white m-0">This call to action card is a great place to showcase some important information or display a clever tagline!</p>
        </div>
    </div>
</div>

<!-- Modal -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <!-- Modal content-->
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">후기 등록</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <div class="form-group">
                    <label for="userId">아이디</label>
                    <input type="text" class="form-control" name="userId" id="userId">
                </div>
                <div class="form-group">
                    <label for="rating">별점</label>
                    <input type="number" class="form-control" name="rating" id="rating">
                </div>
                <div class="form-group">
                    <label for="review">내용</label>
                    <input type="text" class="form-control" name="review" id="review">
                </div>
                <div class="form-group">
                    <label for="stdSn">스터디번호</label>
                    <input type="number" class="form-control" name="stdSn" id="stdSn">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-warning" id="modalModBtn">Modify</button>
                <button type="button" class="btn btn-danger" id="modalRemoveBtn">Remove</button>
                <button type="button" class="btn btn-default" id="modalRegisterBtn" data-dismiss="modal">Register</button>
                <button type="button" class="btn btn-primary" id="modalCloseBtn" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>
<!-- /modal -->

<!-- GroupRating Module -->
<script type="text/javascript" src="/resources/js/groupRating.js"></script>

<script>

    $(document).ready(function() {

        let grpSnValue = '<c:out value="${group.sn}"/>';
        let ratingUL = $('.rating');

        showList(1);

        function showList(page) {
            groupRatingService.getList({grpSn:grpSnValue, page: page||1}, function(list) {
                let str = "";
                if(list == null) {
                    ratingUL.html("");
                    return;
                }
                for(let i=0, len=list.length || 0; i<len; i++) {
                    str += "<li data-sn='"+list[i].sn+"'>";
                    str += "<div><div class='header'><strong>"+list[i].userId+"</strong>";
                    str += "<small>"+list[i].regDate+"</small></div>";
                    str += "<p>"+list[i].rating+"</p>";
                    str += "<p>"+list[i].review+"</p></div></li>";
                }

                ratingUL.html(str);
            })
        }

        let modal = $(".modal");
        let modalInputUserId = modal.find("input[name='userId']");
        let modalInputRating = modal.find("input[name='rating']");
        let modalInputReview = modal.find("input[name='review']");
        let modalInputStdSn = modal.find("input[name='stdSn']");

        let modalModBtn = $('#modalModBtn');
        let modalRemoveBtn = $('#modalRemoveBtn');
        let modalRegisterBtn = $('#modalRegisterBtn');

        $('#addRatingBtn').on("click", function(e) {
            modal.find("input").val("");
            modal.find("button[id != 'modalCloseBtn']").hide();

            modalRegisterBtn.show();

            $('.modal').modal("show");

        })

        modalRegisterBtn.on("click", function(e) {

            let groupRating = {
                grpSn: grpSnValue,
                stdSn: modalInputStdSn.val(),
                userId: modalInputUserId.val(),
                rating: modalInputRating.val(),
                review: modalInputReview.val()
            }

            groupRatingService.add(groupRating, function(result) {
                alert(result);
                modal.find("input").val("");
                modal.modal("hide");

                showList(1);
            })
        })

        $(".rating").on("click", "li", function(e) {

            let sn = $(this).data("sn");

            console.log(">>>>>" + sn);

            groupRatingService.get(sn, function(groupRating) {
                modalInputReview.val(groupRating.review);
                modalInputRating.val(groupRating.rating);
                modalInputStdSn.val(groupRating.stdSn);
                modalInputUserId.val(groupRating.userId);
                modal.data("sn", groupRating.sn);

                modal.find("button[id !='modalCloseBtn']").hide();
                modalModBtn.show();
                modalRemoveBtn.show();

                $(".modal").modal("show");
            })
        })

        modalModBtn.on("click", function(e) {
            let groupRating = {sn:modal.data("sn"), userId: modalInputUserId.val(), rating: modalInputRating.val(),
                                review: modalInputReview.val(), stdSn: modalInputStdSn.val()};

            groupRatingService.update(groupRating, function(result) {
                alert(result);
                modal.modal("hide");
                showList(1);
            })
        })

        modalRemoveBtn.on("click", function(result) {

            let sn = modal.data("sn");

            groupRatingService.remove(sn, function(result) {
                alert(result);
                modal.modal("hide");
                showList(1);
            })

        })

    })
</script>

<script type="text/javascript">
    $(document).ready(function() {

        //console.log("============");
        //console.log("js test");

        //let snValue = '<c:out value="${group.sn}"/>';

        // groupRatingService.add(
        //     {"grpSn" : snValue, "stdSn" : 1, "userId" : "jungbs3726@naver.com", "rating" : 4.3, "review" : "ajax test리뷰"}
        //     ,
        //     function(result) {
        //         alert("RESULT: " + result);
        //     }
        // )

        // groupRatingService.getList({grpSn:snValue, page:1}, function(list) {
        //     for(let i=0, len = list.length||0; i<len; i++) {
        //         console.log(list[i]);
        //     }
        // })

    })
</script>

<script type="text/javascript">
    $(document).ready(function() {

        let operForm = $('#operForm');

        $("button[data-oper='modify']").on("click", function(e) {
            operForm.attr('action', '/group/modify').submit();
        })

    })
</script>




<%@include file="../includes/footer.jsp" %>
