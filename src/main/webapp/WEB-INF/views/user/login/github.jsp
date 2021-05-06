<%--
  Created by IntelliJ IDEA.
  User: tht12
  Date: 2021-04-29
  Time: 오후 3:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@include file="../../includes/header.jsp" %>



<script>

    $(document).ready(function (){
        let id = "${ghPerson.login}";

        if(id === ''){
            $(location).attr('href', '/user/login');
            return;
        }

        isAlready(id);


    });

    $(document).ajaxSend(function(e, xhr, options) {
        xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
    });


    function isAlready(id) {
        $.ajax({
            url: '/user/already',
            type: 'GET',
            data: {
                id : id
            },
            success: function(result) {
                let isAlready = result.documentElement.textContent === "true";
                if(isAlready){
                    console.log("있는 아이디");
                    login();
                }else{
                    console.log("없는 아이디");
                    register();
                }

            }
        });
    }

    function register(){
        console.log("register");

        $.ajax({
            url: '/user/registerSocial',
            type: 'POST',
            data: {
                id : "${ghPerson.login}",
                name : "${ghPerson.name}",
                password : "github",
                regPath : "REPA02",
                status : "USST01"
            },
            success: function(result) {
                console.log(result);
                login();
            }
        });
    }

    function login(){
        console.log("login");

        $.ajax({
            url: '/user/login',
            type: 'POST',
            data: {
                id : "${ghPerson.login}",
                password : "github"
            },
            success: function(result) {
                $(location).attr('href', '/');
            }
        });
    }
</script>