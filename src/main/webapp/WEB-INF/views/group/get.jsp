<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>

<!-- Page Content -->
<div class="container">

    <!-- Heading Row -->
    <div class="row align-items-center my-5">
        <div class="uploadResult">

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

            <a class="btn btn-primary" href="#" id="attendBtn">모임 가입</a>
                <sec:authorize access="isAuthenticated()">
                    <c:if test="${pinfo.username eq group.userId}">
                        <button data-oper="modify" class="btn btn-primary">모임 수정</button>
                    </c:if>
                </sec:authorize>

            <a class="btn btn-primary" href="#">❤</a>
        </div>
        <!-- /.col-md-4 -->
    </div>
    <!-- /.row -->

    <!-- nav -->
    <div class="topnav">
        <a href="#info" class="active">정보</a>
        <a href="#member">모임멤버</a>
        <a href="#groupRating">후기</a>
        <a href="#study">스터디</a>
        <a href="#board">게시판</a>
    </div>
    <!-- /nav -->

    <div id="info">
        <h4>정보</h4>
        <p><c:out value="${group.info}"/></p>
    </div>
    <br>

    <!-- 멤버 리스트 -->
    <div id="groupAttend">
        <h4>모임멤버</h4>
        <ul class="attend">
            <li data-sn="12">
                <div>
                    <div class="header">
                        <img src="../../../resources/img/img_avatar2.png" alt="Avatar" class="avatar">
                        <span>이름</span>
                        <span>모임장</span>
                    </div>
                </div>
            </li>
        </ul>
<%--        <c:forEach items="${attendList}" var="member" varStatus="status">--%>
<%--            <img src="../../../resources/img/img_avatar2.png" alt="Avatar" class="avatar">--%>
<%--            <span><c:out value="${member.name}"/></span>--%>
<%--            <span><c:out value="${member.grpRole}"/></span>--%>
<%--            <c:if test="${status.count % 3 == 0}">--%>
<%--                <br>--%>
<%--            </c:if>--%>
<%--        </c:forEach>--%>
    </div>
    <br>

    <div id="groupRating">
        <h4>후기</h4>
        <sec:authorize access="isAuthenticated()">
            <a class="btn btn-primary" id="addRatingBtn">후기 작성</a>
        </sec:authorize>

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

    <!-- rating paginatino button -->
    <div class="panel-footer">

    </div>

    <!-- 첨부파일 -->
<%--    <h4>사진</h4>--%>
<%--    <div class="uploadResult">--%>
<%--        <ul>--%>
<%--        </ul>--%>
<%--    </div>--%>

    <!-- 첨부파일 확대 -->
<%--    <div class="bigPictureWrapper">--%>
<%--        <div class="bigPicture">--%>
<%--        </div>--%>
<%--    </div>--%>

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
                <h4 class="modal-title">후기</h4>
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
                <label for="grpSn" hidden>그룹번호</label>
                <input type="number" class="form-control" name="grpSn" id="grpSn" hidden>
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
<!-- GroupAttend Module -->
<%--<script type="text/javascript" src="/resources/js/groupAttend.js"></script>--%>


<%--<script>--%>

<%--    $(document).ready(function() {--%>

<%--        let grpSnValue = '<c:out value="${group.sn}"/>';--%>
<%--        let attendUL = $(".attend");--%>

<%--        showList();--%>

<%--        function showList() {--%>
<%--            groupAttendService.getList({grpSn:grpSnValue}, function(list) {--%>
<%--                let str = "";--%>
<%--                if(list == null || list.length == 0) {--%>
<%--                    attendUL.html("");--%>
<%--                    return;--%>
<%--                }--%>

<%--                for(let i=0, len=list.length || 0; i<len; i++) {--%>
<%--                    str += "<li data-sn='"+list[i].sn+"'>";--%>
<%--                    str += "<div><div class='header'><img src='../../../resources/img/img_avatar2.png' alt='Avatar' class='avatar'>";--%>
<%--                    str += "<span>"+list[i].name+"</span>";--%>
<%--                    str += "<span>"+list[i].grpRole+"</span></div></div></li>";--%>
<%--                }--%>

<%--                attendUL.html(str);--%>

<%--                //showRatingPage(ratingCnt);--%>
<%--            })--%>
<%--        }--%>

<%--        $("#attendBtn").on("click", function(e) {--%>
<%--            let attend = {--%>
<%--                grpSn : grpSnValue,--%>
<%--                userId : 'jungbs3726@naver.com'--%>
<%--            }--%>

<%--            groupAttendService.add(attend, function(result) {--%>
<%--                alert("모임에 참여했습니다.");--%>
<%--                showList();--%>
<%--                console.log(this);--%>
<%--            })--%>
<%--        })--%>

<%--    })--%>
<%--</script>--%>

