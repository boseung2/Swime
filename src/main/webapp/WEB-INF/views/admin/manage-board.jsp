<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/tagLib.jsp" %>

<div class="container-fluid">
    <!-- <h2 class="mt-4">게시물관리</h2> -->
    <ol class="breadcrumb mb-4">
        <!-- <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li> -->
        <li class="breadcrumb-item active">manage-board</li>
    </ol>
    <div class="card mb-4">
        <div class="card-header">
        </div>
        <div class="card-body">

            <div class="option-search">
                <div>
                    <select class="boardCntList" id="boardCntList" name="boardCntList">
                        <option value="">--개수--</option>
                        <option value="10">10</option>
                        <option value="25">25</option>
                        <option value="50">50</option>
                    </select>
                </div>
                <div style="display: flex; margin-left: auto;">
                    <select class="bbsOrReply" id="bbsOrReply" name="bbsOrReply">
                        <option value="">--전체--</option>
                        <option value="board">게시물</option>
                        <option value="reply">댓글</option>
                    </select>
                    <select>
                        <option value="">--전체--</option>
                        <option value="snSort">번호순</option>
                        <option value="dateSort">날짜순</option>
                        <option value="statusSort">상태순</option>
                    </select>

                    <div class="search-bar">
                        <input type="text" placeholder="Search.." >
                        <button class="search-button"><i class="fas fa-search"></i></button>
                    </div>
                </div>
            </div> <!--option search-->

            <div class="table-responsive">
                <table class="table table-bordered" cellspacing="0">
                    <thead>
                    <tr class="boardHeader">
                        <th>#</th>
                        <th>email</th>
                        <th>이름</th>
                        <th>제목</th>
                        <th>작성일</th>
                        <th>수정일</th>
                        <th>상태</th>
                    </tr>
                    </thead>

                    <tr class="boardList">
                        <td data-sn='12'></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>

                </table>
            </div>

            <div style="display: flex; justify-content: space-between;">

                <div>
                    <button class="footer-button">수정</button>
                    <button class="footer-button2">삭제</button>
                </div>
                <!--admin 게시판 페이징 처리-->
                <div class="adminPageFooter panel-footer">

                </div>

            </div>

        </div><!--end card body-->
    </div><!--end card md-->
</div><!--end container-->

<!-- BoardList Module-->
<script type="text/javascript" src="/resources/js/adminBoardList.js"></script>

