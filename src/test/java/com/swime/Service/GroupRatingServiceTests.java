package com.swime.Service;

import com.swime.domain.GroupCriteria;
import com.swime.domain.GroupRatingVO;
import com.swime.service.GroupRatingService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class GroupRatingServiceTests {

    @Setter(onMethod_ = {@Autowired})
    private GroupRatingService service;

    @Test
    public void testExist() {
        log.info(service);
        assertNotNull(service);
    }

    @Test
    public void testRegister() {
        GroupRatingVO groupRating = new GroupRatingVO();
        groupRating.setGrpSn(440L);
        groupRating.setStdSn(1L);
        groupRating.setUserId("jungbs3726@naver.com");
        groupRating.setRating(1D);
        groupRating.setReview("만족스러운 스터디였습니다.");
        service.register(groupRating);
    }

    @Test
    public void testGetListWithPaging() {
        GroupCriteria cri = new GroupCriteria(1, 3);
        service.getListWithPaging(101L, cri);
    }

    @Test
    public void testUpdate() {
        GroupRatingVO groupRating = service.get(71L);
        groupRating.setRating(5.0D);
        groupRating.setReview("수정된 리뷰입니당");
        service.modify(groupRating);
    }

    @Test
    public void testDelete() {
        service.delete(22L);
    }

}
