<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>

<%@include file="../includes/tagLib.jsp" %>

<script type="text/javascript" src="../../../resources/js/validation.js"></script>
<link href="/resources/css/user.css" rel="stylesheet">
<link href="/resources/css/spinner.css" rel="stylesheet">
<body>
<%--<div id="errorMsgDiv"></div>--%>
<div class="full">

    <div class="content">
        <div class="regdiv">
            <div id="errorMsgDiv"></div>
            <%--            <form id="regForm" action="/user/AuthSuccess">--%>
            <form id="regForm" action="/user/register" method="post">
                <h1 class="subtitle">SignUp</h1>

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
                <div class="autologin">
                    <label>
                        <input id="agree" type="checkbox" value="이용약관" required> 본 사이트 <a href="terms">이용약관</a>에 동의합니다.
                    </label>
                </div>
                <sec:csrfInput/>
                <%--            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">--%>
            </form>
            <div class="buttonForm">
            <button id="submitBtn" class="loginButton">
                <div style="margin: auto;width: 110px;">
                    <div id="subDiv" style="display: flex; justify-content: center">
                        <div class="btn-inner" id="spinnerBox">
                            <div class="loader" style="width:35px;">
                                <svg class="circular" viewBox="25 25 50 50">
                                    <circle class="path" cx="50" cy="50" r="20" fill="none" stroke-width="4" stroke-miterlimit="10"></circle>
                                </svg>
                            </div>
                        </div>
                        <div class="btn-inner">
                            SignUp
                        </div>
                    </div>
                </div>
            </button>
            </div>
        </div>
    </div>
</div>
</body>


<script>
    $("#spinnerBox").hide();

    $(document).ready(function () {
        let email = $("#id")[0];
        let password = $("#pw")[0];
        let confirm_password = $("#pwc")[0];
        let submitBtn = $("#submitBtn")[0];
        let nameInput = $("#name")[0];
        let checkBox = $("#agree")[0];

        let errorBox = $("#errorMsgDiv")[0];
        let errorMsg;


        let test = false;
        init();


        $(email).on("change", function () {
            console.log("이메일 내용");

            if(isAlready()) return;

        });


        $(submitBtn).on("click", async function (e) {
            e.preventDefault();
            // e.stopPropagation();


            if(!(await checkOne())) return;
            if(!(await checkTwo())) return;
            await isAlready();
            // $("#regForm")[0].submit();
            if(!test) registerForAjax();
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
        
        function registerForAjax() {
            console.log("ajax 실행");
            $("#spinnerBox").show();
            $("#spinnerBox").css("display","flex");

            $("#submitBtn").attr("disabled", true);

            $.ajax({
                url : '/user/register',
                type : 'POST',
                data : {
                    id : email.value,
                    password : password.value,
                    name : nameInput.value,
                    regPath : 'REPA01'
                },
                beforeSend : function(xhr) {
                    xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
                },
                success: function(result) {
                    $(location).attr('href', '/user/registerSuccess');
                },
                error : function (msg) {
                    $("#submitBtn").attr("disabled", false);
                    $("#spinnerBox").css("display","");
                    $("#spinnerBox").hide();
                }
            });
        }

        function isAlready() {
            let isAlready;
            $.ajax({
                url: '/user/already',
                type: 'GET',
                data: {
                    id : email.value
                },
                success: function(result) {
                    isAlready = result.documentElement.textContent === "true";
                    if(isAlready){
                        $(errorBox).show();
                        showErrorMsg(errorBox, errorMsg, "이미 있는 아이디입니다");
                    }else{
                        $(errorBox).hide();
                    }
                    test = isAlready;
                    return isAlready;
                }
            });
        }



    });


</script>

<link href="/resources/css/UserFooterPos.css" rel="stylesheet">
<%--<%@include file="../includes/footer.jsp" %>--%>