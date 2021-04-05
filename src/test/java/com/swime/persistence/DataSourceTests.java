package com.swime.persistence;

import com.swime.config.RootConfig;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.sql.DataSource;
import java.sql.Connection;

import static org.junit.Assert.fail;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={RootConfig.class})
@Log4j
public class DataSourceTests {

    @Setter(onMethod_ = {@Autowired})
    private DataSource dataSource;

    @Setter (onMethod_ = {@Autowired})
    private SqlSessionFactory sqlSessionFactory;

    @Test
    public void testConnection() {
        long start = System.currentTimeMillis();
        long stop;
        try(Connection con = dataSource.getConnection()) {
            System.out.println("Connected..");
            stop = System.currentTimeMillis();
            System.out.println("connected Time " + (stop - start) + " ms.");
            log.info(con);
        }catch(Exception e) {
            fail(e.getMessage());
        }
    }

    @Test
    public void testMyBatis() {
        try(SqlSession session = sqlSessionFactory.openSession();
            Connection con = session.getConnection()
        ) {

            log.info(session);
            log.info(con);
        }catch (Exception e) {
            fail(e.getMessage());
        }
    }
}
