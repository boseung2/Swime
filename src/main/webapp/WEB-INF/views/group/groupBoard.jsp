<%--
  Created by IntelliJ IDEA.
  User: toywa
  Date: 2021-04-22
  Time: 오전 12:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!--regBtn-->
<%--<h4>게시판--%>
<%--    <c:set var="done" value="false"/>--%>
<%--    <!--글을 쓰려면 로그인 되어있고모임에 가입해야-->--%>
<%--    <sec:authorize access="isAuthenticated()">--%>
<%--    <c:forEach var = "attendant" items="${attendList}">--%>
<%--        <c:if test="${not done}">--%>
<%--            <c:if test="${attendant.userId == pinfo.username}">--%>
<%--                <button id="boardBtn" type="button" class="btn btn-xs pull-right btn btn-primary"--%>
<%--                        style="float: right; margin-bottom: 5px">--%>
<%--                    글쓰기--%>
<%--                </button>--%>
<%--            <c:set var="done" value="true"/>--%>
<%--            </c:if>--%>
<%--        </c:if>--%>
<%--    </c:forEach>--%>
<%--    </sec:authorize>--%>
<%--</h4>--%>

<h4>게시판
    <sec:authorize access="isAuthenticated()">
        <button id="boardBtn" type="button" class="btn btn-xs pull-right btn btn-primary"
        style="float: right; margin-bottom: 5px">글쓰기</button>
    </sec:authorize>
</h4>



    <div class="board-body"></div>
<!--end board-->

<!--게시판 페이징 처리 -->
<div class="boardPageFooter panel-footer"></div>

<!-- 게시판Modal -->
<div class="modal fade" id="boardModal" tabindex="-1" role="dialog"
     aria-labelledby="boardModal" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="boardModalLabel">게시글</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="boardModal modal-body">정상적으로 처리되었습니다.</div>
            <div class = "modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
            </div>
        </div>
    </div>
</div>

<!-- BoardList Module-->
<script type="text/javascript" src="/resources/js/boardList.js"></script>

