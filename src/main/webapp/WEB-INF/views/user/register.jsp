<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@include file="../includes/header.jsp" %>

<script type="text/javascript" src="../../../resources/js/validation.js"></script>
<link href="/resources/css/user.css" rel="stylesheet">

<div>
    <main class="form-signin">
        <div id="regdiv">
            <div id="errorMsgDiv"></div>
            <%--            <form id="regForm" action="/user/AuthSuccess">--%>
            <form id="regForm" action="/user/register" method="post">
                <h1 class="h3 mb-3 fw-normal">Please sign in</h1>

                <label for="id" class="inp">
                    <input type="email" id="id" name="id" placeholder="&nbsp;" required>
                    <span class="label">Email</span>
                    <span class="focus-bg"></span>
                </label>
                <br>
                <label for="pw" class="inp">
                    <input type="password" id="pw" name="password" placeholder="&nbsp;" required>
                    <span class="label">Password</span>
                    <span class="focus-bg"></span>
                </label>
                <br>
                <label for="pwc" class="inp">
                    <input type="password" id="pwc" placeholder="&nbsp;" required>
                    <span class="label">Password Confirm</span>
                    <span class="focus-bg"></span>
                </label>
                <br>
                <label for="name" class="inp">
                    <input type="text" id="name" name="name" placeholder="&nbsp;" required>
                    <span class="label">Name</span>
                    <span class="focus-bg"></span>
                </label>
                <br>
                <div class="checkbox mb-3">
                    <label>
                        <input id="agree" type="checkbox" value="이용약관" required> 본 사이트 이용약관에 동의합니다.
                    </label>
                </div>
                <sec:csrfInput/>
                <%--            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">--%>
            </form>
            <button id="submitBtn" class="w-100 btn btn-lg btn-primary">Sign up</button>
        </div>
    </main>
</div>


<script>
    let a;
    $(document).ready(function () {
        let email = $("#id")[0];
        let password = $("#pw")[0];
        let confirm_password = $("#pwc")[0];
        let submitBtn = $("#submitBtn")[0];
        let nameInput = $("#name")[0];
        let checkBox = $("#agree")[0];

        let errorBox = $("#errorMsgDiv")[0];
        let errorMsg;
        let ismsg = false;
        init();


        $(email).on("change", function () {
            console.log("이메일 내용");

            if(isAlready(true)) return;

        });


        $(submitBtn).on("click", async function (e) {
            e.preventDefault();
            // e.stopPropagation();

            if(await isAlready(false)) return;
            if(!(await checkOne())) return;
            if(!(await checkTwo())) return;
            $("#regForm")[0].submit();
        });


        function init() {
            $(errorBox).hide();
            $(errorBox).html('<div id="errorMsg" class="w-100 btn btn-lg btn-danger">error</div>');
            errorMsg = $("#errorMsg")[0];
        }

        function checkOne() {
            if (isNull(password, nameInput)) {
                showErrorMsg(errorBox, errorMsg, "미 입력란이 있습니다");
                return false;
            }
            if (!isEqual(password, confirm_password)) {
                showErrorMsg(errorBox, errorMsg, "비밀번호가 일치하지 않습니다");
                return false;
            }
            if (!isChecked(checkBox)) {
                showErrorMsg(errorBox, errorMsg, "이용약관에 동의하셔야 합니다");
                return false;
            }
            return true;
        }

        function checkTwo() {
            let min = 8;
            let max = 20;
            if (!checkLength(email, min, 33, errorBox, errorMsg, "아이디")
                || !checkLength(password, 4, 12, errorBox, errorMsg, "비밀번호")
                || !checkLength(nameInput, 1, 10, errorBox, errorMsg, "이름")) return false;
            else return true;
        }

        function isAlready(res) {
            $.ajax({
                url: '/user/already',
                type: 'GET',
                <%--beforeSend : function(xhr) {--%>
                <%--    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");--%>
                <%--},--%>
                data: {
                    id : email.value
                },
                success: function(result) {
                    let is = result.all[0].innerHTML === "true";
                    if(is) {
                        $(errorBox).show();
                        showErrorMsg(errorBox, errorMsg, "이미 있는 아이디입니다");
                    }
                    else {
                        if(res){
                            $(errorBox).hide();
                        }
                    }
                    return is;
                }
            });
        }
    });


</script>


<%@include file="../includes/footer.jsp" %>