<script type="text/javascript">

    $('document').ready(function(){
        //5/8일 댓글 리스트 출력하기.............................
        let boardUl = $('tbody'); //게시판 출력

        let boardCntSort; //select optoin 10 25 50개 값을 넣어서 list뽑는다.
        let amount = 10, page = 1; //페이징 default 값

        let bbsOrReplyVal;
        let bbsOrReplyVar = "board"; // select option 게시글 or 댓글 defalut값

        //게시판or댓글 select option
        $('.bbsOrReply').on('change',function(){
            bbsOrReplyVal = $('.bbsOrReply option:selected').val();

            if(bbsOrReplyVal == 'board') {
                bbsOrReplyVar = 'board';
            }else{
                bbsOrReplyVar = 'reply';
            }
            console.log("bbsOrReplyVal : "+bbsOrReplyVar);
            showBoardList(page,amount,bbsOrReplyVar);
        })

        //10/25/50 개수 select option
        $('.boardCntList').on('change', function(){

            //let boardCntOpt = $('.boardCntList option:selected').val();
            amount = $('.boardCntList option:selected').val();

            if(amount == 10){
                boardCntSort = 10;
            }else if(amount == 25){
                boardCntSort = 25;
            }else if(amount == 50){
                boardCntSort = 50;
            }
            console.log("boardCntSort"+amount);
            showBoardList(page, amount, bbsOrReplyVar);
        });


        showBoardList(page, amount, bbsOrReplyVar) //defalut값 1,10

        function showBoardList(page, boardCntSort, bbsOrReplyVar){
            console.log("showBoardListPage : " +page);
            console.log("boardCntSort : " + boardCntSort);
            console.log("bbsOrReplyVar : " + bbsOrReplyVar);


            adminBoardListService.adminBoardList(page, boardCntSort,
                bbsOrReplyVar, function(boardCnt, list, replyCnt, replyList){

                let str = "";

                if(page == -1){
                    adminBoardPageNum = Math.ceil(boardCnt/10.0);
                    showBoardList(adminBoardPageNum);
                    return;
                }

                if(list == null || list.length == 0){
                    boardUl.html("");
                    return;
                }

                for(let i = 0, len = list.length||0; i < len; i++){

                    console.log(list[i]);
                    let status = "";
                    let dat = "";

                    if(list[i].status == "BOST01"){
                        status = "정상"
                    }else if(list[i].status == "BOST02"){
                        status = "삭제";
                    }else {
                        status = "신고";
                    }
                    //제목이 20 글자가 넘으면 ...
                    if(list[i].title.length >= 20){
                        dat = "...";
                    }

                    str += "<tr class='boardList'>";
                    //str += "<td>"+bno+"</td>"
                    str += "<td data-sn='12'>"+list[i].sn+"</td>";
                    str += "<td>"+list[i].userId+"</td>";
                    str += "<td>"+list[i].name+"</td>";
                    str += "<td>"+list[i].title.substring(0,20)+dat+"</td>";
                    str += "<td>"+adminBoardListService.boardDisplayTime(list[i].regDate)+"</td>";
                    str += "<td>"+adminBoardListService.boardDisplayTime(list[i].updDate)+"</td>";
                    str += "<td>"+status+"</td>";
                    str += "</tr>";

                }
                boardUl.html(str);
                //call
                showAdminBoardPage(boardCnt);

            });// end adminBoardList

        } // end showBoardList


        let adminBoardPageNum = 1;
        let adminBoardPageFooter = $('.adminPageFooter');
        <!--게시글 페이지-->
        function showAdminBoardPage(boardCnt){

            console.log('boardCnt' + boardCnt + "개");
            let endNum = Math.ceil(adminBoardPageNum / 10.0) * 10;
            let startNum = endNum - 9;

            let prev = startNum != 1;
            let next = false;

            if (endNum * 10 >= boardCnt) {
                endNum = Math.ceil(boardCnt / 10.0);
            }

            if (endNum * 10 < boardCnt) {
                next = true;
            }

            console.log("boardCount = " + boardCnt);
            console.log("startNum = " + startNum);
            console.log("endNum = " + endNum);
            console.log("prev = " + prev);
            console.log("next = " + next);


            let str = "<ul class ='pagination'>";

            if (prev) {
                str += "<li id='board-item' class = 'page-item'><a id='board-link' class='page-link' href='" + (startNum - 1) + "'>Previous</a></li>";
            }

            for (let i = startNum; i <= endNum; i++) {
                console.log("i=" + i);
                let active = adminBoardPageNum == i ? "active" : "";

                str += "<li id='board-item' class = 'page-item " + active + " '><a id='board-link' class='page-link' href='" + i + "'>" + i + "</a></li>";
            }

            if (next) {
                str += "<li id='board-item' class = 'page-item'><a id='board-link' class='page-link' href='" + (endNum + 1) + "'>Next</a></li>";
            }

            str += "</ul></div>";

            console.log("brdStr : " + str);

            adminBoardPageFooter.html(str);

        }

        adminBoardPageFooter.on("click", "li[id='board-item'] a[id='board-link']", function (e) {

            e.preventDefault();

            console.log("board page click");

            let targetPageNum = $(this).attr("href");

            console.log("targetPageNum: " + targetPageNum);

            adminBoardPageNum = targetPageNum;

            page = targetPageNum;

            showBoardList(page,amount, bbsOrReplyVar);


        });

    });// end ready

</script>