<script type="text/javascript">

    // 게시판
    $(document).ready(function(){

        let grpSnValue = "${group.sn}";
        let boardUL = $(".board-body");

        showBoardList(1);

        function showBoardList(page){
            console.log("boardPage: " + page);
            boardListService.getList({grpSn:grpSnValue, page: page||1},
                function(boardCnt, list){

                    console.log("boardCnt :" + boardCnt);
                    console.log("list :" + list);
                    console.log(list);

                    if(page == -1){
                        boardPageNum = Math.ceil(boardCnt/10.0);
                        showBoardList(boardPageNum);
                        // boardPageNum = 1;
                        // showBoardList(boardPageNum);
                        return;
                    }
                    let str="";

                    if(list == null || list.length == 0){
                        //boardUL.html("");
                        return;
                    }

                    //게시판 리스트 뽑는 곳
                    for(let i = 0, len = list.length || 0; i < len; i++){

                        let dat = "";
                        let notice = "";
                        let role = "";
                        let userPicture = list[i].picture;
                        console.log("userPicture");
                        console.log(userPicture);
                        //제목 글자가40이상이면 ...찍는다. 글자가 너무 길면 칸을 초과함
                        if(list[i].title.length >= 40 || list[i].content.length >=40){
                            dat = "...";
                        }

                        //공지사항이면 '공지사항' 찍히게
                        if(list[i].topFix == "BOFI02"){
                            notice = "[공지사항]";
                        }
                        //모임role
                        if(list[i].grpRole == 'GRRO01'){
                            role = "모임장";
                        }else if(list[i].grpRole == 'GRRO02'){
                            role = "운영진";
                        }else{
                            role = '회원';
                        }

                        str += "<div class='boardHeader' onclick=location.href='/board/get?sn="+list[i].sn+"&userId=${pinfo.username}&grpSn=${group.sn}';>";
                        //str += "<span>"+list[i].sn+"번"+"</span>";
                        str += "<div id='boardNotice'>"+notice+"</div>";
                        //
                        str += "<div id='boardDivBox'>";
                        // || userPicture.length !== 0
                        if (userPicture !== null && list[i].picture !== 'myPicture.jpeg'){
                            str += "<span><img class='avatar' src='"+ "/display?fileName=" + list[i].picture.replace('s_','')+"' alt='error'></span>";
                        }else{
                            str += "<span><img class='avatar' src='https://image.flaticon.com/icons/png/512/3237/3237472.png' alt='error'></span>";
                        }

                        str += "<span id='boardName'>"+list[i].name+"</span>";
                        str += "<span style='color:gray'> "+role+"</span>";
                        str += "<span id='boardRegDate'>"+boardListService.boardDisplayTime(list[i].regDate)+"</span>";
                        str += "</div>";


                        str += "<div id='boardContent'>";
                        str += "<a href='/board/get?sn="+list[i].sn+"&userId=${pinfo.username}&grpSn=${group.sn}'<p id='board-title'>"+list[i].title.substring(0,40)+dat+"</p></a>";
                        str += "<p style='color : gray;'>" + list[i].content.substring(0,40)+dat + "</p></div>";
                        str += "<i class='fas fa-comments'></i> 댓글 " + list[i].replyCnt;
                        str += " <i class='fas fa-heart'></i> 좋아요 " + list[i].likeCnt;
                        str += "</div>";
                        console.log("boardList......."+list[i].content);
                    }
                    boardUL.html(str);

                    showBoardPage(boardCnt);
                });

        }//end showList
        let boardPageNum = 1;
        let boardPageFooter = $('.boardPageFooter');
        <!--게시글 페이지-->
        function showBoardPage(boardCnt) {

            console.log('boardCnt' + boardCnt + "개");

            let endNum = Math.ceil(boardPageNum / 10.0) * 10;
            let startNum = endNum - 9;

            let prev = startNum != 1;
            let next = false;

            if (endNum * 3 >= boardCnt) {
                endNum = Math.ceil(boardCnt / 3.0);
            }

            if (endNum * 10 < boardCnt) {
                next = true;
            }

            console.log("boardCount = " + boardCnt);
            console.log("startNum = " + startNum);
            console.log("endNum = " + endNum);
            console.log("prev = " + prev);
            console.log("next = " + next);


            let str = "<ul class ='pagination pagination-sm'>";

            if (prev) {
                str += "<li id='board-item' class = 'page-item'><a id='board-link' class='page-link' href='" + (startNum - 1) + "'>Previous</a></li>";
            }

            for (let i = startNum; i <= endNum; i++) {
                console.log("i=" + i);
                let active = boardPageNum == i ? "active" : "";

                str += "<li id='board-item' class = 'page-item " + active + " '><a id='board-link' class='page-link' href='" + i + "'>" + i + "</a></li>";
            }

            if (next) {
                str += "<li id='board-item' class = 'page-item'><a id='board-link' class='page-link' href='" + (endNum + 1) + "'>Next</a></li>";
            }

            str += "</ul></div>";

            console.log("brdStr : " + str);

            boardPageFooter.html(str);

        }

        boardPageFooter.on("click", "li[id='board-item'] a[id='board-link']", function (e) {

            e.preventDefault();

            console.log("board page click");

            let targetPageNum = $(this).attr("href");

            console.log("targetPageNum: " + targetPageNum);

            boardPageNum = targetPageNum;

            showBoardList(boardPageNum);

        });



    });//end ready


</script>

<script>
    $(document).ready(function() {
        let userId = '${pinfo.username}';
        console.log("userId>>>>"+userId);


        $("#boardBtn").on("click", function(){
            self.location = "/board/register?userId="+userId+"&grpSn=${group.sn}";
        });


        let boardResult = '<c:out value="${boardResult}"/>';


        console.log("boardRemoveResult" + boardResult);

        checkModal(boardResult);
        //history.replaceState({}, null, null);

        <!--게시판 등록, 삭제 모달   ||history.state-->
        function checkModal(boardResult) {
            if(boardResult === '') {
                console.log(boardResult);

                return false;
            }

            if("removeSuccess" === boardResult) {
                $(".boardModal").html("게시글이 정상적으로 삭제되었습니다.");
            }

            if("registerSuccess" === boardResult){
                $(".boardModal").html("게시글이 정상적으로 등록되었습니다.");
            }else if("registerFail" === boardResult){
                $(".boardModal").html("게시글이 등록이 실패되었습니다.");
            }

            // if("registerFail" === boardResult){
            //     $(".boardModal").html("게시글이 등록이 실패되었습니다.");
            // }



            $("#boardModal").modal("show");
        }




    });



</script>
