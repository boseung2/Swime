package com.swime.config;

import com.swime.security.CustomLoginSuccessHandler;
import com.swime.security.CustomUserDetailsService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
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

import javax.sql.DataSource;

@Configuration
@EnableWebSecurity
@Log4j
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    @Setter(onMethod_ = @Autowired)
    private DataSource dataSource;

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
        String getUserQuery = "";
        String getUserDetailQuery = "";

        auth
            .jdbcAuthentication()
                .dataSource(dataSource)
                .passwordEncoder(passwordEncoder())
                .usersByUsernameQuery(getUserQuery)
                .authoritiesByUsernameQuery(getUserDetailQuery);
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
    };
}