<script type="text/javascript">
    $(document).ready(function() {

        <%--console.log("============");--%>
        <%--console.log("js test");--%>

        <%--let snValue = '<c:out value="${group.sn}"/>';--%>

    //     {"grpSn" : snValue, "userId" : "jungbs3726@naver.com", "grpRole" : "GRRO02", "status" : "GRST01"}
    // ,
    //     function(result) {
    //         alert("RESULT: " + result);
    //     }
    // )groupAttendService.add(


        // groupAttendService.getList({grpSn:snValue}, function(list) {
        //     for(let i=0, len = list.length||0; i<len; i++) {
        //         console.log(list[i]);
        //     }
        // })

        // groupAttendService.withdraw({
        //     sn : 493
        // }, function(result) {
        //     alert("수정완료");
        // })

    })
</script>

<script>

    $(document).ready(function() {

        let grpSnValue = '<c:out value="${group.sn}"/>';
        let ratingUL = $('.rating');

        showList(1);

        function showList(page) {
            groupRatingService.getList({grpSn:grpSnValue, page: page||1}, function(ratingCnt, list) {

                console.log("ratingCnt : " + ratingCnt);
                console.log("list : " + list);
                console.log(list);

                if(page == -1) {
                    pageNum = 1;
                    showList(1);
                    return;
                }

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

                showRatingPage(ratingCnt);
            })
        }

        let modal = $(".modal");
        let modalInputUserId = modal.find("input[name='userId']");
        let modalInputRating = modal.find("input[name='rating']");
        let modalInputReview = modal.find("input[name='review']");
        let modalInputStdSn = modal.find("input[name='stdSn']");
        let modalInputGrpSn = modal.find("input[name='grpSn']");

        let modalModBtn = $('#modalModBtn');
        let modalRemoveBtn = $('#modalRemoveBtn');
        let modalRegisterBtn = $('#modalRegisterBtn');

        let userId = null;
        <sec:authorize access="isAuthenticated()">
            userId = "${pinfo.username}";
        </sec:authorize>

        let csrfHeaderName = "${_csrf.headerName}";
        let csrfTokenValue = "${_csrf.token}";

        // ajax spring security header
        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader(csrfHeaderName, csrfTokenValue);
        });

        $('#addRatingBtn').on("click", function(e) {
            modal.find("input").val("");
            modal.find("input[name='userId']").val(userId);
            modal.find("input[name='userId']").attr("readonly", "readonly");
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

                showList(-1);
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
                modalInputUserId.attr("readonly", true);
                modalInputGrpSn.val(groupRating.grpSn);
                modal.data("sn", groupRating.sn);

                modal.find("button[id !='modalCloseBtn']").hide();
                modalModBtn.show();
                modalRemoveBtn.show();

                $(".modal").modal("show");
            })
        })

        modalModBtn.on("click", function(e) {

            let originalUserId = modalInputUserId.val();

            let groupRating = {sn:modal.data("sn"), userId: originalUserId, rating: modalInputRating.val(),
                                review: modalInputReview.val(), stdSn: modalInputStdSn.val(), grpSn: modalInputGrpSn.val()};

            if(!userId) {
                alert("로그인 후 수정이 가능합니다.");
                modal.modal("hide");
                return;
            }

            console.log("original User id : " + originalUserId);

            if(userId != originalUserId) {
                alert("자신이 작성한 댓글만 수정이 가능합니다.");
                modal.modal("hide");
                return;
            }

            groupRatingService.update(groupRating, function(result) {
                alert(result);
                modal.modal("hide");
                showList(pageNum);
            })
        })

        modalRemoveBtn.on("click", function(result) {

            let sn = modal.data("sn");

            console.log("sn:" + sn);
            console.log("userId" + userId);

            if(!userId) {
                alert("로그인 후 삭제가 가능합니다.");
                modal.modal("hide");
                return;
            }

            let originalUserId = modalInputUserId.val();

            console.log("Original userId: " + originalUserId);

            if(userId != originalUserId) {
                alert("자신이 작성한 댓글만 삭제가 가능합니다.");
                modal.modal("hide");
                return;
            }

            groupRatingService.remove(sn, originalUserId, function(result) {
                alert(result);
                modal.modal("hide");
                showList(pageNum);
            })

        })

        let pageNum = 1;
        let groupRatingPageFooter = $('.panel-footer');

        function showRatingPage(ratingCnt) {

            let endNum = Math.ceil(pageNum / 5.0) * 5;
            let startNum = endNum - 4;

            let prev = startNum != 1;
            let next = false;

            if(endNum * 5 >= ratingCnt) {
                endNum = Math.ceil(ratingCnt / 5.0);
            }

            if(endNum * 5 < ratingCnt) {
                next = true;
            }

            let str = '<ul class="pagination">';

            if(prev) {
                str += "<li class='page-item'><a class='page-link' href='"+(startNum - 1)+"'>Previous</a></li>"
            }

            console.log("!!!!!!!!!!!!!!!!!!!!" + pageNum);
            for(let i= startNum ; i <= endNum; i++) {

                let active = pageNum == i ? "active" : "";

                str += "<li class='page-item "+active+" '><a class='page-link' href='"+i+"'>"+i+"</a></li>";
            }

            if(next) {
                str += "<li class='page-item'><a class='page-link' href='"+(endNum + 1)+"'>Next</a></li>";
            }

            str += "</ul></div>";

            console.log(str);

            groupRatingPageFooter.html(str);

        }

        groupRatingPageFooter.on("click", "li a", function(e) {
            e.preventDefault();

            console.log("page click");

            let targetPageNum = $(this).attr("href");

            console.log("targetPageNum: " + targetPageNum);

            pageNum = targetPageNum;

            showList(pageNum);

        })

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

