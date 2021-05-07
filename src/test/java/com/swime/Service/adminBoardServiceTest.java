package com.swime.Service;


import com.swime.domain.AdminBoardPageDTO;
import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardVO;
import com.swime.service.BoardService;
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
public class adminBoardServiceTest {

    @Setter(onMethod_ = {@Autowired})
    private BoardService service;

//    @Test
//    public void testAdminGetListWithPagingBySn(){
//        service.adminGetListWithPagingBySn(new BoardCriteria(3,10))
//                .forEach(board -> log.info(board));
//    }
    @Test
    public void testAdminGetListWithPagingBySn(){
        BoardCriteria cri = new BoardCriteria();
        cri.setPageNum(2);
        cri.setAmount(10);

        log.info(service.adminGetListWithPagingBySn(cri));

    }

}
