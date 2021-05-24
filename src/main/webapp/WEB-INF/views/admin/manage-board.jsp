<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<link rel="stylesheet" href="../../../resources/css/adminPage.css">
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
<%--                    <span>전체선택</span>--%>
                    <select class="boardCntList" id="boardCntList" name="boardCntList">
                        <option value="10">--개수(10/25/50)--</option>
                        <option value="10">10</option>
                        <option value="25">25</option>
                        <option value="50">50</option>
                    </select>

                    <select class="bbsOrReply" id="bbsOrReply" name="bbsOrReply">
                        <option value="board">--게시물/댓글--</option>
                        <option value="board">게시물</option>
                        <option value="reply">댓글</option>
                    </select>
                </div>


                <div style="display: flex; margin-left: auto;">
                    <select class="searchKeyword" id="searchKeyword" name="searchKeyword">
                        <option value="EN">--이메일/이름--</option>
                        <option value="E">이메일</option>
                        <option value="N">이름</option>
                    </select>


                    <div class="search-bar boardSearch">
                        <input type="text" id="search" name="search" placeholder="Search.." >
                        <button class="search-button" id="searchIcon"><i class="fas fa-search"></i></button>
                    </div>

                </div>

            </div> <!--option search-->


            <div class="table-responsive">
                <table class="table table-bordered" cellspacing="0">
                    <thead>
                    <tr class="boardHeader">
                        <th>
                            <input type="checkbox" id="allCheck" name="allChk">
                        </th>
                        <th>번호</th>
                        <th>고유번호(sn)</th>
                        <th>email</th>
                        <th>이름</th>
                        <th id="change">제목</th>

                        <th>작성일
                            <select class="sort" id="sort" name="sort">
                                <option value="D">--전체--</option>
                                <option value="D">최신등록순</option>
                                <option value="S">오래된등록순</option>
<%--                                <option value="SS">상태순</option>--%>
                            </select>
                        </th>

                        <th>수정일</th>

                        <th>상태
                            <select class="act" id="act" name="act">
                            <option value="AD">-정상/삭제-</option>
                            <option value="A">정상</option>
                            <option value="D">삭제</option>
                        </select>
                        </th>
                    </tr>
                    </thead>
                    <%--게시판/댓글 리스트--%>
                    <tr class="boardList">
