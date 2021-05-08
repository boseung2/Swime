package com.swime.mapper;

import com.swime.domain.ReplyCriteria;
import com.swime.domain.ReplyVO;
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
public class AdminReplyMapperTests {

    @Setter(onMethod_ = @Autowired)
    private ReplyMapper mapper;

    @Test
    public void testAdminGetListWithPagingBySn(){

        ReplyCriteria cri = new ReplyCriteria();
        cri.setAmount(10);
        cri.setPageNum(1);

        List<ReplyVO> list = mapper.adminGetListWithPagingBySn(cri);

        list.forEach(reply -> log.info(list));

    }
}
