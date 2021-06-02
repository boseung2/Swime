<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>


<%@include file="../includes/header.jsp" %>
<%@include file="../includes/pictogramLib.jsp" %>
<%@include file="../includes/tagLib.jsp"%>

<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal" var="pinfo"/>
    <sec:authentication property="principal.memberVO" var="mv"/>
</sec:authorize>
<link rel="stylesheet" href="/resources/css/board-get.css">


<div class="container">
    <div class="row">
        <div class="col-lg-12">


            <c:if test="${board.topFix == 'BOFI02'}">
                <div id="notice">[공지사항]</div>
            </c:if>
            <div id="inline3">
                <!--사진 이거 div만 냅기고 for문 돌고 가져와야하나..
                src='"+ "/display?fileName=" + list[i].picture.replace('s_','')+"'
                -->
<%--                <div class="inline" id="img"><img class="profile" src="../../../resources/img/img_avatar2.png" alt="error"></div>--%>
                <c:if test="${board.picture ne null && board.picture ne 'myPicture.jpeg'}">
                    <div class="inline" id="img"><img class="profile" src="/display?fileName=${board.picture}" alt="error"></div>
                </c:if>

                <c:if test="${board.picture eq null || board.picture eq 'myPicture.jpeg'}">
                    <div class="inline" id="img"><img class="profile" src="https://image.flaticon.com/icons/png/512/3237/3237472.png" alt="error"></div>
                </c:if>


                <div class="inline" id="name"><c:out value="${board.name}" /></div>
                <div class="inline" id="role"></div>
            </div>



            <div id="inline2">
                <!--모임참석 x -> 수정버튼 x
                    모임참석 o
                    모임장,운영진 -> 자기자신 포함, 일반회원 수정가능,  하지만 운영진은 모임장 수정 x
                    일반회원 -> 자기자신만 수정가능
                    참석자 리스트 가져와서 권한확인
                -->

                <c:set var="done" value="false"/>
                <sec:authorize access="isAuthenticated()">
                    <c:forEach var = "attendant" items="${groupAttendList}">
                        <c:if test="${not done}">
                            <c:choose>
                                <%--모임장이면 전체 수정--%>
                                <c:when test="${group.grpRole eq 'GRRO01'}">
                                    <button data-oper='modify' class="btn btn-primary">수정</button>
                                </c:when>
                                <%--운영자는 일반회원, 자기 자신 /But 운영자이면서 다른 사람이면 수정x--%>
                                <c:when test="${group.grpRole eq 'GRRO02' and board.grpRole ne 'GRRO01' and mv.id eq board.userId}">

                                    <button data-oper='modify' class="btn btn-primary">수정</button>
                                </c:when>

                                <c:when test="${mv.id eq board.userId}">
                                    <button data-oper='modify' class="btn btn-primary">수정</button>
                                </c:when>
                            </c:choose>
                <c:set var="done" value="true"/>
                        </c:if>
                    </c:forEach>
                </sec:authorize>

                <button data-oper="list" class="btn btn-dark">취소</button>


            <%--                <a id="back" class="btn btn-dark">취소</a>--%>

<%--                <button data-oper="modify" class=""--%>


<%--                <form id="modifyForm" role="form" action="/board/remove" method="post">--%>
<%--                    <button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>--%>
<%--                    <sec:csrfInput/>--%>
<%--                </form>--%>
<%--                                    <button data-oper='remove' class="btn btn-default">삭제</button>--%>
<%--                <input type="text" class="form-control" id="userId" name="name"--%>
<%--                       value="${board.userId}" readonly="readonly">--%>


            </div>
            <form id="operForm" action="/board/modify" method="get">
                <input type="hidden" id="sn" name="sn" value="${board.sn}">
<%--                <input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum}">--%>
<%--                <input type="hidden" id="amount" name="amount" value="${cri.amount}">--%>
                <input type="hidden" class="form-control" id="grpSn" name="grpSn" value="${board.grpSn}">
                <input type="hidden" class="form-control" id="grpSn2" name="userId" value="${pinfo.username}">
            </form>


            <div id="date">
                <fmt:formatDate pattern="YYYY-MM-dd hh:mm" value="${board.regDate}"/>
            </div>


            <div class="form-group">
                <label for="title">제목</label>
                <input type="text" class="form-control" id="title" name="title"
                       value="<c:out value="${board.title}"/>" readonly="readonly">
            </div>


            <div class="form-group">
                <label for="content">내용</label>
                <textarea class="form-control" rows="5" id="content" name="content" readonly="readonly"><c:out value="${board.content}"/></textarea>
            </div>

