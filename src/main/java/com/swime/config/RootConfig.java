package com.swime.config;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.EnableAspectJAutoProxy;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;

import javax.sql.DataSource;

@Configuration
@MapperScan(basePackages = {"com.swime.mapper"})
@ComponentScan(basePackages="com.swime.service")
@ComponentScan(basePackages="com.swime.aop")
@EnableAspectJAutoProxy
@EnableTransactionManagement
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
        HikariConfig hikariConfig = new HikariConfig();
        hikariConfig.setDriverClassName("net.sf.log4jdbc.sql.jdbcapi.DriverSpy");
        hikariConfig.setJdbcUrl("jdbc:log4jdbc:oracle:thin:@swime_tp");
        hikariConfig.setUsername("ADMIN");
        hikariConfig.setPassword("1q2w3e4r5t6Y");
        return new HikariDataSource(hikariConfig);
    }

    @Bean
    public DataSourceTransactionManager txManager() {
        return new DataSourceTransactionManager(dataSource());
    }
}
