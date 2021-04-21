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
            <h1 class="font-weight-light"><c:out value="${group.name}"/><span style="color:gray;font-size:20px;">[<c:out value="${group.category}"/>]</span></h1>
            <div class="ratingPlace" id="stars${group.sn}" data-rating='<c:out value="${group.rating}"/>' data-ratingcount="<c:out value="${group.ratingCount}"/>"></div>
            <div class="flex-container" style="display: flex;">
                <c:forEach items="${group.tags}" var="tag">
                    <div style="background-color: #f1f1f1;margin: 2px;padding: 2px;font-size: 15px;border-radius: 0.5rem;width: 80px;height: 25px; text-align:center;">
                        <c:out value="${tag}"/>
                    </div>
                </c:forEach>
            </div>
            <p><i class="fas fa-map-marker-alt"></i> <c:out value="${group.sido}"/> <c:out value="${group.sigungu}"/></p>
            <p><i class="fas fa-users"></i> <c:out value="${group.attendCount}"/>명</p>
            <p><i class="fas fa-user"></i>모임장 <c:out value="${group.userName}"/></p>

            <a class="btn btn-primary" href="#" id="attendBtn">모임 가입</a>
                <sec:authorize access="isAuthenticated()">
                    <c:if test="${pinfo.username eq group.userId}">
                        <button data-oper="modify" class="btn btn-primary">모임 수정</button>
                    </c:if>
                </sec:authorize>

<%--            <a class="btn btn-primary" href="#">❤</a>--%>
        </div>
        <!-- /.col-md-4 -->
    </div>
    <!-- /.row -->

    <!-- nav -->
    <div class="topnav">
        <a href="#info" class="active">정보</a>
        <a href="#groupRating">후기</a>
        <a href="#study">스터디</a>
        <a href="#board">게시판</a>
    </div>
    <!-- /nav -->

    <!-- topnav javascript -->
    <script>
        let topnav = document.getElementsByClassName("topnav")[0];
        let sticky = topnav.offsetTop;

        $(document).ready(function() {
            $('.topnav').on("click", "a", function(e) {
                $(".topnav > a").removeClass('active');
                console.dir(e.target);
                $(this).attr("class", "active");
            })
        })

        window.onscroll = function() {myFunction()};

        function myFunction() {
            if(window.pageYOffset >= sticky) {
                topnav.classList.add("sticky");
            } else {
                topnav.classList.remove("sticky");
            }
        }
    </script>

    <div class="main-contents">
    <div id="info" >
        <h4>모임정보</h4>
        <p><pre><c:out value="${group.info}"/></pre></p>
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
    </div>
    <br>

    <hr class="centerHr" id="groupRating">
    <div>
        <h4>후기<sec:authorize access="isAuthenticated()">
            <a class="btn btn-primary" id="addRatingBtn">후기 작성</a>
        </sec:authorize></h4>


        <ul class="rating">
            <li data-sn="12">
                <div>
                </div>
            </li>
        </ul>
    </div>

    <!-- rating pagination button -->
    <div class="panel-footer">

    </div>


    <!-- 스터디 만들기 버튼-->
    <hr class="centerHr" id="study">
        <h4>스터디<sec:authorize access="isAuthenticated()"><a href='/study/register?pageNum=${cri.pageNum}&amount=${cri.amount}&grpSn=${group.sn}' class='btn btn-primary'>스터디 만들기</a></sec:authorize></h4>

    <!-- 스터디 리스트 -->
    <div class="studyList row">
    </div>

    <!-- 스터디 페이징 처리 -->
    <div class="studyPageFooter panel-footer">

    </div>

    <!-- 게시판 -->
    <hr class="centerHr" id="board">
    <div>
        <h4>게시판</h4>
    </div>

    <!-- container -->

    <!-- Call to Action Well -->
    <div class="card text-white bg-secondary my-5 py-4 text-center">
        <div class="card-body">
            <p class="text-white m-0">This call to action card is a great place to showcase some important information or display a clever tagline!</p>
        </div>
    </div>
    </div>
