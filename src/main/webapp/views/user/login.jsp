<%--
  Created by IntelliJ IDEA.
  User: JungHyungJin
  Date: 2021-04-12
  Time: 오후 2:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
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
            <input type="checkbox" id="check" name="remember-me" value="remember-me">
            <label for="check">Remember me</label>
        </div>

        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">

        <div>
            <input type="submit" value="Login">
        </div>
    </form>
</body>
</html>