<%--            <div class="form-group">--%>
<%--                <label>사진</label>--%>
<%--            </div>--%>
            <!--class = form-group -> uploadResult -->
            <div class="form-group">
                <p>이미지</p>

                <ul class="uploadResult">

                </ul>
                <hr>
                <p>첨부파일</p>
                <ul class="uploadResult2">

                </ul>

            </div>

            <div class="form-group" style="display: inline-block">
                <label>댓글</label>
                <label id="replyCnt"><c:out value="${board.replyCnt}"/> </label>
            </div>

            <div id="likeBundle" class="form-group" style="display: inline-block">
                <i id="likeCnt1" class="fa-heart" style='font-size:20px;color:red'></i>
            </div>

                <label>좋아요</label>
<%--                <label><c:out value="${board.likeCnt}"/> </label>--%>
<%--                <label>${count}</label>--%>
                <label id="likeCnt"><c:out value="${board.likeCnt}"/> </label>

            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

            <hr>

            <!--panel-->

<%--            <div class="panel panel-default">--%>
<%--                <div class="panel-heading">--%>
<%--                    <i>댓글</i>--%>
<%--                </div>--%>
<%--            </div>--%>

            <!--댓글 -->
<%--            <div class="reply_box">--%>
                <div class="panel-body">
<%--                    <img class="reply_profile2" src="../../../resources/image/img_avatar2.png" alt="error">--%>

                    <ul class="chat">


                        <!-- 댓글 시작 .........................-->
                        <li class="left clearfix" data-sn="12">
                            <div>
                                <div class="header2">
                                    <strong class="primary-font"></strong>
                                    <small class="pull-right text-muted"></small>

                                    <button id='replyDeleteBtn' type="button" class="replyDelete"></button>
                                    <button id='replyModifyBtn'type="button" class="replyModify"></button>
                                    <button id='boardUserRepot' type="button" class="boardUserRepot"></button>

                                </div>
                                <p></p>
                                <button class="replySubmit" type="submit"></button>
                            </div>
                        </li> <!--end li -->
                    </ul>

                </div> <!--end panel-body-->
<%--            </div> <!--end reply box-->--%>

        <!--비로그인 : 댓글 입력 x
            로그인 O 모입가입 x : 댓글 입력 x
            로그인 O 모입가입 O : 댓글 입력 O

            로그인 안한 사람 -> "로그인한 후 입력해주세요!"
            [1] 변수 exist ->t/f
            로그인한 계정 : toywar / 참석자 계정 : toywar -> "댓글입력해주세요" (exist =1 )
            로그인한 계정 : toywar / 참석자리스트에 없을 경우 -> "모임 가입 후 댓글입력해주세요"

            [2] display : exist == t/f
            pinfo.username forloop match! -> 댓글입력

        -->

            <div class="commentWriter">
                <div class="comment_inbox">
                    <c:set var="done" value="false"/>
                    <sec:authorize access="isAuthenticated()">

                        <c:forEach var = "attendant" items="${groupAttendList}">

                            <c:if test="${attendant.userId eq pinfo.username}">

                                <c:set var="exist" value="true"/>
                            </c:if>

                        </c:forEach>
                            <c:if test="${exist}">
                                <textarea id='replyComment' placeholder="댓글을 입력해주세요" rows="1" class="comment_inbox_text" style="overflow: hidden; overflow-wrap: break-word; height: 18px" required></textarea>
                                <div class="register_box">
                                    <button id='replyRegisterBtn' role="button" class="button btn_register is_active">등록</button>
                                </div>
                            </c:if>
                            <c:if test="${not exist}">
                                <textarea id='replyComment' placeholder="모임가입 후 댓글을 입력하실 수 있습니다." rows="1" class="comment_inbox_text" style="overflow: hidden; overflow-wrap: break-word; height: 18px" required></textarea>
                            </c:if>

                    </sec:authorize>

                    <sec:authorize access="isAnonymous()">
                        <textarea id='replyComment' placeholder="로그인 후 댓글을 입력할 수 있습니다." rows="1" class="comment_inbox_text" style="overflow: hidden; overflow-wrap: break-word; height: 18px" required></textarea>
                    </sec:authorize>
                </div><!-- end comment_inbox-->

            </div><!-- end commentWriter-->
            <!--end 댓글 입력 창-->

        </div> <!-- ./col-lg-12-->

    </div><!-- row -->

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" style="float: left">댓글 수정</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>

                <div class="modal-body">

                    <div class="form-group">
                        <label>작성자</label>
                        <input class="form-control" id="replyName" name="name" value="작성자" readonly="readonly">
                    </div>

                    <div class="form-group">
                        <label>내용</label>
                        <input class="form-control" id="replyContent" name="content" value="내용">
                    </div>

                    <div class="form-group">
                        <label>날짜</label>
                        <input class="form-control" name="regDate" value="날짜">
                    </div>

                </div>

                <div class="modal-footer">
                    <button id="modalModBtn" type="button" class="btn btn-primary">수정</button>
                    <button id="modalCloseBtn" type="button" class="btn btn-dark" data-dismiss="modal">취소</button>
                </div>

            </div>
        </div>
    </div>


