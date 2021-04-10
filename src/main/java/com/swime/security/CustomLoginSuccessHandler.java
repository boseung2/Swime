package com.swime.security;

import lombok.extern.log4j.Log4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Log4j
//로그인 성공시 할 행동
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth) throws IOException, ServletException {
        // 권한체크용 배열
        List<String> roleNames = new ArrayList<>();

        //유저가 가진 권한을 하나 하나 빼서 배열에 넣는다
        auth.getAuthorities().forEach(grantedAuthority -> {
            roleNames.add(grantedAuthority.getAuthority());
        });

        // 대상이 어드민이면
        if(roleNames.contains("ADMIN")){}
        // 대상이 멤버이면
        if(roleNames.contains("MEMBER")){}

//        example
//        로그인에 성공했고 그 대상이 어드민이라면 어드민 페이지로 보내준다
//        if(roleNames.contains("ADMIN")){
//            response.sendRedirect("/adminPage");
//            return;
//        }

        response.sendRedirect("/index");
    }
}
