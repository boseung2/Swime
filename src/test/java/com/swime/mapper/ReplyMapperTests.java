package com.swime.mapper;


import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardVO;
import com.swime.domain.ReplyVO;
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
public class ReplyMapperTests {

    @Setter(onMethod_ = @Autowired)
    private ReplyMapper mapper;

    @Test
    public void testMapper(){
        Assert.assertNotNull(mapper);
        log.info(mapper);
    }

    @Test
    public void testInsert(){

        ReplyVO vo = new ReplyVO();

        int seq = mapper.getSequence();

        vo.setSn(seq);
        vo.setBrdSn(6L);
        vo.setUserId("boseung@naver.com");
        vo.setCommentGroup(seq);
        vo.setContent("11번 문제 조금 어럅네요..");
        vo.setStatus("RPST01");

        mapper.insert(vo);

        log.info(vo);
    }

    @Test
    public void testRead(){

        //Long targetSn = 1L;

        ReplyVO vo = mapper.read(30L);

        log.info(vo);
    }

    @Test
    public void testDelete(){

        Long targetSn = 1L;
        mapper.delete(targetSn);
        //log.info("DELETE COUNT: "+mapper.delete(1L));
    }

    @Test
    public void testUpdate(){

        Long targetSn = 81L;
        ReplyVO vo = mapper.read(targetSn);
        vo.setContent("Update Reply");

        int count = mapper.update(vo);
        log.info("COUNT: " + count);
    }

    @Test
    public void testUpdate2(){

        Long targetSn = 82L;
        ReplyVO vo = mapper.read(targetSn);
        vo.setContent("Update array");
        vo.setStatus("RPST02");

        int count = mapper.update(vo);
        log.info("COUNT: " + count);
    }

    @Test
    public void testPaging(){
        BoardCriteria cri = new BoardCriteria(1,10);
        List<ReplyVO> replies = mapper.getListWithPaging(cri, 1L);
        replies.forEach(reply -> log.info(reply));
    }

    @Test
    public void testPaging2(){
        BoardCriteria cri = new BoardCriteria(1,10);
        List<ReplyVO> replies = mapper.getListWithPaging(cri,1L);
        replies.forEach(reply-> log.info(reply));
    }

    @Test
    public void testGetBoardCnt(){

        int replyCnt = mapper.getCountBySn(1L);

        log.info("replyCnt: " + replyCnt);

    }
}
