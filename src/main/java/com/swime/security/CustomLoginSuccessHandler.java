package com.swime.security;

import com.swime.domain.MemberVO;
import com.swime.util.JwtUtil;
import lombok.AllArgsConstructor;
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
import java.util.HashMap;
import java.util.Map;

@Log4j
@AllArgsConstructor
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {
//    private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

    private final JwtUtil jwtUtil;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response, Authentication auth) throws IOException, ServletException {

        String accessToken = jwtUtil.createAccessToken();
        String refreshToken = jwtUtil.createRefreshToken();

        Map<String, String> map = new HashMap<>();
        map.put(JwtUtil.ACCESS_TOKEN, accessToken);
        map.put(JwtUtil.REFRESH_TOKEN, refreshToken);

        map.forEach((key, value) -> {
            Cookie kc = new Cookie(key, value);
            kc.setMaxAge(1000);
            kc.setPath("/");
            response.addCookie(kc);
        });

        response.sendRedirect("/");
    }
}
