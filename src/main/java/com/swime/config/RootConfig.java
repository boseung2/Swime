package com.swime.config;

import com.swime.security.CustomLoginSuccessHandler;
import com.swime.security.CustomUserDetailsService;
import com.swime.util.GmailSend;
import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import javax.sql.DataSource;
import java.util.Properties;

@Configuration
@MapperScan(basePackages = {"com.swime.mapper"})
@ComponentScan(basePackages="com.swime.service")
public class RootConfig {

    @Bean
    public SqlSessionFactory sqlSessionFactory() throws Exception {
        SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
        sqlSessionFactory.setDataSource(dataSource());

        Resource myBatisConfig = new PathMatchingResourcePatternResolver().getResource("classpath:mybatis-config.xml");
        sqlSessionFactory.setConfigLocation(myBatisConfig);
        return sqlSessionFactory.getObject();
    }

    @Bean
    public DataSource dataSource() {
        System.setProperty("oracle.jdbc.fanEnabled","false");
        System.setProperty("oracle.net.tns_admin","C:/Wallet_swime");
        System.setProperty("java.security.egd", "file:///dev/urandom");

        HikariConfig hikariConfig = new HikariConfig();
        hikariConfig.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");

        if(true){
            hikariConfig.setJdbcUrl("jdbc:log4jdbc:oracle:thin:@swime_tp");
            hikariConfig.setUsername("ADMIN");
            hikariConfig.setPassword("1q2w3e4r5t6Y");
        }
        else{
            hikariConfig.setJdbcUrl("jdbc:log4jdbc:oracle:thin:@localhost:1521:XE");
            hikariConfig.setUsername("student");
            hikariConfig.setPassword("1234");
        }
        return new HikariDataSource(hikariConfig);
    }


    @Bean
    public GmailSend gmailSend(){
        return new GmailSend();
    }


}
