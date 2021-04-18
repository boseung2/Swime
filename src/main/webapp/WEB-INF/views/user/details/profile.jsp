<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../../includes/tagLib.jsp" %>
<meta id="_csrf" name="_csrf" content="${_csrf.token}" />
<meta id="_csrf_header" name="_csrf_header" content="${_csrf.headerName}" />

<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal.username" var="userId"/>
</sec:authorize>

<div class="container">
    <h2>프로필 수정</h2>
    <hr/>
<%--    action="/user/modify" method="post"--%>
    <form role="form" id="userInfoForm">

        <div class="form-group">
            <label for="userId">아이디</label>
            <input type="text" class="form-control" id="userId" name="id" value="${MemberVo.id}" readonly>
        </div>

        <c:if test="${userId == MemberVo.id}">
            <div class="form-group">
                <label for="password">비밀번호</label>
                <input type="password" class="form-control" name="password" id="password" readonly>
            </div>
            <div class="form-group">
                <label for="passwordConfirm">비밀번호 확인</label>
                <input type="password" class="form-control" id="passwordConfirm" name="passwordConfirm" readonly>
            </div>
        </c:if>

        <div class="form-group">
            <label for="name">이름</label>
            <input type="text" class="form-control" id="name" name="name" value="${MemberVo.name}" readonly>
        </div>
        <div class="form-group">
            <label for="birth">생일</label>
            <input type="date" class="form-control" id="birth" name="birth" value="${MemberVo.birth}" readonly>
        </div>

        <c:if test="${userId == MemberVo.id}">
            <div class="form-group">
                <label for="picture">사진</label>
                <input type="file" class="form-control" id="picture" name="picture" value="${MemberVo.picture}" readonly>
            </div>
            <button id="submitBtn" class="btn btn-primary">정보 수정</button>
            <button id='cancel' class='btn btn-primary'>취소</button>
        </c:if>

        <input type="hidden" name="status" value="${MemberVo.status}">
        <input type="hidden" name="email" value="${MemberVo.id}">
<%--        <sec:csrfInput/>--%>
    </form>
</div>


<script>
    $(document).ready(function (){
        // 변수들
        let password = $("#password")[0];
        let confirmPassword = $("#passwordConfirm")[0];
        let modifyMode = false;
        let inputs = $("#userInfoForm > .form-group > input");
        let submitBtn = $("#userInfoForm > #submitBtn");
        let cancelBtn = $("#cancel")[0];
        let isError = false;

        // 기본세팅
        $(cancelBtn).hide();

        // $(password).change(function () {
        //     if(!compare(password, confirmPassword)) {
        //         console.log("비밀번호 일치x")
        //         this.setCustomValidity("비밀번호가 일치하지 않습니다");
        //         return;
        //     }
        // });
        //
        // $(confirmPassword).keyup(function (e){
        //     e.preventDefault();
        //     if(!compare(password, confirmPassword)) {
        //         confirmPassword.setCustomValidity("비밀번호가 일치하지 않습니다");
        //
        //     }
        // });


        // 제출 버튼을 누르면
        $(submitBtn).click(function (e){
            if(!compare(password, confirmPassword)) {
                confirmPassword.setCustomValidity("비밀번호가 일치하지 않습니다");
                return;
            }

            e.preventDefault();

            sendData().then(function (result){
                changeBtn(result);
            });
        });

        $(cancelBtn).click(function (e){
            e.preventDefault();
            $.ajax({url:"/user/details/profile" ,
                data : {
                    id : '${MemberVo.id}'
                },
                success:function(result) {
                    $("#content").html(result);
                }});

        });

        function sendData() {
            return new Promise(function(resolve, reject) {
                if(modifyMode){
                    $.ajax({
                        url: '/user/modify',
                        type: 'POST',
                        data: {
                            id : $('#userId')[0].value,
                            password : $('#password')[0].value,
                            name : $('#name')[0].value,
                            birth : $('#birth')[0].value,
                            picture : $('#picture')[0].value,
                            status : '${MemberVo.status}',
                            email : '${MemberVo.id}',
                            _csrf : $("#_csrf")[0].content
                        },
                        success: function(msg) {
                            alert('정보를 수정했습니다');
                            password.value = '';
                            confirmPassword.value = '';
                            resolve(true);
                        },
                        error : function (msg) {
                            alert('에러가 발생했습니다');
                            resolve(false);
                        }
                    });
                }else{
                    resolve(true);
                }
            });
        }

        function changeBtn(result){
            if(result){
                changeModifyStatus(submitBtn, inputs, modifyMode, cancelBtn);
                modifyMode = !modifyMode;
            }
            else if(!result){
                console.log("실패");
            }
        }

        function checkPassword(){
            if(!compare(password, confirmPassword)) {
                console.log("비밀번호 일치x")
                confirmPassword.setCustomValidity("비밀번호가 일치하지 않습니다");
                return;
            }
        }

    });


    function compare(pwd1, pwd2){
        return pwd1.value === pwd2.value;
    }

    function changeModifyStatus(obj, inputs, condition, cancelBtn){
        changeBtn(obj, condition, cancelBtn);
        changeInputs(inputs, condition);
    }

    function changeInputs(inputs, condition){
        for(let i = 0; i < inputs.length; i++)
            if(inputs[i].id !== 'userId')
                inputs[i].readOnly = condition;
    }

    function changeBtn(obj, condition, cancelBtn){
        if(condition){
            $(obj).removeClass('btn btn-warning');
            $(obj).addClass('btn btn-primary');
            $(obj).text('정보 수정');
            $(cancelBtn).hide();

        }
        else{
            $(obj).removeClass('btn btn-primary');
            $(obj).addClass('btn btn-warning');
            $(obj).text('확인');
            $(cancelBtn).show();
        }
    }
</script>


