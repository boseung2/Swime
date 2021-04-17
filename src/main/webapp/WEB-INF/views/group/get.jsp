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

    <!-- rating paginatino button -->
    <div class="panel-footer">

    </div>


    <!-- 스터디 리스트 -->
    <div class="studyList row">
    </div>

    <!-- 스터디 페이징 처리 -->
    <div class="studyPageFooter panel-footer">

    </div>

    <!-- 첨부파일 -->
    <h4>사진</h4>
    <div class="uploadResult">
        <ul>
        </ul>
    </div>

    <!-- 첨부파일 확대 -->
    <div class="bigPictureWrapper">
        <div class="bigPicture">
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

<!-- 스터디 삭제 확인 모달 -->
<div class="modal fade" id="studyModal" tabindex="-1" role="dialog" aria-labelledby="studyModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="studyModalLabel">Modal title</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="studyModal modal-body">정상적으로 처리되었습니다.</div>
            <div class = "modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>

<!-- GroupRating Module -->
<script type="text/javascript" src="/resources/js/groupRating.js"></script>
<script type="text/javascript" src="/resources/js/studyList.js"></script>

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
                $(".studyModal").html("스터디가 정상적으로 삭제되었습니다.");
            }

            $("#studyModal").modal("show");
        }
    });
</script>

<script>

    $(document).ready(function() {

        let grpSnValue = '<c:out value="${group.sn}"/>';
        let ratingUL = $('.rating');
        let studyUL = $('.studyList');

        showList(1);
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
                    str += "<p class='card-text'>" + list[i].startDate.substring(0,10) + " ~ " + list[i].endDate.substring(0,10) + "</p>";
                    str += "<p class='card-text'>" + list[i].startTime.substring(0,5) + " ~ " + list[i].endTime.substring(0,5) + "</p>";
                    if(list[i].onOff === 'STOF01') str += "<p class='card-text'>온라인 스터디</p>";
                    if(list[i].onOff === 'STOF02') str += "<p class='card-text'>오프라인 스터디</p>";
                    str += "<p class='card-text'>" + list[i].expense + "</p>";
                    if(list[i].attendants >= list[i].capacity) str += "<p class='card-text'>모집 마감</p>";
                    if(list[i].attendants < list[i].capacity) str += "<p class='card-text'>" + list[i].attendants + "/" +  list[i].capacity + "</p>";
                    str += "</div>";
                    str += "<div class='card-footer'>";
                    str += "<a href='/study/get?sn=" + list[i].sn + "' class='move btn btn-primary btn-sm'>더보기</a>";
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
                modalInputGrpSn.val(groupRating.grpSn);
                modal.data("sn", groupRating.sn);

                modal.find("button[id !='modalCloseBtn']").hide();
                modalModBtn.show();
                modalRemoveBtn.show();

                $(".modal").modal("show");
            })
        })

        modalModBtn.on("click", function(e) {

            let groupRating = {sn:modal.data("sn"), userId: modalInputUserId.val(), rating: modalInputRating.val(),
                                review: modalInputReview.val(), stdSn: modalInputStdSn.val(), grpSn: modalInputGrpSn.val()};

            groupRatingService.update(groupRating, function(result) {
                alert(result);
                modal.modal("hide");
                showList(pageNum);
            })
        })

        modalRemoveBtn.on("click", function(result) {

            let sn = modal.data("sn");

            groupRatingService.remove(sn, function(result) {
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

        //console.log("============");
        //console.log("js test");

        let snValue = '<c:out value="${group.sn}"/>';

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

<script>
    $(document).ready(function() {
        (function() {

            let grpSn = '<c:out value="${group.sn}"/>';

            $.getJSON("/group/getAttachList", {grpSn: grpSn}, function(arr) {
                console.log(arr);

                let str = "";

                $(arr).each(function(i, attach) {

                    if(attach.fileType) {
                        let fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);

                        str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"'><div>";
                        str += "<img src='/display?fileName="+fileCallPath+"'>";
                        str += "</div>";
                        str += "</li>";
                    } else {
                        str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"'data-type='"+attach.fileType+"'><div>";
                        str += "<span> "+attach.fileName+"</span><br/>";
                        str += "<img src='/resources/img/attach.png'>";
                        str += "</div>";
                        str += "</li>";
                    }
                })

                $(".uploadResult ul").html(str);
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
