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
            <h1 class="page-header"> 게시판</h1>
            <hr/>

            <div id="inline3">
                <div class="inline" id="img"><img class="profile" src="../../../resources/img/img_avatar2.png" alt="error"></div>
                <div class="inline" id="name"><c:out value="${board.name}" /></div>
                <div class="inline" id="role">모임장</div>
            </div>


            <div id="inline2">
                <!--principal.MemberVo > mv.name 접근해서 이름 가져온다. 위에 참고-->
                <c:if test="${mv.name eq board.name}">
                    <button data-oper='modify' class="btn btn-primary">수정</button>
                </c:if>

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
                <textarea class="form-control" rows="5"
                          id="content" name="content" readonly="readonly"><c:out value="${board.content}"/></textarea>
            </div>

<%--            <div class="form-group">--%>
<%--                <label>사진</label>--%>
<%--            </div>--%>
            <!--class = form-group -> uploadResult -->
            <div class="form-group">
                <label>첨부파일</label>
                <div class="uploadResult">
                    <ul>

                    </ul>
                </div>
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


                        <!-- 댓글 시작 -->
                        <li class="left clearfix" data-sn="12">
                            <div>
                                <div class="header2">
                                    <strong class="primary-font"></strong>
                                    <small class="pull-right text-muted"></small>
                                    <!--내 글이면 수정 삭제 / 다른 사람 글이면 ...표시 -> 신고하기-->
                                    <button id='replyDeleteBtn' type="button" class="replyDelete"></button>
                                    <button id='replyModifyBtn'type="button" class="replyModify"></button>
                                </div>
                                <p></p>
                                <button class="replySubmit" type="submit"></button>
                            </div>
                        </li> <!--end li -->
                    </ul>

                </div> <!--end panel-body-->
<%--            </div> <!--end reply box-->--%>

        <!--댓글 입력 창(로그인 안하면 댓글 창 안보이게 함.)-->
        <c:if test="${mv.name eq board.name}">
            <div class="commentWriter">
                <div class="comment_inbox">
            <textarea id='replyComment' placeholder="댓글을 입력해주세요" rows="1"
                      class="comment_inbox_text" style="overflow: hidden; overflow-wrap: break-word; height: 18px"
                      required></textarea>
                </div>
                <div class="register_box">
                    <button id='replyRegisterBtn' role="button" class="button btn_register is_active">등록</button>
                </div>
            </div>
            <!--end 댓글 입력 창-->
        </c:if>
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
        //취소 -> 그룹 리스트
        <%--$("button[data-oper='list']").on("click",function(){--%>
        <%--    operForm.attr("action","/group/get");--%>
        <%--    operForm.find("input[name='sn']").remove();--%>
        <%--    operForm.append("<input type='hidden' name = 'sn' value='" + ${board.grpSn} + "'>");--%>
        <%--    operForm.submit();--%>
        <%--})--%>
        //
        // http://localhost/group/get?sn=720
        $("button[data-oper='list']").on("click",function(){
            console.log("return list");
            $(location).attr('href', '/group/get?sn=' + '${board.grpSn}');
        });

        // $("button[data-oper='list']").on("click",function(){
        //     window.history.back();
        //
        // })


        // <!--유효성 검사-->
        $('button[id="replyRegisterBtn"]').on("click", function(e) {
            e.preventDefault();

            if(!validation()) {
                return;
            }

        })


        function validation(){

            if(getByte($("textarea[id='replyComment']").val()) == "") {
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




    });



    //*좋아요 기능 구현*
    //아이디가 likeCnt인 하트를 가져온다.
    <%--let likeBundle = document.getElementById("likeBundle")--%>
    <%--let like1 = document.getElementById("likeCnt1");--%>
    <%--let like2 = document.getElementById("likeCnt2");--%>
    <%--//좋아요 클릭시 좋아요 함수 호출--%>
    <%--likeBundle.onclick = function(){--%>
    <%--    let sendData = {"userId" : "${board.userId}", "sn":"${board.sn}"};--%>
    <%--    console.log(sendData);--%>
    <%--    clickLike(sendData);--%>
    <%--}--%>
    <%--//기능 구현--%>
    <%--function clickLike(sendData){--%>
    <%--    $.ajax({--%>
    <%--        type: "post",--%>
    <%--        url: "/clickLike",--%>
    <%--        data : sendData,--%>
    <%--        success : function(data){--%>
    <%--            if(data == 1){--%>

    <%--            }else{--%>

    <%--            }--%>
    <%--        }--%>
    <%--    })--%>
    <%--}--%>

</script>

