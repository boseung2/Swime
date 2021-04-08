package com.swime.config;

import com.swime.security.CustomLoginSuccessHandler;
import lombok.extern.log4j.Log4j;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

@Configuration
@EnableWebSecurity
@Log4j
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Override
    public void configure(HttpSecurity http) throws Exception{
        http
            .authorizeRequests()
                .antMatchers("/**").permitAll()
                .antMatchers("/member").access("hasRole('MEMBER')")
                .antMatchers("/admin").access("hasRole('ADMIN')")
        .and()
            .formLogin()
                .loginPage("/loginPage")
                .loginProcessingUrl("/loginProcessPage")
        .and()
            .logout()
                .logoutUrl("/logoutPage")
                .invalidateHttpSession(true)
                .deleteCookies("remember-me", "JSESSION_ID")
        ;

    }

    @Override
    public void configure(AuthenticationManagerBuilder auth) throws Exception{
//        auth.
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public AuthenticationSuccessHandler loginSuccessHandler(){
        return new CustomLoginSuccessHandler();
    }
}
