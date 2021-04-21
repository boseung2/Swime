<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>


<%@include file="../includes/header.jsp" %>
<link rel="stylesheet" href="/resources/css/board-get.css">
<%@include file="../includes/pictogramLib.jsp" %>

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
                <button data-oper='modify' class="btn btn-primary"
                onclick="location.href='/board/modify?sn=<c:out value="${board.sn}"/>'">수정</button>
                <button data-oper="list" class="btn btn-dark"
                onclick="location.href='board/list'">취소</button>

<%--                <a id="back" class="btn btn-dark">취소</a>--%>

<%--                <button data-oper="modify" class=""--%>


<%--                <form id="modifyForm" role="form" action="/board/remove" method="post">--%>
<%--                    <button type="submit" data-oper='remove' class="btn btn-danger">삭제</button>--%>
<%--                    <sec:csrfInput/>--%>
<%--                </form>--%>
<%--                                    <button data-oper='remove' class="btn btn-default">삭제</button>--%>
            </div>
            <form id="operForm" action="/board/modify" method="get">
                <input type="hidden" id="sn" name="sn" value="<c:out value="${board.sn}"/>">
                <input type="hidden" id="pageNum" name="pageNum" value="<c:out value="${cri.pageNum}"/>">
                <input type="hidden" id="amount" name="amount" value="<c:out value="${cri.amount}"/>">
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

            <div class="form-group">
                <label>사진</label>
            </div>

            <div class="form-group">
                <label>첨부파일</label>
            </div>

            <div class="form-group" style="display: inline-block">
                <label>댓글</label>
                <label><c:out value="${board.replyCnt}"/> </label>
            </div>

            <div id="likeBundle" class="form-group" style="display: inline-block">
                <i id="likeCnt1" class="far fa-heart" style='font-size:20px;color:red'></i>
            </div>

                <label>좋아요</label>
<%--                <label><c:out value="${board.likeCnt}"/> </label>--%>
<%--                <label>${count}</label>--%>
                <label><c:out value="${board.likeCnt}"/> </label>

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
                                    <strong class="primary-font">user</strong>
                                    <small class="pull-right text-muted">2018-01-01 13:13</small>
                                    <!--내 글이면 수정 삭제 / 다른 사람 글이면 ...표시 -> 신고하기-->
                                    <button id='replyDeleteBtn' type="button" class="replyDelete">삭제</button>
                                    <button id='replyModifyBtn'type="button" class="replyModify">수정</button>
                                </div>
                                <p>good job</p>
                                <button class="replySubmit" type="submit">답글쓰기</button>
                            </div>
                        </li> <!--end li -->
                    </ul>
                </div> <!--end panel-body-->
<%--            </div> <!--end reply box-->--%>


            <!--댓글 입력 창-->
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
                        <label>내용</label>
                        <input class="form-control" name="content" value="내용">
                    </div>

                    <div class="form-group">
                        <label>작성자</label>
                        <input class="form-control" name="name" value="작성자">
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

<script type="text/javascript" src="/resources/js/boardReply.js"></script>



<script>

    $(document).ready(function(){

        let operForm = $("#operForm");

        $("button[data-oper='modify']").on("click",function(){
            operForm.attr("action", "/board/modify").submit();

        })

        $("button[data-oper='list']").on("click",function(){
            operForm.find("#sn").remove();
            operForm.attr("action","/board/list")
            operForm.submit();

        })

        $("#back").on("click", function(){
            window.history.back();
        });


    });

    <!--유효성 검사-->
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
    }

    function getByte(str){
        let byte = 0;
        for(let i = 0; i<str.length; ++i){
            (str.charCodeAt(i) > 127) ? byte += 3 : byte++;
        }
        return byte;
    }


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
        let userId = 'qwer6786@naver.com'; //일단 이렇게 해야함..
        let name = '<c:out value="${board.name}"/> ';

        console.log("snValue : "+snValue+" userId : " + userId + " userName: " + name);

        let replyComment = $('#replyComment'); //댓글 내용
        let replyRegisterBtn = $('#replyRegisterBtn'); //댓글 버튼

        //modalData
        let modal = $(".modal")
        let modalInputContent = modal.find("input[name=content]");
        let modalInputName = modal.find("input[name=name]");
        let modalInputRegDate = modal.find("input[name=regDate]");

        let modalModBtn = $('#modalModBtn');
        let modalCloseBtn = $('#modalCloseBtn');


        //{brdSn:snValue, userId:"toywar1@naver.com",content:"댓글 테스트2", status:"RPST01"}

        //댓글 수정
        $(".chat").on("click", "button[id='replyModifyBtn']", function(){
            console.log("modifyClicked");

            $(".modal").modal("show");

            modal.find("input").val("");
            modalInputRegDate.closest("div").hide();

            let sn = $(this).data("sn");

            replyService.get(sn, function(reply){

                modalInputContent.val("ggg");
            });

        });

        //댓글 삭제
        $(".chat").on("click", "button[id='replyDeleteBtn']", function(e){
            console.log("RemoveClicked");

            let sn = $(this).data("sn")
            console.log("replySn : " + sn);

            if(confirm('댓글을 삭제하시겠습니까?')){

                replyService.remove(sn, function(result){
                    console.log(result);
                    showList(1);
                });
            }
        });


        //댓글 생성
        replyRegisterBtn.on("click", function(e){
            console.log("replyRegisterBtnClicked");
            let reply = {
                brdSn : snValue,
                userId : userId,
                content : replyComment.val(),
                status  : "RPST01"
            }

            console.log("reply : " + JSON.stringify(reply));

            replyService.add(reply, function(){
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
                    str += "<button id='replyModifyBtn' class='replyModify'>수정</button></div>";
                    str += "<p id='replyContent'>"+list[i].content+"</p>";
                    str += "<button class='replySubmit'>답글 쓰기</button></div></li><hr>"

                }//end function(list)
                replyUL.html(str);
            });
        } // end showlist


    });

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

<script>

    $(document).ready(function() {
        let test = '${isLike}';
        // console.log(test === 'true');
        // ajax로 사용자가 눌렀는지 확인한다
        let check = test === 'false';//false;
        // console.log()
        // 그값으로 트루폴즈를 판단해서 하트를 세팅한다
        if (check) {
            $("#likeCnt1").addClass('fas fa-heart'); // 채워진 하트
        }else{
            $("#likeCnt1").addClass('far fa-heart'); // 빈 하트
        }

        let sendData = {"userId" : "${board.userId}", "sn":"${board.sn}"};
        //누를때마다 하트가 변하고
        $("#likeCnt1").click(function (){
            change(this);
            // console.log("heart click");
            $.ajax({
                type:'POST',
                url: "/board/clickLike",
                data: sendData,
                success : function(result, status, xhr){
                    if(callback){
                        callback(result)
                    }
                },
                error : function(xhr, status, er){
                    if(error){
                        error(er);
                    }
                }

        });

        //db에 반영

        function change(obj){
            check = !check;
            if (check) {
                $(obj).removeClass('far fa-heart'); //빈 하트
                $(obj).addClass('fas fa-heart');
            }else{
                $(obj).removeClass('fas fa-heart');
                $(obj).addClass('far fa-heart');
            }
        }

        });
    });

</script>


<%@include file="../includes/footer.jsp" %>