<script>
    $(document).ready(function() {
        (function() {

            let grpSn = '<c:out value="${group.sn}"/>';

            $.getJSON("/group/getAttach", {grpSn: grpSn}, function(arr) {

                $(arr).each(function(i, attach) {

                    if(attach.fileType) {
                        let fileCallPath = encodeURIComponent(attach.uploadPath+"/"+attach.uuid+"_"+attach.fileName);
                        str = "<img src='/display?fileName="+fileCallPath+"' style='width:500px; height:300px;'>";
                    } else {
                        str = "<img src='/resources/img/attach.png'>";
                    }
                })

                $(".uploadResult").html(str);
            });
        })();

        $(".uploadResult").on("click", "li", function(e) {
            console.log("view image");

            let liObj = $(this);

            let path = encodeURIComponent(liObj.data("path")+ "/" + liObj.data("uuid") + "_" + liObj.data("filename"));

            if(liObj.data("type")) {
                showImage(path.replace(new RegExp(/\\/g),"/"));
            } else {
                self.location = "/download?fileName=" + path
            }
        })

        $(".bigPictureWrapper").on("click", function(e) {
            $(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
            setTimeout(function() {
                $('.bigPictureWrapper').hide();
            }, 300);
        })

        function showImage(fileCallPath) {
            alert(fileCallPath);

            $(".bigPictureWrapper").css("display", "flex").show();

            $(".bigPicture").html("<img src='/display?fileName="+fileCallPath+"'>").animate({width:'100%', height:'100%'}, 1000);
        }

    })
</script>



<%@include file="../includes/footer.jsp" %>
