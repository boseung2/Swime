<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>


<div class="container-fluid">
    <!-- <h2 class="mt-4">회원관리</h2> -->
    <ol class="breadcrumb mb-4">
        <!-- <li class="breadcrumb-item"><a href="index.html">Dashboard</a></li> -->
        <li class="breadcrumb-item active">manage-user</li>
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
                        <option value="">--상태--</option>
                        <option value="normal">정상</option>
                        <option value="quit">탈퇴</option>
                    </select>
                    <div class="search-bar">
                        <input class="inputButton" type="text" placeholder="Search.." maxlength="20">
                        <button class="search-button"><i class="fas fa-search"></i></button>
                    </div>
                </div>
            </div>
            <div class="table-responsive">
                <table id="userTable" class="table table-bordered" width='100%' cellspacing="0">
<%--                    <thead>--%>
<%--                    <tr>--%>
<%--                        <th>#</th>--%>
<%--                        <th>email</th>--%>
<%--                        <th>이름</th>--%>
<%--                        <th>가입일</th>--%>
<%--                        <th>수정일</th>--%>
<%--                        <th>상태</th>--%>
<%--                    </tr>--%>
<%--                    </thead>--%>
<%--                    <tr>--%>
<%--                        <td>1</td>--%>
<%--                        <td>ssk900620@gmail.com</td>--%>
<%--                        <td>신성권</td>--%>
<%--                        <td>2009/01/01</td>--%>
<%--                        <td>2010/03/12</td>--%>
<%--                        <td>정상</td>--%>
<%--                    </tr>--%>
<%--                    <tr>--%>
<%--                        <td>2</td>--%>
<%--                        <td>ssk900620@gmail.com</td>--%>
<%--                        <td>신상권</td>--%>
<%--                        <td>2020/07/12</td>--%>
<%--                        <td>2020/07/12</td>--%>
<%--                        <td>비정상</td>--%>
<%--                    </tr>--%>
<%--                    <tr>--%>
<%--                        <td>3</td>--%>
<%--                        <td>ssk900620@gmail.com</td>--%>
<%--                        <td>김성권</td>--%>
<%--                        <td>1990/06/20</td>--%>
<%--                        <td>1998/05/11</td>--%>
<%--                        <td>정상</td>--%>
<%--                    </tr>--%>
                </table>
            </div>
            <div style="display: flex; justify-content: space-between;">

                <div>
                    <button class="footer-button">수정</button>
                    <button class="footer-button2">삭제</button>
                </div>
                <div id="pagi">
                    <button class="page-number"><</button>
                    <button class="page-number">1</button>
                    <button class="page-number">2</button>
                    <button class="page-number">3</button>
                    <button class="page-number">></button>
                </div>
            </div>

        </div>
    </div>
</div>

