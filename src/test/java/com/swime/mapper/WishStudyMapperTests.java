package com.swime.mapper;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyVO;
import com.swime.domain.WishStudyVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class WishStudyMapperTests {

    @Setter(onMethod_ = @Autowired)
    private WishStudyMapper mapper;

    @Test
    public void testGetList() {
        StudyCriteria cri = new StudyCriteria(1, 3, "jiho@naver.com");

        mapper.getList(cri).forEach(study -> log.info(study));
    }

    @Test
    public void testInsert() {
        WishStudyVO wish = new WishStudyVO();
        wish.setStdSn(82L);
        wish.setUserId("jiho@naver.com");

        mapper.insert(wish);

        log.info(wish);
    }

    @Test
    public void testdelete() {
        mapper.delete(82L, "jiho@naver.com");
    }
}
