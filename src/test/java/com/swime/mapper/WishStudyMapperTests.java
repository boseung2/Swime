package com.swime.mapper;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyParamVO;
import com.swime.domain.StudyVO;
import com.swime.domain.WishStudyVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Assert;
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
        StudyCriteria cri = new StudyCriteria(1, 3);

        List<StudyVO> list = mapper.getList(cri, "jiho@naver.com"); // 사용자가 찜한 스터디 리스트

        assert(0 <= list.size() && list.size() <= 3);
    }

    @Test
    public void testInsert() {
        WishStudyVO wish = new WishStudyVO();

        long stdSn = 368L;
        String userId = "jiho@naver.com";

        wish.setStdSn(stdSn);
        wish.setUserId(userId);

        StudyParamVO param = new StudyParamVO();
        param.setStdSn(stdSn);
        param.setUserId(userId);

        // 이미 명단에 있으면 리턴
        if(mapper.get(param) != null) return;

        assert (mapper.insert(wish) == 1);
    }

    @Test
    public void testGet() { // 사용자가 해당 스터디를 찜했는지 안했는지 확인
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(368L);
        param.setUserId("jiho@naver.com");

        WishStudyVO wish = mapper.get(param);

        Assert.assertNotNull(wish);
    }


    @Test
    public void testDelete() {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(368L);
        param.setUserId("jiho@naver.com");

        assert (mapper.delete(param) == 1);
        assert (mapper.get(param) == null);
    }
}
