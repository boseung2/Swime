package com.swime.util;

import com.swime.domain.MemberVO;
import com.swime.security.CustomUser;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import lombok.extern.log4j.Log4j;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContext;
import org.springframework.security.core.context.SecurityContextHolder;

import java.util.Base64;
import java.util.Date;

@Log4j
public class JwtUtil {

        public static final String ACCESS_TOKEN = "ACCESS_TOKEN";
        public static final String REFRESH_TOKEN = "REFRESH_TOKEN";
        public final Long ACCESS_VALIDITY = 1000L * 60 * 60 * 24;
        public final Long REFRESH_VALIDITY = 1000L * 60 * 30;
        private final String SECRET_KEY = "a831a6ee";
        private final String ENCODE_SECRET_KEY = Base64.getEncoder().encodeToString(SECRET_KEY.getBytes());

        public String createAccessToken() {
            return createToken(ACCESS_TOKEN, ACCESS_VALIDITY);
        }

        public String createRefreshToken() {
            return createToken(REFRESH_TOKEN, REFRESH_VALIDITY);
        }

        public String createToken(String tokenType, Long validity) {
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            CustomUser customUser = (CustomUser) authentication.getPrincipal();
            MemberVO memberVO = customUser.getMemberVO();

            Claims claims = Jwts.claims();
            claims.put("userId", memberVO.getId());

            Date now = new Date();
            Date expiration = new Date(now.getTime() + validity);

            return Jwts.builder()
                    .setClaims(claims)
                    .setIssuedAt(now)
                    .setExpiration(expiration)
                    .signWith(SignatureAlgorithm.HS256, ENCODE_SECRET_KEY)
                    .compact();
        }

        private Claims getClaims(String token) {
            return Jwts.parser().setSigningKey(ENCODE_SECRET_KEY).parseClaimsJws(token).getBody();
        }
//
//        public UserTokenDto getUserTokenDto(String token) {
//            Claims claims = getClaims(token);
//            return UserTokenDto.builder()
//                    .id(Long.valueOf(claims.get("userId", String.class)))
//                    .role(Role.valueOf(claims.get("role", String.class)))
//                    .build();
//        }
//
//        public Authentication getAuthentication(String token) {
//            UserTokenDto userTokenDto = getUserTokenDto(token);
//            return new UsernamePasswordAuthenticationToken(userTokenDto.getId(), null,
//                    Collections.singleton(new SimpleGrantedAuthority(userTokenDto.getRole().toString())));
//        }
//
//        public String getTokenFromRequest(HttpServletRequest request) {
//            String token = request.getHeader("Authorization");
//            return token == null ? null : token.substring("Bearer ".length());
//        }
//
//        public void validateToken(String token) {
//            try {
//                Jwts.parser().setSigningKey(encodeSecretKey).parseClaimsJws(token);
//            } catch (SignatureException | MalformedJwtException | UnsupportedJwtException | IllegalArgumentException e) {
//                throw new InvalidTokenException("유효하지 않은 토큰입니다.");
//            } catch (ExpiredJwtException e) {
//                throw new ExpiredTokenException("이미 만료된 토큰입니다.");
//            }
//        }
//
//        public Long getRefreshValidity() {
//            return refreshValidity;
//        }
//
//        public boolean isRefreshToken(String token) {
//            return getClaims(token).get("tokenType").equals(REFRESH_TOKEN);
//        }
}

//@Data
//@Builder
//class UserTokenDto {
//
//    private String id;
//
//    private String role;
//
//    public UserTokenDto from(MemberVO user) {
//        return UserTokenDto.builder()
//                .id(user.getId())
//                .role(user.getRole())
//                .build();
//    }
//}