package com.swime.config;

import com.swime.security.CustomLoginSuccessHandler;
import com.swime.security.CustomUserDetailsService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;
import org.springframework.security.web.csrf.CookieCsrfTokenRepository;
import org.springframework.security.web.csrf.CsrfFilter;
import org.springframework.web.cors.CorsConfiguration;
import org.springframework.web.cors.CorsConfigurationSource;
import org.springframework.web.cors.UrlBasedCorsConfigurationSource;
import org.springframework.web.filter.CharacterEncodingFilter;

import javax.sql.DataSource;

@Configuration
@EnableWebSecurity
@Log4j
//@AllArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Setter(onMethod_ = @Autowired)
    private DataSource dataSource;


    @Override
    public void configure(HttpSecurity http) throws Exception{
        CharacterEncodingFilter filter = new CharacterEncodingFilter();
        filter.setEncoding("UTF-8");
        filter.setForceEncoding(true);
        http.addFilterBefore(filter, CsrfFilter.class);

        http
            .cors()
        .and()
            .authorizeRequests()
                .antMatchers("/css/**","/img/**","/js/**", "/vendor/**","/adminPageDemo/*", "/assets/**").permitAll()
                .antMatchers("/group","/include","/user", "/study").permitAll()
                .antMatchers("/group/register").access("isAuthenticated()")
                .antMatchers("/study/register").access("isAuthenticated()")
                .antMatchers("/sample/member").access("hasAuthority('MEMBER')")
                .antMatchers("/admin/**").access("hasAuthority('ADMIN')")
        .and()
            .formLogin()
                .usernameParameter("id")
                .loginPage("/user/login")
                .loginProcessingUrl("/user/login")
//                .successHandler(loginSuccessHandler())
        .and()
            .logout()
                .logoutUrl("/user/logout")
                .invalidateHttpSession(true)
//                .deleteCookies("remember-me", "JSESSIONID")
        .and()
            .rememberMe()
                .key("remember-id")
                .tokenRepository(persistentTokenRepository())
                .tokenValiditySeconds(604800)
        .and()
            .csrf()
                .csrfTokenRepository(CookieCsrfTokenRepository.withHttpOnlyFalse())
//                    .disable()
//        .and()
//            .oauth2Login()
//                .authorizationEndpoint()
//                .baseUri("/user/login/authorize")
//                .authorizationRequestRepository(cookieAuthorizationRequestRepository())
//            .and()
//                .redirectionEndpoint()
//                .baseUri("/oauth2/callback/*")
//            .and()
//                .userInfoEndpoint()
//                .userService(customOAuth2UserService)
        ;
    }

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception{
        auth
            .userDetailsService(detailsService())
            .passwordEncoder(passwordEncoder())
        ;

    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationSuccessHandler loginSuccessHandler(){
        return new CustomLoginSuccessHandler();
    }

    @Bean
    public UserDetailsService detailsService(){
        return new CustomUserDetailsService();
    }

    @Bean
    public PersistentTokenRepository persistentTokenRepository() {
        JdbcTokenRepositoryImpl repo = new JdbcTokenRepositoryImpl();
        repo.setDataSource(dataSource);
        return repo;
    }

    @Bean
    public CorsConfigurationSource corsConfigurationSource() {
        log.info("cors config....");

        CorsConfiguration configuration = new CorsConfiguration();
        configuration.addAllowedOrigin("*");
        configuration.addAllowedHeader("*");
        configuration.addAllowedMethod("*");
        configuration.setAllowCredentials(true);

        UrlBasedCorsConfigurationSource source = new UrlBasedCorsConfigurationSource();
        source.registerCorsConfiguration("/**", configuration);
        return source;
    }


}
