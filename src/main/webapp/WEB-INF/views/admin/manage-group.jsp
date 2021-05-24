<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>


<div class="container-fluid">
    <!-- <h2 class="mt-4">모임관리</h2> -->
    <ol class="breadcrumb mb-4">
        <!-- <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li> -->
        <li class="breadcrumb-item active">manage-group</li>
    </ol>
    <div class="card mb-4">
        <div class="card-header">
        </div>
        <div class="card-body">
            <div class="option-search">
                <div>
                    <select class="groupCntList">
                        <option value="">--줄--</option>
                        <option value="10">10</option>
                        <option value="25">25</option>
                        <option value="50">50</option>
                    </select>
                </div>
                <div style="display: flex; margin-left: auto;">
                    <select class="">
                        <option value="">--전체--</option>
                        <option value="unactivated">폐쇄</option>
                        <option value="activated">활동</option>
                    </select>
                    <select class="">
                        <option value="">--전체--</option>
                        <option value="groupname">모임명</option>
                        <option value="grouphost">모임장명</option>
                    </select>

                    <div class="search-bar">
                        <input class="inputButton" type="text" placeholder="Search.." maxlength="20" >
                        <button class="search-button"><i class="fas fa-search"></i></button>
                    </div>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-bordered" width='100%' cellspacing="0">
                    <thead>
                    <tr class="groupHeader">
                        <th>
                            <input type="checkbox" id="allCheck" name="allCheck">
                        </th>
                        <th>번호</th>
                        <th>고유번호(sn)</th>
                        <th>모임 이름</th>
                        <th>모임장 이메일</th>
                        <th>모임장 이름</th>
                        <th>모임 설명</th>
                        <th>참석인원</th>
                        <th>별점</th>
                        <th>시</th>
                        <th>군/구</th>
                        <th>모임생성일</th>
                        <th>모임상태</th>
                    </tr>
                    </thead>

                    <tr class="groupList"></tr>
<%--                    <tr>--%>
<%--                        <td>1</td>--%>
<%--                        <td>보노보노방</td>--%>
<%--                        <td>toywar94@naver.com</td>--%>
<%--                        <td>이민재</td>--%>
<%--                        <td>보노보노 사랑하는 모임</td>--%>
<%--                        <td>1000명</td>--%>
<%--                        <td>4.5</td>--%>
<%--                        <td>경기도</td>--%>
<%--                        <td>고양시</td>--%>
<%--                        <td>2009/01/01</td>--%>
<%--                        <td>정상</td>--%>
<%--                    </tr>--%>


                </table>
            </div>
            <div style="display: flex; justify-content: space-between;">

                <div>
                    <button class="footer-button">수정</button>
                    <button id="groupRemove" class="footer-button2">삭제</button>
                </div>

                <!--admin 그룹 페이징 처리-->
                <div class="groupPageFooter panel-footer">

                </div>


            </div>

        </div><!--end card body-->
    </div><!--end card md-->
</div><!--end container-->

<!--GroupList Modile-->
<script type="text/javascript" src="/resources/js/adminGroupList.js"></script>

