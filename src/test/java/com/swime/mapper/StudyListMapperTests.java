package com.swime.mapper;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyListVO;
import com.swime.domain.StudyParamVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class StudyListMapperTests {

    @Setter(onMethod_ = @Autowired)
    private StudyListMapper mapper;

    @Test
    public void testGetList() {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(561L);
        param.setStatus("STUS01");

        List<StudyListVO> list = mapper.getList(param);

        for(StudyListVO li : list) {
            assert (li.getStdSn() == 561L);
            assert ("STUS01".equals(li.getStatus()));
        }
    }

    @Test
    public void testGetList2() {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(308L);
        param.setStatus("STUS03");

        List<StudyListVO> list = mapper.getList(param);

        for(StudyListVO li : list) {
            assert (li.getStdSn() == 308L);
            assert ("STUS03".equals(li.getStatus()));
        }
    }

    @Test
    public void testGetListWithPaging() {
        StudyCriteria cri = new StudyCriteria(1, 3);

        StudyParamVO param = new StudyParamVO();
        param.setStdSn(561L);
        param.setStatus("STUS01");

        List<StudyListVO> list = mapper.getListWithPaging(cri, param);

        assert(0 <= list.size() && list.size() <= 3);
        for(StudyListVO li : list) {
            assert (li.getStdSn() == 561L);
            assert ("STUS01".equals(li.getStatus()));
        }
    }

    @Test
    public void testGetListWithPaging2() {
        StudyCriteria cri = new StudyCriteria(1, 3);

        StudyParamVO param = new StudyParamVO();
        param.setStdSn(308L);
        param.setStatus("STUS03");

        List<StudyListVO> list = mapper.getListWithPaging(cri, param);

        assert(0 <= list.size() && list.size() <= 3);
        for(StudyListVO li : list) {
            assert (li.getStdSn() == 308L);
            assert ("STUS03".equals(li.getStatus()));
        }
    }

    @Test
    public void testGetStudiesOfGroup() {
        mapper.getStudiesOfGroup(720, "test1@naver.com").forEach(study -> log.info(study));

    }

    @Test
    public void testGetAttendant() {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(307L);
        param.setUserId("hong2841@service.com");

        assertNotNull(mapper.getAttendant(param));
    }

    @Test
    public void testInsert() {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(366L);
        param.setUserId("jungbs3726@naver.com");
        param.setStatus("STUS01"); // 가입 또는 검토중으로 insert 가능

        // 이미 있으면 insert 안함
        if(mapper.getAttendant(param) != null) return;

        assert(mapper.insert(param) == 1);
    }

    @Test
    public void testUpdate() {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(307L);
        param.setUserId("hong2841@service.com");
        param.setStatus("STUS03");

        assert (mapper.update(param) == 1);
        assert ("STUS03".equals(mapper.getAttendant(param).getStatus()));
    }


    @Test
    public void testDelete() {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(366L);
        param.setUserId("jungbs3726@naver.com");
        param.setStatus("STUS03");

        assert (mapper.delete(param) == 1);
    }

    @Test
    public void testCount() {
        assertNotNull(mapper.count(307L));
    }
}
