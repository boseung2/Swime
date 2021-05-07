package com.swime.Service;

import com.swime.domain.*;
import com.swime.service.StudyService;
import com.swime.service.WishStudyService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class WishStudyServiceTests {
    @Setter(onMethod_ = @Autowired)
    private WishStudyService service;

    // WishStudy
    @Test
    public void testGetWishList() {
        StudyCriteria cri = new StudyCriteria(1, 3);

        List<StudyVO> list = service.getWishList(cri, "asdf@naver.com");

        assert (0 <= list.size() && list.size() <= 3);
    }

    @Test
    public void testGetWish() {

        WishStudyVO wishParam = new WishStudyVO();
        wishParam.setStdSn(82L);
        wishParam.setUserId("aaa@naver.com");

        WishStudyVO wish = service.getWish(wishParam);

        assert (wish != null && wish.getStdSn() == 82L && "aaa@naver.com".equals(wish.getUserId()));
    }

    @Test
    public void testRegisterWish() {
        WishStudyVO wish = new WishStudyVO();
        wish.setStdSn(82L);
        wish.setUserId("aaa@naver.com");

        if(service.getWish(wish) != null) return;

        assert (service.registerWish(wish) == 1);
        assert (service.getWish(wish) != null);
    }

    @Test
    public void testRemoveWish() {
        WishStudyVO wish = new WishStudyVO();
        wish.setStdSn(368L);
        wish.setUserId("jiho@naver.com");
        service.registerWish(wish);

        WishStudyVO wishParam = new WishStudyVO();
        wishParam.setStdSn(368L);
        wishParam.setUserId("jiho@naver.com");

        assert (service.removeWish(wishParam) == 1);
        assert (service.getWish(wishParam) == null);
    }
}
