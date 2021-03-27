package com.swime.config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;

import javax.sql.DataSource;

@Configuration
@MapperScan(basePackages = {"com.swime.mapper"})
@ComponentScan(basePackages="com.swime.service")
public class RootConfig {

    @Bean
    public SqlSessionFactory sqlSessionFactory() throws Exception {
        SqlSessionFactoryBean sqlSessionFactory = new SqlSessionFactoryBean();
        sqlSessionFactory.setDataSource(dataSoure());
        return sqlSessionFactory.getObject();
    }

    @Bean
    public DataSource dataSoure() {
        HikariConfig hikariConfig = new HikariConfig();
        hikariConfig.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
        hikariConfig.setJdbcUrl("jdbc:log4jdbc:oracle:thin:@swime.cuhd6k7lvd6s.us-east-2.rds.amazonaws.com:1521:ORCL");

        hikariConfig.setUsername("admin");
        hikariConfig.setPassword("1q2w3e4r");

        return new HikariDataSource(hikariConfig);
    }

}
