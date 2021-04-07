package com.swime.mapper;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyListVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class StudyListMapperTests {

    @Setter(onMethod_ = @Autowired)
    private StudyListMapper mapper;

    @Test
    public void testGetList() {
        mapper.getList().forEach(study -> log.info(study));
    }

    @Test
    public void testGetListWithPaging() {
        StudyCriteria cri = new StudyCriteria();
        cri.setPageNum(1);
        cri.setAmount(3);

        mapper.getListWithPaging(cri).forEach(study -> log.info(study));
    }

    @Test
    public void testInsert() {
        StudyListVO list = new StudyListVO();
        list.setStdSn(82);
        list.setUserId("aaa@naver.com");
        list.setStatus("STST01");

        log.info("INSERT COUNT : " + mapper.insert(list));
    }

    @Test
    public void testUpdate() {
        log.info("UPDATE COUNT : " + mapper.update(82L, "aaa@naver.com", "STST04"));
    }
}
