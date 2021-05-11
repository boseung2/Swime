package com.swime.util;

import lombok.extern.log4j.Log4j;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class VisitCountDaoTests {

    VisitCountDao dao = VisitCountDao.getInstance();

    @Test
    public void get(){
        Assert.assertNotNull(dao);
    }

    @Test
    public void conn(){
        try {
            dao.openConn_stmt();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Test
    public void run(){
        dao.countUp();
    }

}
