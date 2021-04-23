<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>
<c:set var="error" value="${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'] != null ? '유효하지 않은 접근입니다<br>아이디와 비밀번호를 확인하세요' : null}"/>
<c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session"></c:remove>

<sec:authorize access="isAuthenticated()">
    <c:set var="isAuthenticated" value="true"/>
</sec:authorize>

<style>
    .content {
        min-height: calc(100vh - 26vh);
    }

    footer {
        margin-top: 30px;
    }

    .uploadResult > img {
        height: 70px;
    }
</style>

<link href="/resources/css/user.css" rel="stylesheet">
<div class="content">
    <div id="regdiv">
        <div id="errorMsgDiv">

        </div>
        <form id="regForm" action="/user/login" method="post">
            <h1 class="h3 mb-3 fw-normal">Please sign in</h1>

            <label for="email" class="inp">
                <input type="email" id="email" name="id" placeholder="&nbsp;">
                <span class="label">Email</span>
                <span class="focus-bg"></span>
            </label>
            <br>

            <label for="email" class="inp">
                <input type="password" id="password" name="password" placeholder="&nbsp;">
                <span class="label">Password</span>
                <span class="focus-bg"></span>
            </label>
            <br>

            <div>
                <input type="checkbox" id="check" name="remember-me">
                <label for="check">자동로그인</label>
            </div>

            <sec:csrfInput/>
            <%--        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">--%>

            <div>
                <input type="submit" class="w-100 btn btn-lg btn-primary" value="Login"></button>
            </div>
        </form>
    </div>
</div>




<script>
    alreadyLogin();


    $(document).ready(function () {
        let msg = "${error}";
        let errorBox = $("#errorMsgDiv")[0];
        let errorMsg;

        init();


        console.log(msg);

        if(msg !== ''){
            $(errorBox).show();
            $(errorMsg).html(msg);
        }


        function init() {
            $(errorBox).hide();
            $(errorBox).html('<div id="errorMsg" class="w-100 btn btn-lg btn-danger">error</div>');
            errorMsg = $("#errorMsg")[0];
        }
    });

    function alreadyLogin() {
        let isLogin = "${isAuthenticated}" != '';
        if(isLogin){
            alert("이미 로그인중입니다\n메인페이지로 돌아갑니다");
            $(location).attr('href', '/');
            // window.history.back();

        }
    }



</script>


<%@include file="../includes/footer.jsp" %>