</div>

<!-- 후기 작성/수정 모달 -->
<div class="modal fade" id="groupModal" tabindex="-1" role="dialog"
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
                <button type="button" class="btn btn-warning" id="modalModBtn">수정</button>
                <button type="button" class="btn btn-danger" id="modalRemoveBtn">삭제</button>
                <button type="button" class="btn btn-primary" id="modalRegisterBtn">등록</button>
                <button type="button" class="btn btn-secondary" id="modalCloseBtn" data-dismiss="modal">취소</button>
            </div>
        </div>
    </div>
</div>
<!-- /modal -->

<!-- 스터디 삭제 확인 모달 -->
<div class="modal fade" id="studyModal" tabindex="-1" role="dialog" aria-labelledby="studyModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="studyModalLabel">Modal title</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="studyModalBody modal-body">정상적으로 처리되었습니다.</div>
            <div class = "modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>

<!-- GroupRating Module -->
<script type="text/javascript" src="/resources/js/groupRating.js"></script>


<script type="text/javascript">
    $(document).ready(function() {

        <!-- 스터디 삭제 후 모달 창-->
        let result = '<c:out value="${result}"/>';

        console.log("스터디 삭제 result = " + result);

        checkModal(result);

        history.replaceState({}, null, null);


        function checkModal(result) {

            if(result === '' || history.state) {
                return;
            }

            if("success" === result) {
                $(".studyModalBody").html("스터디가 정상적으로 삭제되었습니다.");
            }
            if("error" === result) {
                $(".studyModalBody").html("스터디 삭제를 실패하였습니다.");
            }

            $("#studyModal").modal("show");
        }
    });
</script>
<!-- GroupAttend Module -->
<script type="text/javascript" src="/resources/js/groupAttend.js"></script>
<!-- StudyList Module -->
<script type="text/javascript" src="/resources/js/studyList.js"></script>




<!-- 모임 참여 -->
<script>
    $(document).ready(function() {

        let grpSnValue = '<c:out value="${group.sn}"/>';
        let attendUL = $(".attend");

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

        showList();

        function showList() {
            groupAttendService.getList({grpSn:grpSnValue}, function(list) {
                let str = "";
                if(list == null || list.length == 0) {
                    attendUL.html("");
                    return;
                }

                for(let i=0, len=list.length || 0; i<len; i++) {
                    str += "<li data-sn='"+list[i].sn+"'>";
                    str += "<div><div class='header'><img src='../../../resources/img/img_avatar2.png' alt='Avatar' class='avatar'>";
                    str += "<span><b>"+list[i].name+"</b></span>\t";
                    str += "<span style='color:gray'>"+list[i].grpRole+"</span></div></div></li>";
                }

                attendUL.html(str);

                //showRatingPage(ratingCnt);
            })
        }

        $("#attendBtn").on("click", function(e) {
            let attend = {
                grpSn : grpSnValue,
                userId : userId
            }

            groupAttendService.add(attend, function(result) {
                alert("모임에 참여했습니다.");
                showList();
                console.log(this);
            })
        })

    })
</script>

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








<!-- 스터디 리스트 -->
<script type="text/javascript">
    $(document).ready(function() {

        <!-- 스터디 삭제 후 모달 창-->
        let result = '<c:out value="${result}"/>';

        console.log("result>>>" + result);

        checkModal(result);

        history.replaceState({}, null, null);


        function checkModal(result) {
            if(result === '' || history.state) {
                return;
            }

            if("success" === result) {
                $(".studyModal").html("스터디가 정상적으로 삭제되었습니다.");
            }
            if("fail" === result) {
                $(".studyModal").html("스터디를 삭제하실 수 없습니다.");
            }
            if("error" === result) {
                $(".studyModal").html("스터디 삭제가 실패하였습니다.");
            }

            $("#studyModal").modal("show");
        }
    });
