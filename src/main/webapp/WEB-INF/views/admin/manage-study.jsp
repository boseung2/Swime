<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<style>
    .active {
        background-color: dodgerblue;
        color: white;
    }
</style>


<div class="container-fluid">
    <!-- <h2 class="mt-4">스터디관리</h2> -->
    <ol class="breadcrumb mb-4">
        <!-- <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li> -->
        <li class="breadcrumb-item">manage-study</li>
    </ol>
    <div class="card mb-4">
        <div class="card-header">
        </div>
        <div class="card-body">
            <div class="option-search">
                <div>
                    <select class="lines">
                        <option value="">--줄--</option>
                        <option value="10">10</option>
                        <option value="25">25</option>
                        <option value="50">50</option>
                    </select>
                </div>
                <div style="display: flex; margin-left: auto;">
                    <select class="bbsOrReply">
                        <option value="">--전체--</option>
                        <option value="upcomingstudy">예정된스터디</option>
                        <option value="passedstudy">지난스터디</option>
                    </select>
                    <select class="bbsOrReply">
                        <option value="">--전체--</option>
                        <option value="studyname">스터디명</option>
                        <option value="studyhost">스터디장명</option>
                    </select>

                    <div class="search-bar">
                        <input class="inputButton" type="text" placeholder="Search..." maxlength="20" >
<%--                        <input type="button" class="search-button">--%>
                        <button class="search-button"><i class="fas fa-search"></i></button>

                    </div>
                </div>
            </div>
            <div class="table-responsive">
                <table class="table table-bordered" width='100%' cellspacing="0">
                    <thead>
                    <tr>
                        <th><input type="checkbox"></th>
                        <th>#</th>
                        <th>sn</th>
                        <th>모임번호</th>
                        <th>스터디명</th>
                        <th>스터디장 ID</th>
                        <th>시작일자</th>
                        <th>종료일자</th>
                        <th>온오프라인</th>
                        <th>등록일</th>
                        <th>수정일</th>
                        <th>상태</th>
                    </tr>
                    </thead>
                    <tbody id="studyList">

                    </tbody>
                </table>
            </div>
            <div style="display: flex; justify-content: space-between;">

                <div>
                    <button class="footer-button">수정</button>
                    <button class="footer-button2">삭제</button>
                </div>
                <div id="pagination">
                    <button class="page-number"><</button>
                    <button class="page-number">1</button>
                    <button class="page-number">2</button>
                    <button class="page-number">3</button>
                    <button class="page-number">10</button>
                    <button class="page-number">></button>

                </div>
            </div>

        </div>
    </div>
</div>

<script type="text/javascript" src="/resources/js/adminStudy.js"></script>
<script>
    $(document).ready(function() {

        // 전체 스터디 리스트 가져오기
        getTotalList(1, 10);

    })
</script>

<script>
    function getTotalList(pageNum, amount) {
        adminStudyService.getTotalList({pageNum : pageNum, amount: amount}, function(cnt, list){

            if(list == null || list.length <= 0) {
                return;
            }

            let str = '';

            for(let i = 0; i < list.length; i++) {
                str += '<tr>';
                str += '<td><input type="checkbox"></td>';
                str += '<td>' + list[i].rn + '</td>';
                str += '<td>' + list[i].sn + '</td>';
                str += '<td>' + list[i].grpSn + '</td>';
                str += '<td>' + list[i].name + '</td>';
                str += '<td>' + list[i].representation + '</td>';
                str += '<td>' + list[i].startDate.substring(0, 11) + '</td>';
                str += '<td>' + list[i].endDate.substring(0, 11) + '</td>';

                if(list[i].onOff === "STOF01") {
                    str += '<td>온라인</td>';
                }else {
                    str += '<td>오프라인</td>';
                }

                let regDate = new Date(list[i].regDate);
                let updDate = new Date(list[i].updDate);


                str += '<td>' + regDate.toLocaleDateString() + '</td>';
                str += '<td>' + updDate.toLocaleDateString() + '</td>';

                if(list[i].status === "STST01") {
                    str += '<td>정상</td>';
                }else if(list[i].status === 'STST02'){
                    str += '<td>삭제</td>';
                }
            }

            $('#studyList').html(str);

            // 페이징 처리
            showStudyPage(cnt, amount);
        })
    }


    let studyPageNum = 1;

    function showStudyPage(cnt, amount) {
        let endNum = Math.ceil(studyPageNum / 10.0) * 10;
        let startNum = endNum - 9;

        let prev = startNum != 1;
        let next = false;

        if (endNum * amount >= cnt) {
            endNum = Math.ceil(cnt / parseFloat(amount));
        }

        if(endNum * 10 < cnt) {
            next = true;
        }

        console.log("studyCount = " + cnt);
        console.log("startNum = " + startNum);
        console.log("endNum = " + endNum);
        console.log("prev = " + prev);
        console.log("next = " + next);

        let str = '';

        if(prev) {
            str += '<button class="page-number" id="' + (startNum - 1) + '"><</button>';
        }

        for(let i = startNum; i <= endNum; i++) {
            let active = studyPageNum == i ? "active" : "";

            str += '<button class="page-number ' + active + '">' + i + '</button>';
        }

        if(next) {
            str += '<button class="page-number" id="' + (endNum + 1) + '">></button>';
        }

        $('#pagination').html(str);
    }


    $('#pagination').on("click", "button", function(e) {
        e.preventDefault();

        console.log("page clicked");
        console.log($(this));

        let targetPageNum = $(this).html();

        if(targetPageNum === '&gt;' || targetPageNum === '&lt;') {
            targetPageNum = $(this)[0].id;
        }

        console.log("targetPageNum: " + targetPageNum);

        studyPageNum = targetPageNum;

        getTotalList(studyPageNum, 10);

    })
</script>