<script type="text/javascript">

    $(document).ready(function(){

        let groupUl = $('tbody');
        let amount = 10;

        $(document).ajaxSend(function(e, xhr, options) {
            xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
        });

        //전체체크박스
        $('#allCheck').on('click', function (){

            let checked = $(this).is(":checked");

            if(checked){
                $('.groupCkBox').prop('checked', true);
            }else{
                $('.groupCkBox').prop('checked', false);
            }

        });

        //remove
        //삭제버튼
        $('#groupRemove').on('click', function(){
            //체크된 박스 삭제
            let page = $("li#board-item.page-item.active")[0].innerText

            checkedBox(page, amount);
        });

        function checkedBox(page, amount){
            console.log("removeChecked");

            let dataArr = [];
            let checkList = $('.groupCkBox:checked');

            checkList.each(function(index){

                // 모임의 sn(고유번호)를 가져와서 배열에 담는다.
                let sn = $(this).parent().attr('data-sn');
                dataArr.push(sn);

                console.log(checkList);
                console.log("sn : " + sn);
                console.log(dataArr);

            }); //end checkList.each

            //체크박스가 클릭 되었다면(데이터가 있으면)
            if(dataArr.length !== 0){

                let deleteConfirm = confirm('삭제하시겠습니까?');
                //확인 버튼을 누르면
                if(deleteConfirm){
                    adminGroupListService.adminDelete(dataArr, function(result){
                        console.log('--------callback--------')
                        console.log(result);

                        if(result !== 'success'){
                            alert('실패했습니다.');
                        }else{
                            alert('삭제되었습니다.');
                            showGroupList(page, amount);
                        }


                    })
                }
            }else{
                alert('삭제할 데이터가 없습니다.');
            }

        } // end checkedBox

        showGroupList(1, amount);

        function showGroupList(page, amount){

            console.log("groupPage : " + page +", groupAmount: " + amount);

            adminGroupListService.adminGroupList(page,amount, function(groupCnt, list){

                    console.log("groupCnt :" + groupCnt);
                    console.log("list :" + list);
                    console.log(list);

                    if(page == -1){
                        GroupPageNum = Math.ceil(groupCnt/10.0);
                        showGroupList(GroupPageNum);
                        // GroupPageNum = 1;
                        // showGroupList(GroupPageNum);
                        return;
                    }
                    let str="";

                    if(list == null || list.length == 0){
                        //groupUl.html("");
                        return;
                    }

                    //게시판 리스트 뽑는 곳
                    for(let i = 0, len = list.length || 0; i < len; i++){

                        let status = list[i].status;

                        //상태코드 -> 텍스트
                        switch (status){
                            case 'GRST01':
                                status = '정상';
                                break;
                            case 'GRST02':
                                status = '정지';
                                break;
                            case 'GRST03':
                                status = '삭제';
                                break;
                        }

                        let resultNum = (i+1) + (amount * (page -1));

                        str += "<tr class='groupList'>";
                        str += "<td data-sn='"+list[i].sn+"'><input type='checkbox' id='checkbox' name='checkbox' class='groupCkBox'></td>"
                        str += "<td>"+resultNum+"</td>";
                        str += "<td>" + list[i].sn + "</td>";
                        str += "<td>" + list[i].name + "</td>";
                        str += "<td>"+list[i].userId+"</td>";
                        str += "<td>" + list[i].userName + "</td>";
                        str += "<td>" + list[i].description + "</td>";
                        str += "<td>" + list[i].attendCount + "명"+"</td>";
                        str += "<td>" + list[i].rating + "점" +"</td>";
                        str += "<td>" + list[i].sido + "</td>";
                        str += "<td>" + list[i].sigungu + "</td>";
                        str += "<td>" + adminGroupListService.groupDisplayTime(list[i].regDate) + "</td>";
                        str += "<td>" + status + "</td>";
                        str += "</tr>";

                    }
                    groupUl.html(str);

                    showGroupPage(groupCnt);





                    //개별 체크박스 전체 체크 중 1개가 체크 해제되면 전체 체크박스 해제
                    $('.groupCkBox').on('click',function (){

                        console.log("checkClicked");

                        let isChecked = true;

                        $('.groupCkBox').each(function(){
                            //true and 체크 되어있으면
                            isChecked = isChecked && $(this).is(":checked");
                        })

                        $('#allCheck').prop('checked', isChecked);

                    });


                });

        }//end showList


        let GroupPageNum = 1;
        let groupPageFooter = $('.groupPageFooter');
        <!--게시글 페이지-->
        function showGroupPage(groupCnt) {

            console.log('groupCnt' + groupCnt + "개");

            let endNum = Math.ceil(GroupPageNum / 10.0) * 10;
            let startNum = endNum - 9;

            let prev = startNum != 1;
            let next = false;

            if (endNum * 10 >= groupCnt) {
                endNum = Math.ceil(groupCnt / 10.0);
            }

            if (endNum * 10 < groupCnt) {
                next = true;
            }

            console.log("groupCount = " + groupCnt);
            console.log("startNum = " + startNum);
            console.log("endNum = " + endNum);


            let str = "<ul class ='pagination'>";

            if (prev) {
                str += "<li id='board-item' class = 'page-item'><a id='board-link' class='page-link' href='" + (startNum - 1) + "'>Previous</a></li>";
            }

            for (let i = startNum; i <= endNum; i++) {
                let active = GroupPageNum == i ? "active" : "";

                str += "<li id='board-item' class = 'page-item " + active + " '><a id='board-link' class='page-link' href='" + i + "'>" + i + "</a></li>";
            }

            if (next) {
                str += "<li id='board-item' class = 'page-item'><a id='board-link' class='page-link' href='" + (endNum + 1) + "'>Next</a></li>";
            }

            str += "</ul></div>";

            groupPageFooter.html(str);

        }

        groupPageFooter.on("click", "li[id='board-item'] a[id='board-link']", function (e) {

            e.preventDefault();

            console.log("board page click");

            let targetPageNum = $(this).attr("href");

            console.log("targetPageNum: " + targetPageNum);

            GroupPageNum = targetPageNum;

            showGroupList(GroupPageNum,amount);

        });



    })
</script>