</script>

<script>
    $(document).ready(function() {
        let grpSnValue = '<c:out value="${group.sn}"/>';
        let studyUL = $('.studyList');

        showStudyList(1);

        function showStudyList(page) {
            studyListService.getList({grpSn:grpSnValue, page: page || 1}, function(count, list) {

                console.log("study count : " + count);
                for(let i = 0, len = list.length; i < len; i++) {
                    console.log(list[i]);
                }

                let str = "";

                if(list == null || list.length == 0) {
                    studyUL.html("");
                    return;
                }

                for(let i = 0, len = list.length || 0; i < len; i++) {

                    str += "<div class='col-md-4 mb-5'>";
                    str += "<div class='card h-100'>";
                    str += "<div class='card-body'>";
                    str += "<h2 class='card-title'>" + list[i].name + "</h2>";

                    if(list[i].endDate != null) str += "<p class='card-text'>" + list[i].startDate.substring(0,10) + " ~ " + list[i].endDate.substring(0,10) + "</p>";
                    else str += "<p class='card-text'>" + list[i].startDate.substring(0,10) + "</p>"
                    str += "<p class='card-text'>" + list[i].startTime.substring(0,5) + " ~ " + list[i].endTime.substring(0,5) + "</p>";

                    if(list[i].onOff === 'STOF01') str += "<p class='card-text'>온라인 스터디</p>";
                    if(list[i].onOff === 'STOF02') str += "<p class='card-text'>오프라인 스터디</p>";

                    <c:if test="list[i].expense == null">str += "<p class='card-text'></p>"; </c:if>
                    <c:if test="list[i].expense != null">str += "<p class='card-text'>" + list[i].expense + "</p>"; </c:if>

                    if(list[i].attendants >= list[i].capacity) str += "<p class='card-text'>모집 마감</p>";
                    else str += "<p class='card-text'>" + list[i].attendants + "/" +  list[i].capacity + "</p>";
                    str += "</div>";
                    str += "<div class='card-footer'>";
                    str += "<a href='/study/get?userId=${pinfo.username}&pageNum=${cri.pageNum}&amount=${cri.amount}&sn=" + list[i].sn + "' class='move btn btn-primary btn-sm'>더보기</a>";
                    str += "</div>";
                    str += "</div>";
                    str += "</div>";
                }

                studyUL.html(str);

                showStudyPage(count);
            })
        }

        <!-- 스터디 페이징 처리 -->
        let studyPageNum = 1;
        let studyPageFooter = $('.studyPageFooter');

        function showStudyPage(studyCount) {

            let endNum = Math.ceil(studyPageNum / 10.0) * 10;
            let startNum = endNum - 9;

            let prev = startNum != 1;
            let next = false;

            if (endNum * 3 >= studyCount) {
                endNum = Math.ceil(studyCount / 3.0);
            }

            if(endNum * 10 < studyCount) {
                next = true;
            }

            console.log("studyCount = " + studyCount);
            console.log("startNum = " + startNum);
            console.log("endNum = " + endNum);
            console.log("prev = " + prev);
            console.log("next = " + next);

            let str = "<ul class ='pagination'>";

            if(prev) {
                str += "<li class = 'page-item'><a class='page-link' href='" + (startNum - 1) + "'>Previous</a></li>";
            }

            for(let i = startNum; i <= endNum; i++) {
                console.log("i=" + i);
                let active = studyPageNum == i ? "active" : "";

                str += "<li class = 'page-item " + active +" '><a class='page-link' href='" + i + "'>" + i + "</a></li>";
            }

            if(next) {
                str += "<li class = 'page-item'><a class='page-link' href='" + (endNum + 1) + "'>Next</a></li>";
            }

            str += "</ul></div>";

            console.log(str);

            studyPageFooter.html(str);
        }

        studyPageFooter.on("click", "li a", function(e) {
            e.preventDefault();

            console.log("study page click");

            let targetPageNum = $(this).attr("href");

            console.log("targetPageNum: " + targetPageNum);

            studyPageNum = targetPageNum;

            showStudyList(studyPageNum);
        })
    })