<script>

    $(document).ready(function(){

        console.log(".......................")
        console.log("JS TEST")



        let snValue = '<c:out value="${board.sn}"/> ';
        let replyUL = $(".chat");

        //boseung@naver.com
        //let userId = 'qwer6786@naver.com'; //일단 이렇게 해야함..
        <%--let name = '<c:out value="${board.name}"/> ';--%>
        //let realname = '{mv.name}'
        // console.log("snValue : "+snValue+" userId : " + userId + " userName: " + name);

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

            $(arr).each(function(i, attach) {
            if(attach.fileType){
                let fileCallPath = encodeURIComponent(attach.uploadPath+"/s_"+attach.uuid+"_"+attach.fileName);
                str += "<div data-path='"+attach.uploadPath+"'";
                str += "data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"'data-type='"+attach.fileType+"'";
                str += "><div>";
                str += "<img src='/display?fileName="+fileCallPath+"' style='width:400px; height:200px;'>";
                str += "</div>";
                str += "</div>";
            } else {
                //return;
                str += "<li data-path='"+attach.uploadPath+"'";
                str += "data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"'data-type='"+attach.fileType+"'";
                str += "><div>";
                str += "<span> "+attach.fileName+"</span>";
                str += "<img src='/resources/img/attach.png' style='width:400px; height:200px;'>";
                str += "</div>";
                str += "</li>";

            }

                // if(attach.fileType) {
                //     let fileCallPath = encodeURIComponent(attach.uploadPath+"/"+attach.uuid+"_"+attach.fileName);
                //     str = "<img id='attach' src='/display?fileName="+fileCallPath+"' style='width:200px; height:100px;'>";
                // } else {
                //
                //     str = "<img id='attach' src='/resources/img/attach.png' style='width:200px; height:100px;'>";
                // }

            })

            $(".uploadResult").html(str);


        }).fail(function() {
            $(".uploadResult").html("<img src=/resources/img/group.jpg style='width:400px; height:200px;'>");
        });

        // end getJSON


        //userid = 이메일,  id = 이름
        //댓글 등록할 때 insert는 userid로 get은 id로
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
            console.log("replySn : " + sn);

            if(confirm('댓글을 삭제하시겠습니까?')){

                replyService.remove(sn, snValue, function(result){
                    console.log(result);

                    console.log(result.getElementsByTagName("Integer"));
                    document.getElementById("replyCnt").innerHTML = result.getElementsByTagName("Integer")[0].textContent;
                    showList(1);
                });
            }
        });


        //댓글 생성,    name : {mv.name}
        replyRegisterBtn.on("click", function(e){
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
                $("textarea[id='replyComment']").val('');
                showList(1);
            })
        });



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
                    // str += "<img class='profile' src='../../../resources/image/img_avatar2.png' data-sn='"+list[i].picture+"'>"
                    // str += "<ul class='chat'><li id='sn' class='left clearfix' data-sn='"+list[i].sn+"'>"
                    // str += "<div><div class='header2'><strong id='userName' class='primary-" +
                    //     "font'>"+list[i].name+"</strong>";
                    // str += "<small id='replyDate' class='pull-right text-muted'>"+replyService.displayTime(list[i].regDate)+"</small>";
                    // str += "<button id='replyDeleteBtn' class='replyDelete'>삭제</button>";
                    // str += "<button id='replyModifyBtn' class='replyModify'>수정</button></div>";
                    // str += "<p id='replyContent'>"+list[i].content+"</p>";
                    // str += "<button class='replySubmit'>답글 쓰기</button></div></li></ul>"
                    str += "<li id='sn' class='left clearfix' data-sn='"+list[i].sn+"'>"
                    str += "<div><div class='header2'><strong id='userName' class='primary-" +
                        "font'>"+list[i].name+"</strong>";
                    str += "<small id='replyDate' class='pull-right text-muted'>"+replyService.displayTime(list[i].regDate)+"</small>";
                    str += "<button id='replyDeleteBtn' class='replyDelete' data-sn='"+list[i].sn+"'>삭제</button>";
                    str += "<button id='replyModifyBtn' class='replyModify' data-sn='"+list[i].sn+"'>수정</button></div>";
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

        <%--let test = '${isLike}';--%>
        <%--// console.log(test === 'true');--%>
        <%--// ajax로 사용자가 눌렀는지 확인한다--%>
        <%--let check = test === 'false';//false;--%>
        <%--// console.log()--%>
        <%--// 그값으로 트루폴즈를 판단해서 하트를 세팅한다--%>
        <%--if (check) {--%>
        <%--    $("#likeCnt1").addClass('fas fa-heart'); // 채워진 하트--%>
        <%--}else{--%>
        <%--    $("#likeCnt1").addClass('far fa-heart'); // 빈 하트--%>
        <%--}--%>


        //좋아요 클릭 시
        $("#likeCnt1").on("click",function (e) {
            //e.preventDefault();
            //change(this);

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

            // boardLikeService.remove(boardLike, function(){
            //
            // });

            // function change(obj){
            //     check = !check;
            //     if (check) {
            //         $(obj).removeClass('far fa-heart'); //빈 하트
            //         $(obj).addClass('fas fa-heart');
            //     }else{
            //         $(obj).removeClass('fas fa-heart');
            //         $(obj).addClass('far fa-heart');
            //     }
            // }

        });//end LikeCnt



    });// end ready

    // //댓글 생성
    // replyService.add(
    //     {brdSn:snValue, userId:"toywar1@naver.com",content:"댓글 테스트2", status:"RPST01"}
    //     , function(result){
    //
    //         alert("댓글이 달렸습니다");
    //     }
    // )
    // //댓글 조회
    // replyService.getList({brdSn:snValue, page:1}, function(list){
    //
    //     for(let i = 0, len = list.length||0; i < len; i++){
    //         console.log(list[i]);
    //     }
    // });
    // //댓글 삭제
    // replyService.remove(43, function(count) {
    //     console.log(count);
    //
    //     if(count === "success") {
    //         alert("REMOVE");
    //     }
    // }, function(err) {
    //     alert("Errer!!")
    // });
    // //댓글 수정
    // replyService.update({
    //     sn : 66,
    //     brdSn : snValue,
    //     content : "댓글 테스트>>>>",
    //     status : "RPST01"
    // },function(result){
    //     alert('수정');
    // });
    //
    // //특정 댓글 조회
    // replyService.get(65, function(data){
    //     console.log(data);
    // });

</script>



<%@include file="../includes/footer.jsp" %>
