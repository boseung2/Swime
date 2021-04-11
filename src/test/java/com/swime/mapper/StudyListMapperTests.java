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
        List<StudyListVO> list = mapper.getList(307L);

        for(StudyListVO li : list) {
            assert (li.getStdSn() == 307L);
            assert ("STUS01".equals(li.getStatus()));
        }
    }

    @Test
    public void testGetListWithPaging() {
        StudyCriteria cri = new StudyCriteria(1, 3, 307L);

        List<StudyListVO> list = mapper.getListWithPaging(cri);

        assert(0 <= list.size() && list.size() <= 3);
        for(StudyListVO li : list) {
            assert (li.getStdSn() == 307L);
            assert ("STUS01".equals(li.getStatus()));
        }
    }

    @Test
    public void testGetWaitingList() {
        List<StudyListVO> list = mapper.getWaitingList(308L);

        for(StudyListVO li : list) {
            assert (li.getStdSn() == 308L);
            assert ("STUS03".equals(li.getStatus()));
        }
    }

    @Test
    public void testGetWaitingListWithPaging() {
        StudyCriteria cri = new StudyCriteria(1, 3, 308L);

        List<StudyListVO> list = mapper.getWaitingListWithPaging(cri);

        assert(0 <= list.size() && list.size() <= 3);
        for(StudyListVO li : list) {
            assert (li.getStdSn() == 308L);
            assert ("STUS03".equals(li.getStatus()));
        }
    }

    @Test
    public void testGetAttendant() {
        assertNotNull(mapper.getAttendant(307L, "hong2841@service.com"));
    }

    @Test
    public void testInsert() {
        StudyListVO list = new StudyListVO();
        list.setStdSn(308L);
        list.setUserId("jungbs3726@naver.com");
        list.setStatus("STUS01"); // 가입 또는 검토중으로 insert 가능

        // 이미 있으면 insert 안함
        if(mapper.getAttendant(308L, "jungbs3726@naver.com") != null) return;

        assert(mapper.insert(list) == 1);
        log.info("insert");
    }

    @Test
    public void testUpdate() {
        assert (mapper.update(307L, "hong2841@service.com", "STUS03") == 1);
        assert ("STUS03".equals(mapper.getAttendant(307L, "hong2841@service.com").getStatus()));
    }

    @Test
    public void testCount() {
        assertNotNull(mapper.count(307L));
    }
}
