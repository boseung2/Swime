<%--
  Created by IntelliJ IDEA.
  User: tht12
  Date: 2021-05-19
  Time: 오후 10:31
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal" var="pinfo"/>

    <sec:authentication property="principal.memberVO" var="pinfoMemberVO"/>
    <c:set var="memberVO" value="${pinfoMemberVO}"/>
    <c:set var="getPicture" value="/display?fileName=${fn:replace(memberVO.picture, 's_' , '')}"/>
</sec:authorize>

<!doctype html>
<html lang="en">
<head>

    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>SWIME - 우리 같이 공부 할래요?</title>
    <link rel="icon" href="../../../resources/assets/favicon.png"/>


    <!-- jQuery library -->
    <%--    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>--%>
    <script src="../../../resources/vendor/jquery/jquery.js"></script>


    <!-- Latest compiled JavaScript -->
    <%--    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>--%>

    <!-- Latest compiled and minified CSS -->
    <%--    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">--%>
    <%--    <link rel="stylesheet" href="../../../resources/vendor/bootstrap/css/bootstrap-grid.css">--%>
    <%--    <link rel="stylesheet" href="../../../resources/vendor/bootstrap/css/bootstrap-reboot.css">--%>
    <%--    <link rel="stylesheet" href="../../../resources/vendor/bootstrap/css/bootstrap.css">--%>

    <%--    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" integrity="sha384-HSMxcRTRxnN+Bdg0JdbxYKrThecOKuH5zCYotlSAcp1+c8xmyTe9GYg1l9a69psu" crossorigin="anonymous">--%>
    <%--    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap-theme.min.css" integrity="sha384-6pzBo3FDv/PJ8r2KRkGHifhEocL+1X2rVCTTkUfGk7/0pbek5mMa1upzvWbrUbOZ" crossorigin="anonymous">--%>
    <%--    <script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js" integrity="sha384-aJ21OjlMXNL5UyIl/XNwTMqvzeRMZH2w8c5cRVpzpU8Y5bApTppSuUkhZXN0VxHd" crossorigin="anonymous"></script>--%>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
    <%--    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>--%>
    <%--    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.min.js" integrity="sha384-+YQ4JLhjyBLPDQt//I+STsc9iw4uQqACwlvpslubQzn4u2UU2UFM80nGisd026JF" crossorigin="anonymous"></script>--%>

    <!-- Bootstrap core JS -->
    <%--    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.bundle.js"></script>--%>
    <%--    <script src="../../../resources/vendor/bootstrap/js/bootstrap.bundle.js"></script>--%>

    <!-- scrollbar Custom -->
    <link rel="stylesheet" href="../../../resources/css/scrollbar.css">

    <!-- font -->
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@400;700&display=swap" rel="stylesheet">

    <!-- font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.9.0/css/all.css" integrity="sha256-PF6MatZtiJ8/c9O9HQ8uSUXr++R9KBYu4gbNG5511WE=" crossorigin="anonymous" />

    <!-- sockJS -->
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>

    <!-- bootstrap override -->
<%--    <link rel="stylesheet" href="/resources/css/bootStrapOverride.css">--%>

    <!-- Custom styles for this template -->
    <link href="/resources/css/small-business.css" rel="stylesheet">

    <!-- avatar -->
    <link href="/resources/css/avatar.css" rel="stylesheet">

    <!-- filter -->
    <link href="/resources/css/filter.css" rel="stylesheet">

    <%-- countVisitor --%>
    <script src="/resources/js/visitCounter.js"></script>


    <style>
        @media (min-width: 768px) {
            .container {
                width: 750px;
            }
        }

        @media (min-width: 992px) {
            .container {
                width: 1000px;
            }
        }

    </style>

</head>
<body>