</script>






<!-- 그룹 후기 작성 -->
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

                if(page === -1) {
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
                    str += "<div><div class='header'><strong>"+list[i].userName+"</strong>";
                    str += "<small> "+list[i].regDate+"</small></div>";
                    str += "<p class='ratingPlace2' id='stars"+list[i].sn+"' data-rating='"+list[i].rating+"'></p>";
                    console.log(list[i]);
                    str += "<p>내용 : "+list[i].review+"</p></div></li>";
                }

                ratingUL.html(str);

                //후기마다 별달기
                let list2 = $('.ratingPlace2');
                for (let i = 0; i < list2.length; i++) {
                    console.log($(list2[i]));
                    $(list2[i]).html(star($(list2[i]).data("rating")) + '<b>' + $(list2[i]).data("rating") + ' </b>');
                }

                showRatingPage(ratingCnt);
            })
        }

        let modal = $("#groupModal");
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
            modal.find("input[name='userId']").attr("readonly", true);
            modal.find("input[name='stdSn']").attr("readonly", false);
            modal.find("button[id != 'modalCloseBtn']").hide();

            modalRegisterBtn.show();

            $('#groupModal').modal("show");

        })

        modalRegisterBtn.on("click", function(e) {

            if(!ratingValidation()){
                console.dir(e);
                e.preventDefault();
                return;
            }

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
                $("#groupModal").modal("hide");

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
                modalInputStdSn.attr("readonly", true);
                modalInputUserId.val(groupRating.userId);
                modalInputUserId.attr("readonly", true);
                modalInputGrpSn.val(groupRating.grpSn);
                modal.data("sn", groupRating.sn);

                modal.find("button[id !='modalCloseBtn']").hide();
                modalModBtn.show();
                modalRemoveBtn.show();

                $("#groupModal").modal("show");
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
                alert("자신이 작성한 리뷰만 수정이 가능합니다.");
                modal.modal("hide");
                return;
            }

            if(!ratingValidation()){
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
                alert("자신이 작성한 리뷰만 삭제가 가능합니다.");
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







<!-- 모임 사진 -->
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
            }).fail(function() {
                $(".uploadResult").html("<img src=/resources/img/group.jpg style='width:500px; height:300px;'>");
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

    })
</script>





<!-- 후기 별 찍기 -->
<script>
    $(document).ready(function() {
        let list = $('.ratingPlace');
        for (let i = 0; i < list.length; i++) {
            $(list[i]).html(star($(list[i]).data("rating")) + '<b>' + $(list[i]).data("rating") + ' </b>(' + $(list[i]).data("ratingcount") + '개)');
        }
    });

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



<!-- 유효성 검사 -->
<script>
    function ratingValidation() {

        if(isNaN($('#rating').val()) || $('#rating').val() == "") {
            alert("점수를 다시 입력해주세요")
            return false;
        }else if($('#rating').val() < 0 || $('#rating').val() > 5) {
            alert("점수는 0~5점까지 입력가능합니다.")
            return false;
        }

        if($("#review").val() == "") {
            alert("후기내용을 입력해주세요");
            return false;
        }else if(getByte($("#review").val()) > 300) {
            alert("후기내용을 100자 이내로 작성해주세요");
            return false;
        }

        if(isNaN($('#stdSn').val()) || $('#stdSn').val() == "" || $('#stdSn').val() <= 0) {
            alert("스터디번호를 다시 입력해주세요");
            return false;
        }

        return true;
    }

    function getByte(str) {
        let byte = 0;
        for (let i=0; i<str.length; ++i) {
            (str.charCodeAt(i) > 127) ? byte += 3 : byte++ ;
        }
        return byte;
    }

</script>


<%@include file="../includes/footer.jsp" %>
