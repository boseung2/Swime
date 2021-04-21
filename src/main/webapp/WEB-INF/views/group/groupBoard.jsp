<%--
  Created by IntelliJ IDEA.
  User: toywa
  Date: 2021-04-22
  Time: 오전 12:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../includes/tagLib.jsp" %>

<!-- 게시판  -->
<hr class="centerHr" id="board">
<div id="board">

    <h4>게시판
        <button id="regBtn" type="button" class="btn btn-xs pull-right btn btn-primary"
                style="float: right; margin-bottom: 5px">
            글쓰기
        </button>
    </h4>


    <div class="boardHeader">
        <span>1번</span>
        <span id="boardNotice">[필독]</span>
        <br>

        <div id="boardDivBox">
            <span><img class="avatar" src="../../../resources/img/img_avatar2.png" alt="error"></span>
            <span id="boardName">이민재</span>
            <%--                <span id="grpBrdRole">(모임장)</span>--%>
            <span id="boardRegDate">2021-10-10</span>
        </div>

        <span>스프링</span>

        <div id="boardContent">스프링 초고수만</div>

        <i class='fas fa-comment'>100</i>
        <i class='fas fa-heart'>100</i>
    </div>

</div><!--end board-->

<!--게시판 페이징 처리 -->
<div class="boardPageFooter panel-footer">

</div>

<!-- BoardList Module-->
<script type="text/javascript" src="/resources/js/boardList.js"></script>




<script type="text/javascript">
    // 게시판
    $(document).ready(function(){

        let grpSnValue = "${group.sn}";
        let boardUL = $(".boardHeader");

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
                        return;
                    }
                    let str="";

                    if(list == null || list.length == 0){
                        return;
                    }
                    //필독 (모임장)나중에 데이터 넣어야함.
                    for(let i = 0, len = list.length || 0; i < len; i++){

                        str += "<div class='boardHeader'>";
                        str += "<span>"+list[i].sn+"번"+"</span>";
                        str += "<span id='boardNotice'>"+"[필독]"+"</span>";
                        str += "<br>";
                        str += "<div id='boardDivBox'>";
                        str += "<span><img class='avatar' src='../../../resources/img/img_avatar2.png' alt='error'></span>";
                        str += "<span id='boardName'>"+list[i].name+"</span>";
                        // str += "<span id='grpBrdRole'>"+list[i].grpRole+"</span>";
                        str += "<span id='boardRegDate'>"+list[i].regDate+"</span>";
                        str += "</div>";
                        str += "<a href='/board/get?sn="+list[i].sn+ "' class='boardMove'><span>"+list[i].title+"</span></a>";
                        str += "<div id='boardContent'>"+list[i].content+"</div>";
                        str += "<i class='fas fa-comment'>"+list[i].replyCnt+"</i>";
                        str += "<i class='fas fa-heart'>"+list[i].likeCnt+"</i>";
                        str += "</div><hr>";
                        console.log("dddddddddddddddd"+list[i].content);
                    }
                    boardUL.html(str);

                    showBoardPage(boardCnt);
                });

        }//end showList


        let boardPageNum = 1;
        let boardPageFooter = $('.boardPageFooter');
        <!--게시글 페이지-->
        function showBoardPage(boardCnt) {

            console.log('boardCnt'+boardCnt+"개");
            let endNum = Math.ceil(boardPageNum / 10.0) * 10;
            let startNum = endNum - 9;

            let prev = startNum != 1;
            let next = false;

            if (endNum * 10 >= boardCnt) {
                endNum = Math.ceil(boardCnt / 10.0);
            }

            if(endNum * 10 < boardCnt) {
                next = true;
            }

            console.log("boardCount = " + boardCnt);
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
                let active = boardPageNum == i ? "active" : "";

                str += "<li class = 'page-item " + active +" '><a class='page-link' href='" + i + "'>" + i + "</a></li>";
            }

            if(next) {
                str += "<li class = 'page-item'><a class='page-link' href='" + (endNum + 1) + "'>Next</a></li>";
            }

            str += "</ul></div>";

            console.log("brdStr : "+str);

            boardPageFooter.html(str);


        }
        boardPageFooter.on("click", "li a", function(e) {
            e.preventDefault();

            console.log("board page click");

            let targetPageNum = $(this).attr("href");

            console.log("targetPageNum: " + targetPageNum);

            boardPageNum = targetPageNum;

            showBoardList(boardPageNum);

        })


    });


</script>

<script>
    $(document).ready(function() {
        $("#regBtn").on("click", function(){

            self.location = "/board/register?grpSn=${group.sn}";
        });

    });
</script>
