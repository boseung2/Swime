package com.swime.mapper;


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

        vo.setBrdSn(2L);
        vo.setUserId("toywar94@naver.com");
        //vo.setUserName("이민재");
        vo.setContent("AOP 설명 해주세요");
        vo.setStatus("RPST01");

        mapper.insert(vo);

        log.info(vo);
    }

    @Test
    public void testRead(){

        //Long targetSn = 1L;

        ReplyVO vo = mapper.read(1L);

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

        Long targetSn = 2L;
        ReplyVO vo = mapper.read(targetSn);
        vo.setContent("Update Reply");

        int count = mapper.update(vo);
        log.info("COUNT: " + count);
    }

    @Test
    public void testUpdate2(){

        Long targetSn = 3L;
        ReplyVO vo = mapper.read(targetSn);
        vo.setContent("Update array");
        vo.setStatus("RPST02");

        int count = mapper.update(vo);
        log.info("COUNT: " + count);
    }

    @Test
    public void testGetBoardCnt(){

        int replyCnt = mapper.getReplyCnt(1L);

        log.info("replyCnt: " + replyCnt);

    }
}
