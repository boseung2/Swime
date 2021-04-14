<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<%@include file="../includes/header.jsp" %>


<div>
    <main class="form-signin">
        <form action="/user/register" method="post">
            <img class="mb-4" src="https://getbootstrap.com/docs/5.0/assets/brand/bootstrap-logo.svg" alt="" width="72" height="57">
            <h1 class="h3 mb-3 fw-normal">Please sign in</h1>

            <div class="form-floating">
                <input type="email" class="form-control" id="floatingInput" placeholder="name@example.com" name="id" required>
                <label for="floatingInput">Email address</label>
            </div>
            <div class="form-floating">
                <input type="password" class="form-control" id="floatingPassword" placeholder="Password" name="password" required>
                <label for="floatingPassword">Password</label>
            </div>
            <div class="form-floating">
                <input type="password" class="form-control" id="checkPassword" placeholder="Password Confirm" required>
                <label for="checkPassword">Password</label>
            </div>
            <div class="form-floating">
                <input type="name" class="form-control" id="floatingInput1" placeholder="name" name="name" required>
                <label for="floatingInput1">name</label>
            </div>

            <div class="checkbox mb-3">
                <label>
                    <input type="checkbox" value="이용약관" required> 본 사이트 이용약관에 동의합니다.
                </label>
            </div>
            <sec:csrfInput/>
<%--            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">--%>
            <button class="w-100 btn btn-lg btn-primary" type="submit">Sign up</button>
            <p class="mt-5 mb-3 text-muted">&copy; 2017–2021</p>
        </form>
    </main>
</div>


<script>
    let password;
    let confirm_password;
    let submit;

    function validatePassword(){
        if(password.value !== confirm_password.value) {
            console.log("not match")
            confirm_password.setCustomValidity("비밀번호가 일치하지 않습니다");
        } else {
            confirm_password.setCustomValidity('');
        }
    }

    window.onload = function () {
        password = document.getElementById('floatingPassword');
        confirm_password = document.getElementById('checkPassword');


        password.onchange = validatePassword;
        confirm_password.onkeyup = validatePassword;
    }
</script>



<%@include file="../includes/footer.jsp" %>