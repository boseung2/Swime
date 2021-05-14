<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/tagLib.jsp" %>



<c:set var="error" value="${sessionScope['SPRING_SECURITY_LAST_EXCEPTION'] != null ? '유효하지 않은 접근입니다<br>아이디와 비밀번호를 확인하세요' : null}"/>
<c:remove var="SPRING_SECURITY_LAST_EXCEPTION" scope="session"></c:remove>




<sec:authorize access="isAuthenticated()">
    <c:set var="isAuthenticated" value="true"/>
</sec:authorize>

<style>
    .content {
        min-height: calc(100vh - 26vh);
        width: 100%;
    }

    footer {
        margin-top: 30px;
    }

    .uploadResult > img {
        height: 70px;
    }


</style>

<link href="/resources/css/user.css" rel="stylesheet">
<link href="/resources/css/shootingStar2.css" rel="stylesheet">
<link href="/resources/css/floatingStar2.css" rel="stylesheet">
<body>

<div class="full">
<%--    <img src="../../../resources/img/background.jpg">--%>
<%--    <div class="night-canvas">--%>
<%--        <div class="night">--%>
<%--            <div class="shooting_star"></div>--%>
<%--            <div class="shooting_star"></div>--%>
<%--            <div class="shooting_star"></div>--%>
<%--            <div class="shooting_star"></div>--%>
<%--            <div class="shooting_star"></div>--%>
<%--            <div class="shooting_star"></div>--%>
<%--            <div class="shooting_star"></div>--%>
<%--            <div class="shooting_star"></div>--%>
<%--            <div class="shooting_star"></div>--%>

<%--            <div class="floating-star"></div>--%>
<%--        </div>--%>
<%--    </div>--%>

    <div class="night-canvas">
        <div class="floating-canvas">
            <div class="floating_star"></div>
            <div class="floating_star"></div>
            <div class="floating_star"></div>
            <div class="floating_star"></div>
            <div class="floating_star"></div>
            <div class="floating_star"></div>
            <div class="floating_star"></div>
<%--            <div class="floating_star"></div>--%>
<%--            <div class="floating_star"></div>--%>
<%--            <div class="floating_star"></div>--%>
        </div>
        <div class="shooting-canvas">
            <div class="shooting_star"></div>
            <div class="shooting_star"></div>
            <div class="shooting_star"></div>
        </div>
    </div>

<div class="content" style="z-index: 20;">

    <div id="regdiv">
        <div id="errorMsgDiv">

        </div>
        <form id="regForm" action="/user/login" method="post">
            <h1 class="subtitle">Login</h1>

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

            <div class="autologin">
                <div>
                <input type="checkbox" id="check" name="remember-me">
                <label for="check">자동로그인</label>
                </div>
            </div>
            <div class="registerid">

                <a href="/user/register">아직 회원이 아니신가요?</a>
            </div>
            <div class="forgetpw">
                <a href="/">비밀번호를 까드셨나요?</a>
            </div>

            <sec:csrfInput/>
            <%--        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">--%>

            <div class="buttonForm">
                <input type="submit" class="loginButton" value="로그인">
            </div>
        </form>
        <%--        <input type="submit" class="w-100 btn btn-lg btn-primary" value="Login"></button>--%>

        <div class="buttonForm" >

            <a class="loginButton2" href="https://github.com/login/oauth/authorize?client_id=190944c4173bf58cc6e5&redirect_uri=http://localhost/user/login/github&scope=repo,user"
            ><i class="fab fa-github" style="margin-right: 10px"></i> <span class="git">GitHub 아이디로 로그인</span></a>
        </div>
    </div>
</div>

</div>

</body>




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

<link href="/resources/css/UserFooterPos.css" rel="stylesheet">
<%--<%@include file="../includes/footer.jsp" %>--%>