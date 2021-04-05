package com.swime.mapper;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyVO;
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
public class StudyMapperTests {

    @Setter(onMethod_ = @Autowired)
    private StudyMapper mapper;

    @Test
    public void testGetList() {
        mapper.getList().forEach(std -> log.info(std));
    }

//    @Test
//    public void testGetListWithPaging() {
//
//        StudyCriteria cri = new StudyCriteria();
//
//        List<StudyVO> list = mapper.getListWithPaging(cri);
//
//        list.forEach(std -> log.info(std));
//    }
}