<script>

    $(document).ready(function (){

        let userPageNum = 1;
        let userAmount = 10;


        getData("readAllMember");

        function getData(url) {
            // console.log("ajax");
            $.ajax({
                url: "/adminData/" + url,
                dataType: "json",
                data: {
                    pageNum : userPageNum,
                    amount : userAmount
                }
            }).done(function (result) {
                // console.log(result);
                appendChild(result.list);
                makePagi(result.count);
                activePagi();
            }).fail(function (result) {
                console.log(result);
            });
        }

        function appendChild(list){

            let head = "" +
                "<thead>" +
                "   <tr>" +
                "       <th><input id='allCheck' type='checkbox'></th>" +
                "       <th>#</th>" +
                "       <th>email</th>" +
                "       <th>이름</th>" +
                "       <th>가입일</th>" +
                "       <th>수정일</th>" +
                "       <th>권한</th>" +
                "       <th>상태</th>" +
                "   </tr>" +
                "</thead>";

            let child = "";

            let userTable = $("#userTable");

            for (let i = 0; i < list.length; i++) {
                let id = list[i].id;
                let name = list[i].name;
                let authList = list[i].authList;
                let auth;
                let regDate = boardDisplayTime(list[i].regDate);
                let status;

                if(list[i].status === 'USST01') status = '정상';
                else if(list[i].status === 'USST02') status = '휴면';
                else if(list[i].status === 'USST03') status = '탈퇴';
                else if(list[i].status === 'USST04') status = '대기';
                else if(list[i].status === 'USST05') status = '차단';

                for (let i = 0; i < authList.length; i++) {
                    if(authList[i].auth === 'ADMIN'){
                        auth = '관리자';
                        break;
                    }
                    if(authList[i].auth === 'MEMBER') auth = '사용자';
                }

                child += "" +
                    "<tr>" +
                    "   <td>" +
                    "       <input type='checkbox'>" +
                    "   </td>" +
                    "   <td>" +
                    "       " + (i + 1 + ((userPageNum-1) * userAmount)) +
                    "   </td>" +
                    "   <td>" +
                    "       " + id +
                    "   </td>" +
                    "   <td>" +
                    "       " + name +
                    "   </td>" +
                    "   <td>" +
                    "       " + regDate +
                    "   </td>" +
                    "   <td>" +
                    "       " + regDate +
                    "   </td>" +
                    "   <td>" +
                    "       " + auth +
                    "   </td>" +
                    "   <td>" +
                    "       " + status +
                    "   </td>" +
                    "</tr>"
                ;
            }

            $(userTable).html(head + child);
        }

        function makePagi(Cnt){
            let pageNum = userPageNum;
            let endNum = Math.ceil(pageNum / 10.0) * 10;

            let startNum = endNum - 9;

            let prev = startNum != 1;
            let next = false;

            if(endNum * userAmount >= Cnt) {
                endNum = Math.ceil(Cnt / 10.0);
            }

            if(endNum * userAmount < Cnt) {
                next = true;
            }

            // console.log("startNum = " + startNum + ", endNum = " + endNum + ", prev = " + prev + ", next = " + next);
            // console.log(pageNum + "/" + "5" + "*" + " 5 = " + (pageNum / 5.0 * 5));

            let str = '<ul class="pagination">';

            if(prev) {
                str += "<li class='page-item'><a id='rating-link' class='page-link' href='#' data-btn='prev'>Previous</a></li>"
            }

            for(let i= startNum ; i <= endNum; i++) {

                let active = pageNum == i ? "active" : "";
                // "+i+"
                str += "" +
                    "<li class='page-item "+active+" '>" +
                    "   <a class='page-link' href='#' data-pagenum='" + i + "'>"+i+"</a>" +
                    "</li>";
            }

            if(next) {
                str += "<li class='page-item'><a id='rating-link' class='page-link' href='#' data-btn='next'>Next</a></li>";
            }

            str += "</ul>";

            // return str;
            $("#pagi").html(str);
        }
        
        function activePagi() {

            $(".pagination > .page-item").off("click")

            $(".pagination > .page-item").on("click", function () {
                let obj = $(this).children(".page-link")[0];

                if(obj.dataset.btn === 'prev') userPageNum--;
                else if(obj.dataset.btn === 'next') userPageNum++;
                else userPageNum = obj.dataset.pagenum;

                getData("readAllMember");
            })
        }
    })

    function boardDisplayTime(timeValue) {

        let date = new Date(timeValue);

        let year = date.getFullYear().toString().slice(-2); //년도 뒤에 두자리
        let month = ("0" + (date.getMonth() + 1)).slice(-2); //월 2자리 (01, 02 ... 12)
        let day = ("0" + date.getDate()).slice(-2); //일 2자리 (01, 02 ... 31)
        let hour = ("0" + date.getHours()).slice(-2); //시 2자리 (00, 01 ... 23)
        let minute = ("0" + date.getMinutes()).slice(-2); //분 2자리 (00, 01 ... 59)
        let second = ("0" + date.getSeconds()).slice(-2); //초 2자리 (00, 01 ... 59)

        let returnDate = year + "/" + month + "/" + day + " "+ hour + ":" + minute + ":" + second;

        return returnDate;

    }


</script>
