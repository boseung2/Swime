package com.swime.util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import lombok.AllArgsConstructor;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

import javax.servlet.*;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;
import java.io.IOException;
import java.util.Base64;

@AllArgsConstructor
public class JwtAuthenticationFilter implements Filter {

    CookieUtils cookieUtils;
    DataSource dataSource;

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {

    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        Cookie accessToken = cookieUtils.getCookie((HttpServletRequest) request, JwtUtil.ACCESS_TOKEN);
        System.out.println(accessToken);

        try {
            if(accessToken != null) {
                String value = accessToken.getValue();
                Claims claims = Jwts.parser().setSigningKey(Base64.getEncoder().encodeToString("aaa".getBytes())).parseClaimsJws(value).getBody();
                String id = (String) claims.get("userId");
                Authentication auth = SecurityContextHolder.getContext().getAuthentication();
                UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken = new UsernamePasswordAuthenticationToken(id,"none");
//                auth.authenticate(usernamePasswordAuthenticationToken);
//
//                Authentication auth = authManager.authenticate(authReq);
//                SecurityContext sc = SecurityContextHolder.getContext();
//                sc.setAuthentication(auth);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }


        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {

    }
}