<%--                        <td data-sn='12'></td>--%>
<%--                        <td></td>--%>
<%--                        <td></td>--%>
<%--                        <td></td>--%>
<%--                        <td></td>--%>
<%--                        <td></td>--%>
<%--                        <td></td>--%>

                    </tr>

                </table>
            </div>

            <div style="display: flex; justify-content: space-between;">

                <div>
                    <button class="footer-button" id="update">수정</button>
                    <button class="footer-button2" id="remove">삭제</button>
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

    //'document'

    $(document).ready(function(){

        let boardUl = $('tbody'); //게시판 출력

        let boardCntSort; //select optoin 10 25 50개 값을 넣어서 list뽑는다.

        let bbsOrReplyVal;

        //default 값
        let amount = 10, page = 1; //페이징 default 값
        let bbsOrReplyVar = "board"; // select option 게시글 or 댓글 defalut값
        let sort = "S"; // 최신 / 오래된
        let active = "AD"; // 정상 / 삭제
        let keyword = "EN"; // email / id
        let searchResult = ""; //검색 input창

        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        });

        //checkbox 전체선택
        $('#allCheck').on('click', function(){
            allCheck(this);
        })

        // $('.boardCkBox').on('click', function(){
        //     console.log("fasdfasdf");
        //     if($('input[id="check"]:checked').length == 10){
        //         $('#allCheck').prop('checked', true);
        //     }else{
        //         $('#allCheck').prop('checked', false);
        //     }
        // })

        //adminBoardRemove
        $('#remove').on('click', function(){
            oneCheck(this);
        })

        $('#update').on('click', function (){
            oneCheck(this);
        })

        //'input[id="check"]'
        function allCheck(obj){

            let isAllChecked = $(obj).prop('checked');

            if(isAllChecked) {
                $('input[id="check"]').prop('checked', true);
                //oneCheck();
            }else{
                $('input[id="check"]').prop('checked', false);
            }

        }

        function oneCheck(obj){

            console.log(obj.innerHTML);

            let storeIndex = [];
            let dataArr = [];
            let unCheck;
            let checkList = $('.boardCkBox:checked');

            //삭제인지 업데이트인지
            let deleteOrUpdateBtn = obj.innerHTML;

            checkList.each(function(index){
                console.log("clicked");
                //게시판 행을 가져온다
                let tr = $(this).parent().parent().eq(0);
                //게시판 고유번호를 가져온다
                let snResult = tr.children().eq(2).text();

                unCheck = tr.children().eq(0).children().eq(0);

                storeIndex.push(unCheck);
                console.log(unCheck);
                //storeIndex.push(snResult);

                if(checkList.get(index)){
                    dataArr.push(snResult);
                }
                console.log(storeIndex);
                console.log(dataArr);
                console.log(dataArr.length);
            }); //end checkList.each()

            //삭제or업데이트 버튼 구별
            if(deleteOrUpdateBtn === '삭제'){
                console.log('deleteBtnClicked');

                adminBoardDelete(deleteOrUpdateBtn);
            }else if(deleteOrUpdateBtn === '수정'){
                console.log('updateBtnClicked');

                adminBoardUpdate(deleteOrUpdateBtn);
            }


            function adminBoardDelete(deleteOrUpdateBtn){
                console.log('callDelete');

                let existResult = existArr(deleteOrUpdateBtn);
                console.log("existResult :"+existResult);

                if(!existResult){
                    return;
                }

                let deleteConfirm = confirm('삭제하시겠습니까?');

                if(deleteConfirm){

                    adminBoardListService.adminBoardDelete(dataArr, bbsOrReplyVar, function(result) {
                        console.log("-------callback-------");
                        console.log("deleteResult : "+result);

                        successOrFail(result);

                    }); // end adminDelete

                } //end if(deleteConfirm)

            }// admindelete

            function adminBoardUpdate(){
                console.log('callUpdate');

                let existResult = existArr(deleteOrUpdateBtn);

                if(!existResult){
                    return
                }

                let updateConfirm = confirm('수정하시겠습니까?');

                if(updateConfirm){

                    adminBoardListService.adminBoardUpdate(dataArr, bbsOrReplyVar, function(result) {
                        console.log("-------callback-------");
                        console.log("updateResult : " + result);

                        successOrFail(result);

                    }); // end adminUpdate

                } //end if(deleteConfirm)
            } // end adminupdate

            // 배열에 값이 있는지 판단한다.
            // 없으면 false 리턴해서 실행을 종료시킨다.
            function existArr(deleteOrUpdateBtn){
                console.log("existArrCall : "+deleteOrUpdateBtn);

                if(dataArr.length === 0 || dataArr === null){
                    if(deleteOrUpdateBtn === '삭제'){
                        alert('삭제할 데이터가 없습니다.');
                        return false;
                    }
                    if(deleteOrUpdateBtn === '수정'){
                        alert('수정할 데이터가 없습니다.');
                        return false;
                    }
                }
                return true;
            } // end existArr


            function successOrFail(result){

                if(result === 'deletesuccess'){
                    alert('삭제되었습니다.');
                }else if(result === 'updatesuccess'){
                    alert('수정되었습니다');
                }else{
                    alert('삭제/수정이 실패되었습니다.');
                }

            } // end successOrFail

            //삭제,수정 확인을 누르면 checked true -> false 체크박스 해제시킨다.
            for(let i = 0; i < storeIndex.length; i++){
                console.log(storeIndex[i]);
                storeIndex[i].eq(0).prop('checked', false);
                $('#allCheck').prop('checked', false);

            }

            showBoardList(page, amount, bbsOrReplyVar, sort, active, keyword, searchResult);

        } // end oneCheck()

        //input 검색창 search
        $('#search').keyup(function (){
            let searchResult = $(this).val();
            console.log("searchResult : "+searchResult);
            showBoardList(page, amount, bbsOrReplyVar, sort, active, keyword, searchResult);

        })

        // email : E / id : N / email, id : EN
        $('#searchKeyword').on('change', function(){
            $(this).each(function(){
                if ($(this).val() == 'E'){
                    keyword = 'E';
                }else if($(this).val() == 'N'){
                    keyword = 'N';
                }else{
                    keyword = 'EN';
                }
            })
            console.log(keyword);
            showBoardList(page, amount, bbsOrReplyVar, sort, active, keyword, searchResult);
        })


       // 정상/삭제 select option
        $('#act').on('change',function(){
            $('#act').each(function(){
                if($(this).val() == 'A'){
                    active = 'A';
                }else if($(this).val() == 'D'){
                    active = 'D';
                }else{
                    active = 'AD'
                }
            })
            console.log(active);
            showBoardList(page, amount, bbsOrReplyVar, sort, active, keyword, searchResult);

        }) // end act function

        //작성일 정렬 select option
        $('#sort').on('change',function(){

            $('#sort').each(function(){
                if($(this).val() === 'S'){
                    sort = "S"
                }else if($(this).val() == 'D'){
                    sort = "D";
                }else{
                    //sort = "SS";
                }
            });
            console.log(sort);
            showBoardList(page, amount, bbsOrReplyVar, sort, active, keyword, searchResult);
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
            showBoardList(page, amount, bbsOrReplyVar, sort, active, keyword, searchResult);
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
            showBoardList(page, amount, bbsOrReplyVar, sort, active, keyword, searchResult);
        });


        showBoardList(page, amount, bbsOrReplyVar, sort, active, keyword, searchResult); //defalut값 1,10, 게시판

        function showBoardList(page, boardCntSort, bbsOrReplyVar, sort, active, keyword, searchResult){
            console.log("showBoardListPage : " +page);
            console.log("boardCntSort : " + boardCntSort);
            console.log("bbsOrReplyVar : " + bbsOrReplyVar);
            console.log("sort : " + sort);
            console.log("active : " + active);
            console.log("keyword : " + keyword);
            console.log("searchResult : " + searchResult);

                adminBoardListService.adminBoardList(page, boardCntSort, bbsOrReplyVar, sort,
                    active, keyword, searchResult,
                    function (cnt, list, compare) {

                        let str = "";

                        console.log("-----------callback data-------------");
                        console.log("cnt"+cnt);
                        console.log("list"+list);
                        console.log("compare"+compare);
                        console.log("sort : "+sort);
                        console.log("active : "+active);

                        //board or reply
                        // if (compare === 'isBoard') {
                        //     listPrint(compare);
                        //
                        // } else {
                            listPrint(compare);
                        //}

                        function listPrint(compare){

                            //board reply 변경 시 header 변경
                            if(compare === 'isBoard'){
                                $('tr > th:eq(5)').html('제목');

                            }else{
                                $('tr > th:eq(5)').html('댓글 내용');

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


                            //리스트 출력
                            for (let i = 0, len = list.length || 0; i < len; i++) {
                                //let status = "";
                                let dat = "";
                                let statusVar = list[i].status;

                                // board or reply
                                // if(compare === 'isBoard'){
                                //     statusToText(statusVar);
                                // }else{
                                //     statusToText(statusVar);
                                // }

                                //status 코드 -> 한글
                                let status = statusToText(statusVar);

                                //페이지 번호 amount = 10 25 50
                                // i+1+(amount*(page-1))
                                //번호 1 ~ 게시글 or 댓글 개수
                                let resultNum = (i + 1) + (amount * (page - 1));

                                str += "<tr class='boardList'>";
                                str += "<td  data-sn='"+list[i].sn+"'><input type='checkbox' id='check' name='check' class='boardCkBox'></td>";
                                str += "<td>"+resultNum+"</td>";
                                str += "<td data-sn='12'>" + list[i].sn + "</td>";
                                str += "<td>" + list[i].userId + "</td>";
                                str += "<td>" + list[i].name + "</td>";
                                // 게시글 제목 / 댓글 내용이 20글가 넘으면 ...표시
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

                            function statusToText(statusVar){
                                //console.log("statusVar :"+statusVar);
                                let status = "";
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
                                return status;
                            }


                        }//end listPrint
                        boardUl.html(str);

                        console.log("board or reply Cnt" + cnt);

                        showAdminBoardPage(cnt);

                        // 전체 체크 상태에서 체크박스를 1개 해제하면 전체가 해제되고
                        // 체크 박스가 다 체크되면 전체 체크 박스가 체크된다.
                        $('.boardCkBox').on('click', function(){

                            let isChecked = true;

                            $('.boardCkBox').each(function(){
                                isChecked = isChecked && $(this).is(':checked');
                            })
                            $('#allCheck').prop('checked', isChecked)
                        })


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
                        console.log("endNumPagingFuntion"+endNum)
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

                    showBoardList(page,amount, bbsOrReplyVar, sort, active, keyword, searchResult);


                });

            //} //end listCall

    });// end ready

</script>