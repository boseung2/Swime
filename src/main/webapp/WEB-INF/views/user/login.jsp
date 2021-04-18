<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>


<div>
    <div>
        ${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"] != null ? '유효하지 않은 접근입니다<br>아이디와 비밀번호를 확인하세요' : null}
    </div>
    <form action="/user/login" method="post">
        <div>
            <input type="email" id="email" name="id" placeholder="name@example.com">
            <label for="email">Email address</label>
        </div>
        <div>
            <input type="password" id="password" name="password" placeholder="Password">
            <label for="password">Password</label>
        </div>
        <div>
            <input type="checkbox" id="check" name="remember-me">
            <label for="check">자동로그인</label>
        </div>

        <sec:csrfInput/>
        <%--        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">--%>

        <div>
            <input type="submit" value="Login">
        </div>
    </form>
</div>






<%@include file="../includes/footer.jsp" %>