</div><!--container-->

<!--boardReply-->
<script type="text/javascript" src="/resources/js/boardReply.js"></script>
<!--boardLike-->
<script type="text/javascript" src="/resources/js/boardLike.js"></script>


<script>

    $(document).ready(function(){

        let operForm = $("#operForm");
        let brdSn = ${board.sn};
        console.log(brdSn);

        $("button[data-oper='modify']").on("click",function(){
            operForm.attr("action", "/board/modify").submit();

        })


        // http://localhost/group/get?sn=720
        $("button[data-oper='list']").on("click",function(){
            console.log("return list");
            $(location).attr('href', '/group/get?sn=' + '${board.grpSn}');
        });

    });

</script>

<script>

    $(document).ready(function(){

        console.log(".......................")
        console.log("JS TEST")

        let snValue = '<c:out value="${board.sn}"/> ';
        let replyUL = $(".chat");

        let replyComment = $('#replyComment'); //댓글 내용
        let replyRegisterBtn = $('#replyRegisterBtn'); //댓글 버튼

        //modalData
        let modal = $(".modal")
        let modalInputContent = modal.find("input[name=content]");
        let modalInputName = modal.find("input[name=name]");
        let modalInputRegDate = modal.find("input[name=regDate]");

        let modalModBtn = $('#modalModBtn');
        let modalCloseBtn = $('#modalCloseBtn');



        //게시판 상세 조회 시 첨부파일
        $.getJSON("/board/getAttachList", {brdSn : snValue}, function(arr){
            console.log("게시판 brdSn" + snValue)
            console.log(arr);

            let str = "";
            let str2 = "";
            $(arr).each(function(i, attach) {

            console.log(attach.fileType);

            console.log(attach.uploadPath);
            console.log(attach.uuid);
            console.log(attach.fileName);

            //https://dev-timero.tistory.com/96 참고 자료
                //이미지면 true 첨부면 false이다. attach.filetype이 첨부면 false찍히는데
                //if문에서는 true로 간다. 해결방법은 위에 참고 자료 봐가지고 해결.
            let attachFileType = (attach.fileType === 'true');

            if(attachFileType){
                console.log("if");
                let fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
                str += "<li data-path='"+attach.uploadPath+"'";
                str += "data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"'data-type='"+attach.fileType+"'";
                str += "><div>";
                str += "<img src='/display?fileName="+fileCallPath+"'>";
                str += "</div>";
                str += "</li>";
            } else {
                //return;
                console.log("else");
                str2 += "<li data-path='"+attach.uploadPath+"'";
                str2 += "data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"'data-type='"+attach.fileType+"'";
                str2 += "><div>";
                str2 += "<div> "+attach.fileName+"</div>";
                str2 += "<img src='../../../resources/img/1.png'>";
                str2 += "</div>";
                str2 += "</li>";

            }

        })

            $(".uploadResult").html(str);
            $(".uploadResult2").html(str2);


        }).fail(function() {
            $(".uploadResult").html("<img src=/resources/img/group.jpg style='width:400px; height:200px;'>");
        }); // end getJSON

        //첨부파일 클릭 시 다운로드 1
        $(".uploadResult2").on("click", "li", function(e) {
            console.log("view image");

            let liObj = $(this);

            let path = encodeURIComponent(liObj.data("path")+ "/" + liObj.data("uuid") + "_" + liObj.data("filename"));

            if(liObj.data("type")) {
                showImage(path.replace(new RegExp(/\\/g),"/"));
            } else {
                self.location = "/download?fileName=" + path
            }
        });
        //이미지 확대.
        // function showImage(fileCallPath){
        //     console.log(fileCallPath);
        //     $('.bigPictureWrapper').css("display", "flex").show();
        //
        //     $('.bigPicture')
        //     .html("<img src='/display?fileName="+fileCallPath+"'>")
        //     .animate({width:'100%', height: '100%'},1000);
        //
        // }


        //userid = 이메일,  id = 이름
        //댓글 등록할 때 insert는 userid로 get은 id로 mv.id 이메일
        let userId = 'null';
        <sec:authorize access="isAuthenticated()">
                userId = '${mv.id}';
        </sec:authorize>

        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        });

        //{brdSn:snValue, userId:"toywar1@naver.com",content:"댓글 테스트2", status:"RPST01"}



        //댓글 수정
        $(".chat").on("click", "button[id='replyModifyBtn']", function(e){
            console.log("modify Clicked");

            let sn = $(this).data("sn");
            console.log("replySn : "+sn);

            $(".modal").modal("show");

            //replyVal = $("p[id='replyContent']").innerHTML;

            //modal.find("input").val("");
            modalInputRegDate.closest("div").hide();


            replyService.get(sn, function(reply){
                console.log("userName : " +reply.name);
                console.log("replyContent : " +reply.content);
                console.log("replySn : " + reply.sn);
                console.log("regDate : " + replyService.displayTime(reply.regDate));
                modalInputName.val(reply.name);
                modalInputContent.val(reply.content);
                modalInputRegDate.val(replyService.displayTime(reply.regDate))
                .attr("readonly","readonly");
                modal.data("sn", reply.sn);


                modalModBtn.on("click", function(e){

                    console.log("modalModBtnClick..");
                    let modReply = {
                        sn : modal.data("sn"),
                        content : modalInputContent.val(),
                        userId : userId,
                        status  : "RPST01"
                    }
                    replyService.update(modReply, function(result){
                        console.log("modReplyContent:"+modReply.content);
                        console.log("modReplyBrdSn:"+modReply.sn);

                        //alert('댓글이 수정되었습니다.');
                        modal.modal("hide");
                        showList(1);
                    });

                });
            });


        });

        //댓글 삭제
        $(".chat").on("click", "button[id='replyDeleteBtn']", function(e){
            console.log("RemoveClicked");

            let sn = $(this).data("sn")
            let isDelete = confirm('댓글을 삭제하시겠습니까?');

            console.log("replySn : " + sn);
            console.log("replyUserId : " + userId)

            if(isDelete){

                replyService.remove(sn, snValue, userId, function(result){
                    console.log(result);

                    console.log(result.getElementsByTagName("Integer"));
                    document.getElementById("replyCnt").innerHTML = result.getElementsByTagName("Integer")[0].textContent;
                    showList(1);
                });
            }
        });



        //댓글 생성,    name : {mv.name}
        replyRegisterBtn.on("click", function(e){

            e.preventDefault();

            if(!validation()) {
                return;
            }

            //e.preventDefault();
            console.log("replyRegisterBtnClicked");
            let reply = {
                brdSn : snValue,
                userId : userId,
                content : replyComment.val(),
                status  : "RPST01"
            }

            console.log("reply : " + JSON.stringify(reply));

            replyService.add(reply, function(result){
                console.log(result.getElementsByTagName("Integer"));
                document.getElementById("replyCnt").innerHTML = result.getElementsByTagName("Integer")[0].textContent;

                alert('댓글이 달렸습니다.');
                $("textarea[id='replyComment']").val("");
                showList(1);
            })
        });
        //유효성검사-----------------------------------
        function validation(){
            //$("textarea[id='replyComment']").val().trim().length == 0
            //getByte($("textarea[id='replyComment']").val()) == ""
            if($("textarea[id='replyComment']").val().trim().length == 0) {
                alert("댓글을 입력해주세요");
                return false;

            }else if(getByte($("textarea[id='replyComment']").val()) > 1000){
                alert("댓글 내용이 너무 깁니다.");
                return false;
            }
            return true;
        }

        function getByte(str){
            let byte = 0;
            for(let i = 0; i<str.length; ++i){
                (str.charCodeAt(i) > 127) ? byte += 3 : byte++;
            }
            return byte;
        }
        //-------------------------------------------------

        showList(1);
        // test
        function showList(page) {
            replyService.getList({brdSn: snValue, page: page || 1,}, function(list) {
                console.log(list);
                let str = "";
                if (list == null || list.length == 0) {
                    replyUL.html("");
                    return;
                }
                for (let i = 0, len = list.length || 0; i < len; i++) {

                    str += "<li id='sn' class='left clearfix' data-sn='"+list[i].sn+"'>"
                    str += "<div><div class='header2'><strong id='userName' class='primary-" +
                        "font'>"+list[i].name+"</strong>";
                    str += "<small id='replyDate' class='pull-right text-muted'>"+replyService.displayTime(list[i].regDate)+"</small>";
                    <sec:authorize access="isAuthenticated()">

                        let pUsername = "${pinfo.username}";
                        // 내가 쓴 글이면 수정 삭제
                        if(pUsername == list[i].userId){
                            console.log("equal");
                            console.log("${pinfo.username}");
                            console.log(list[i].userId);
                            str += "<button id='replyDeleteBtn' class='replyDelete' data-sn='"+list[i].sn+"'>삭제</button>";
                            str += "<button id='replyModifyBtn' class='replyModify' data-sn='"+list[i].sn+"'>수정</button></div>";
                        // 내가 쓴 글이 아니면 신고 버튼
                        }else{
                            console.log("ne");
                            console.log("${pinfo.username}");
                            console.log(list[i].userId);
                            str += "<button id='boardUserRepot' class='boardUserRepot' data-sn='"+list[i].sn+"'>신고</button>"
                        }

                    </sec:authorize>
                    str += "<p id='replyContent'>"+list[i].content+"</p>";
                    str += "<button class='replySubmit'>답글 쓰기</button></div></li><hr>"

                }//end function(list)
                replyUL.html(str);
            });
        } // end showlist


        // 하트 초기화
        getBoardLike();

        function getBoardLike(){
            console.log("getBoardLike 호출..........")
            boardLikeService.getLike({brdSn : snValue, userId : userId},function(result){

               console.log("brdSn : " + snValue);
               console.log("userId : " + userId);
               console.log("likeResult : "+ result);

               // $("#likeCnt").val();
               if(result === "notExist"){
                   //빈하트 r
                   console.log("empty heart");
                   $("#likeCnt1").removeClass('fas');
                   $("#likeCnt1").addClass('far');

               }else{
                   //채워진 하트 s
                   console.log("full heart");
                   $("#likeCnt1").removeClass('far');
                   $("#likeCnt1").addClass('fas');

               }
               //like.html(str);

            });

        }

        function updateLikeCnt(BoardLikeCnt){
            console.log(BoardLikeCnt.getElementsByTagName("Integer")[0].textContent);
            //좋아요 개수 동적으로 변경
            document.getElementById("likeCnt").innerHTML = BoardLikeCnt.getElementsByTagName("Integer")[0].textContent;
        }


        //좋아요 클릭 시
        $("#likeCnt1").on("click",function (e) {

            let isLogin = "";
            <sec:authorize access="isAuthenticated()">
                isLogin = '<sec:authentication property="principal.username"/>'
            </sec:authorize>

            //로그인이 안되어있으면
            if(!isLogin){
                alert("로그인 해주세요");
                return;
            }

            let boardLike = {
                brdSn : snValue,
                userId : userId,
            };

            console.log("boardLike : "+JSON.stringify(boardLike));

            boardLikeService.add(boardLike, function(result){
               console.log("result : " + result);

               // 하트 채워짐 여부
               getBoardLike();
               // 좋아요 갯수 보여주기
               updateLikeCnt(result);
            });

        });//end LikeCnt

        $(".chat").on("click", "button[id='boardUserRepot']", function(e){
            alert('구현 중 입니다 조금 많이 기다려주세요~♡')
        });


    });// end ready


</script>



<%@include file="../includes/footer.jsp" %>
