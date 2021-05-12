package com.swime.config;

import com.swime.util.CookieUtils;
import com.swime.util.GmailSend;
import com.swime.util.MakeRandomValue;
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
import org.springframework.http.HttpMethod;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import javax.sql.DataSource;

@Configuration
@ComponentScan(basePackages = {"com.swime.task", "com.swime.service", "com.swime.aop"})
@EnableScheduling
@MapperScan(basePackages = {"com.swime.mapper"})
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
        System.setProperty("java.security.egd", "file:///dev/urandom");


        if(true){
            System.setProperty("oracle.net.tns_admin"
                    , System.getProperty("user.dir").replace('\\','/')+"/src/main/resources/wallet");
            System.out.println(System.getProperty("user.dir").replace('\\','/')+"/src/main/resources/wallet");
            System.out.println("C:/Wallet_swime");

            System.setProperty("oracle.net.tns_admin","C:/Wallet_swime");

        }else{
            System.setProperty("oracle.net.tns_admin","/Users/sinseonggwon/Wallet_swime");
        }

        HikariConfig hikariConfig = new HikariConfig();
        hikariConfig.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");


        if(true) {
            hikariConfig.setJdbcUrl("jdbc:log4jdbc:oracle:thin:@swime_tp");
            hikariConfig.setUsername("ADMIN");
            hikariConfig.setPassword("1q2w3e4r5t6Y");
            hikariConfig.setMaximumPoolSize(2);
        }
        else {
            hikariConfig.setJdbcUrl("jdbc:log4jdbc:oracle:thin:@localhost:1521:XE");
            hikariConfig.setUsername("book_ex");
            hikariConfig.setPassword("book_ex");
//            hikariConfig.setUsername("swime1");
//            hikariConfig.setPassword("1234");
        }

        return new HikariDataSource(hikariConfig);
    }


    @Bean
    public GmailSend gmailSend(){ return new GmailSend(); }

    @Bean
    public MakeRandomValue makeRandomValue(){ return new MakeRandomValue(); }

    @Bean
    public PasswordEncoder passwordEncoder() { return new BCryptPasswordEncoder(); }

    @Bean
    public CookieUtils cookieUtils() { return new CookieUtils(); }

}
