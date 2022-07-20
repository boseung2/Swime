package com.swime.security;

import com.swime.domain.MemberVO;
import com.swime.util.JwtUtil;
import lombok.extern.log4j.Log4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@Log4j
//로그인 성공시 할 행동
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
//    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth) throws IOException, ServletException {
        CustomUser customUser = (CustomUser) auth.getPrincipal();

        JwtUtil jwtUtil = new JwtUtil("aaa", 154654105L,3423432L);
        String value = jwtUtil.createToken(customUser.getMemberVO(), "accessToken", 213213L);

        Cookie kc = new Cookie(JwtUtil.ACCESS_TOKEN, value);
        kc.setMaxAge(1000);
        kc.setPath("/");
        response.addCookie(kc);

        response.sendRedirect("/");
    }
}
