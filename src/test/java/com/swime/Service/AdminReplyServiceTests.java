package com.swime.Service;

import com.swime.domain.ReplyCriteria;
import com.swime.domain.ReplyPageDTO;
import com.swime.domain.ReplyVO;
import com.swime.mapper.ReplyMapper;
import com.swime.service.ReplyService;
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
public class AdminReplyServiceTests {

    @Setter(onMethod_ = {@Autowired})
    private ReplyService service;

    @Setter(onMethod_ = {@Autowired})
    private ReplyMapper mapper;


    @Test
    public void testAdminGetWithPagingBySn(){

        ReplyCriteria cri = new ReplyCriteria();
        cri.setPageNum(1);
        cri.setAmount(10);

        int replyCnt = mapper.getCountBySn();

        ReplyPageDTO list = service.adminGetListWIthPagingBySn(cri);

        log.info(replyCnt);
        log.info(list);
    }
}
