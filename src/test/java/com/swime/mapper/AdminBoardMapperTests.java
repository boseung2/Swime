package com.swime.mapper;


import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardVO;
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
public class AdminBoardMapperTests {

    @Setter(onMethod_ = @Autowired)
    private BoardMapper mapper;

//    @Test
//    public void testAdminGetListWithPagingBySn(){
//        BoardCriteria cri = new BoardCriteria();
//        List<BoardVO> list = mapper.adminGetListWithPagingBySn(cri);
//        list.forEach(board->log.info(board));
//    }
    @Test
    public void testAdminGetListWithPagingBySn2(){
        BoardCriteria cri = new BoardCriteria();
        cri.setPageNum(2);
        cri.setAmount(10);
        List<BoardVO> list = mapper.adminGetListWithPagingBySn(cri);

        list.forEach(board-> log.info(board));
    }
    @Test
    public void testAdminGEtCountBySn(){
        log.info(mapper.adminGetCountBySn());
    }



}
