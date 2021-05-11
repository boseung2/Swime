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
                    <select class="sort" id="sort" name="sort">
                        <option value="">--전체--</option>
                        <option value="S">번호순</option>
                        <option value="D">날짜순</option>
                        <option value="SS">상태순</option>
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
                        <th id="change">제목</th>
                        <th>작성일</th>
                        <th>수정일</th>
                        <th>상태</th>
                    </tr>
                    </thead>
                    <%--게시판 리스트--%>
                    <tr class="boardList">
<%--                        <td data-sn='12'></td>--%>
<%--                        <td></td>--%>
<%--                        <td></td>--%>
<%--                        <td></td>--%>
<%--                        <td></td>--%>
<%--                        <td></td>--%>
<%--                        <td></td>--%>

                    </tr>

                    <tr class="replyList">

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

        let boardUl = $('tbody'); //게시판 출력

        let boardCntSort; //select optoin 10 25 50개 값을 넣어서 list뽑는다.
        let amount = 10, page = 1; //페이징 default 값

        let bbsOrReplyVal;
        let bbsOrReplyVar = "board"; // select option 게시글 or 댓글 defalut값

        let sort = "S";

        //정렬 select option
        $('#sort').on('change',function(){

            $('#sort').each(function(){
                if($(this).val() === 'S'){
                    sort = "S"
                }else if($(this).val() == 'D'){
                    sort = "D";
                }else{
                    sort = "SS";
                }
            });
            console.log(sort);
            showBoardList(page, amount, bbsOrReplyVar, sort);
        });


        //게시판or댓글 select option
        $('.bbsOrReply').on('change',function(){

            bbsOrReplyVal = $('.bbsOrReply option:selected').val();

            $('.bbsOrReply').each(function(){
                if($(this).val() === 'board'){
                    bbsOrReplyVar = 'board';
                }else{
                    bbsOrReplyVar = 'reply';
                }
            });

            console.log("bbsOrReplyVal : "+bbsOrReplyVar);
            showBoardList(page,amount,bbsOrReplyVar,sort);

        })

        //10/25/50 개수 select option
        $('.boardCntList').on('change', function(){

            //let boardCntOpt = $('.boardCntList option:selected').val();
            amount = $('.boardCntList option:selected').val();

            $('.boardCntList').each(function (){

                if($(this).val() === 10){
                    boardCntSort = 10;
                }else if($(this).val() === 20){
                    boardCntSort = 25;
                }else{
                    boardCntSort = 50;
                }
            });

            console.log("boardCntSort"+amount);
            showBoardList(page, amount, bbsOrReplyVar,sort);

        });


        showBoardList(page, amount, bbsOrReplyVar, sort); //defalut값 1,10, 게시판

        function showBoardList(page, boardCntSort, bbsOrReplyVar, sort){
            console.log("showBoardListPage : " +page);
            console.log("boardCntSort : " + boardCntSort);
            console.log("bbsOrReplyVar : " + bbsOrReplyVar);
            console.log("sort : " + sort)

                adminBoardListService.adminBoardList(page, boardCntSort, bbsOrReplyVar, sort,
                    function (cnt, list, compare) {

                        let str = "";

                        console.log("-----------callback data-------------");
                        console.log("cnt"+cnt);
                        console.log("list"+list);
                        console.log("compare"+compare);
                        console.log("sort : "+sort);

                        //board or reply
                        if (compare === 'isBoard') {
                            listPrint(compare);

                        } else {
                            listPrint(compare);
                        } // end else

                        function listPrint(compare){

                            if(compare === 'isBoard'){
                                $('tr > th:eq(3)').html('제목');
                                //str = "";
                            }else{
                                $('tr > th:eq(3)').html('댓글 내용');
                                //str = "";
                            }

                            if (page == -1) {
                                adminBoardPageNum = Math.ceil(cnt / 10.0);
                                showBoardList(adminBoardPageNum);
                                return;
                            }

                            if (list == null || list.length == 0) {
                                boardUl.html("");
                                return;
                            }


                            for (let i = 0, len = list.length || 0; i < len; i++) {

                                let status = "";
                                let dat = "";
                                let statusVar = list[i].status;

                                // board or reply
                                if(compare === 'isBoard'){
                                    statusToText(statusVar);
                                }else{
                                    statusToText(statusVar);
                                }

                                //status 코드 -> 한글
                                function statusToText(statusVar){
                                    //console.log("statusVar :"+statusVar);
                                    switch (statusVar) {
                                        case "BOST01":
                                            status = "정상";
                                            break;
                                        case "BOST02":
                                            status = "삭제";
                                            break;
                                        case "BOST03":
                                            status = "신고";
                                            break;
                                        case "RPST01":
                                            status = "정상";
                                            break;
                                        case "RPST02":
                                            status = "삭제";
                                            break;
                                        case "RPST03":
                                            status = "신고";
                                            break;
                                    }

                                }

                                str += "<tr class='boardList'>";
                                // str += "<td>"+list[i].index+"</td>"
                                str += "<td data-sn='12'>" + list[i].sn + "</td>";
                                str += "<td>" + list[i].userId + "</td>";
                                str += "<td>" + list[i].name + "</td>";

                                if(compare === 'isBoard'){
                                    str += "<td>" + list[i].title.substring(0, 20) + dat + "</td>";
                                }else{
                                    str += "<td>" + list[i].content.substring(0, 20) + dat + "</td>";
                                }

                                str += "<td>" + adminBoardListService.boardDisplayTime(list[i].regDate) + "</td>";
                                str += "<td>" + adminBoardListService.boardDisplayTime(list[i].updDate) + "</td>";
                                str += "<td>" + status + "</td>";
                                str += "</tr>";

                            }//end for

                        }//end listPrint
                        boardUl.html(str);

                        console.log("board or reply Cnt" + cnt);
                        showAdminBoardPage(cnt);

                    }); // end adminBoardList

            }// end list call

                let adminBoardPageNum = 1;
                let adminBoardPageFooter = $('.adminPageFooter');

                function showAdminBoardPage(cnt){

                    console.log('boardCnt' + cnt + "개");
                    //페이지 번호 개수
                    let endNum = Math.ceil(adminBoardPageNum / 10.0) * 10;
                    let startNum = endNum - 9;

                    let prev = startNum != 1;
                    let next = false;

                    //10 25 50개 정렬
                    console.log("boardCntSortClicked : "+amount);

                    if (amount == 10){
                        pagingCount();
                    }else if(amount == 25){
                        pagingCount();
                    }else{
                        pagingCount();
                    }

                    //버그 1. 페이지 수 정렬 바꿀 때 눌렀던 페이지가 계속 유지된다.
                    //ex) 10개 정렬에서 20페이지 눌렀을 때 50개 정렬 시 20페이지에 데이터가 없어서 안나온다.
                    function pagingCount(){
                        console.log("pageFunction : "+amount);
                        console.log("endNumPagungFuntion"+endNum)
                        if (endNum * amount >= cnt) {
                            endNum = Math.ceil(cnt / amount);
                        }
                    }

                        if (endNum * 10 < cnt) {
                            next = true;
                        }
                    // if (endNum * 10 >= cnt) {
                    //     endNum = Math.ceil(cnt / 10.0);
                    // }



                    console.log("boardCount = " + cnt);
                    console.log("startNum = " + startNum);
                    console.log("endNum = " + endNum);
                    console.log("prev = " + prev);
                    console.log("next = " + next);


                    let str = "<ul class ='pagination'>";

                    if (prev) {
                        str += "<li id='board-item' class = 'page-item'><a id='board-link' class='page-link' href='" + (startNum - 1) + "'>Previous</a></li>";
                    }

                    for (let i = startNum; i <= endNum; i++) {
                        //console.log("i=" + i);
                        let active = adminBoardPageNum == i ? "active" : "";

                        str += "<li id='board-item' class = 'page-item " + active + " '><a id='board-link' class='page-link' href='" + i + "'>" + i + "</a></li>";
                    }

                    if (next) {
                        str += "<li id='board-item' class = 'page-item'><a id='board-link' class='page-link' href='" + (endNum + 1) + "'>Next</a></li>";
                    }

                    str += "</ul></div>";

                    //console.log("brdStr : " + str);

                    adminBoardPageFooter.html(str);

                }

                adminBoardPageFooter.on("click", "li[id='board-item'] a[id='board-link']", function (e) {

                    e.preventDefault();

                    console.log("board page click");

                    let targetPageNum = $(this).attr("href");

                    console.log("targetPageNum: " + targetPageNum);

                    adminBoardPageNum = targetPageNum;

                    page = targetPageNum;

                    showBoardList(page,amount, bbsOrReplyVar, sort);


                });

            //} //end listCall

    });// end ready

</script>