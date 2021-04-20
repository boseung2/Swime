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
            .authorizeRequests()
                .antMatchers("/group","/include","/user", "/study").permitAll()
                .antMatchers("/group/register").access("isAuthenticated()")
                .antMatchers("/sample/member").access("hasAuthority('MEMBER')")
                .antMatchers("/sample/admin").access("hasAuthority('ADMIN')")
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
//                .disable()
        ;
//        http
//            .authorizeRequests()
//                .antMatchers("/어떠한 페이지")
//                    // 모두허용
//                    .permitAll()
//                    // 모두거부
//                    .denyAll()
//                    // 익명이면
//                    .access("isAnonymous()")
//                    // 인증된 사용자면
//                    .access("isAuthenticated()")
//                    // 인증된 사용자인데 without remember-me
//                    .access("isFullyAuthenticated()")
//        ;

    }

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception{
        // 디테일서비스로 대신함
//        String getUserQuery = "";
//        String getUserDetailQuery = "";

        auth
                .userDetailsService(detailsService()).passwordEncoder(passwordEncoder())
        // 디테일서비스로 대신함
//            .jdbcAuthentication()
//                .dataSource(dataSource)
//                .passwordEncoder(passwordEncoder())
//                .usersByUsernameQuery(getUserQuery)
//                .authoritiesByUsernameQuery(getUserDetailQuery)
//            .inMemoryAuthentication().withUser("member@naver.com").password("$2a$10$9aBxt4EPMViG6RQ62xGmteIpNubwy.PHjHoQ/W0UgqtXgqye7HA7.").roles("MEMBER")
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

}
