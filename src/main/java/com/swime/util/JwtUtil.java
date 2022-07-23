package com.swime.util;

import com.swime.domain.MemberVO;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;

import java.util.Base64;
import java.util.Date;

public class JwtUtil {

        public static final String ACCESS_TOKEN = "ACCESS_TOKEN";
        public static final String REFRESH_TOKEN = "REFRESH_TOKEN";
        public final Long accessValidity;
        public final Long refreshValidity;
        private final String SECRET_KEY = "a831a6ee";
        private final String ENCODE_SECRET_KEY = Base64.getEncoder().encodeToString(SECRET_KEY.getBytes());

        public JwtUtil(
               Long accessValidity,
               Long refreshValidity
        ) {
            this.accessValidity = accessValidity;
            this.refreshValidity = refreshValidity;
        }

        public String createAccessToken(MemberVO vo) {
            return createToken(vo, ACCESS_TOKEN, accessValidity);
        }
//
//        public String createRefreshToken(UserTokenDto userTokenDto) {
//            return createToken(userTokenDto, REFRESH_TOKEN, refreshValidity);
//        }
//
        public String createToken(MemberVO vo, String tokenType, Long validity) {
            Claims claims = Jwts.claims();
            claims.put("tokenType", tokenType);
            claims.put("userId", vo.getId().toString());
//            claims.put("role", vo.getRole());

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