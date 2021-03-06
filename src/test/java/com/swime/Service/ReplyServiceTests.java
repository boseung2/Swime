package com.swime.Service;

import com.swime.domain.BoardCriteria;
import com.swime.domain.ReplyVO;
import com.swime.service.BoardService;
import com.swime.service.ReplyService;
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
public class ReplyServiceTests {

    @Setter(onMethod_ = {@Autowired})
    private ReplyService service;

    @Test
    public void testExist(){
        log.info(service);
        assertNotNull(service);
    }

    @Test
    public void testRegisterParent(){

        ReplyVO reply = new ReplyVO();

        reply.setBrdSn(415L);
        reply.setUserId("toywar94@gmail.com");
        reply.setContent("replyTest22222");
        reply.setStatus("RPST01");

        service.register(reply);
    }

    @Test
    public void testRegisterChild(){

        ReplyVO reply = new ReplyVO();

        reply.setBrdSn(62L);
        reply.setUserId("qwer9827@naver.com");
        reply.setCommentGroup(63);
        reply.setContent("자식4");
        reply.setStatus("RPST01");

        service.register(reply);

    }

    @Test
    public void testUpdate(){
        ReplyVO reply = new ReplyVO();

        reply.setSn(47);
        //reply.setBrdSn(4L);
        //reply.setUserId("toywar1@naver.com");
        reply.setContent("부모 댓글/////");
        reply.setStatus("RPST02");

        service.modify(reply);

    }

    @Test
    public void testGet(){
        log.info(service.get(1L));

    }

    @Test
    public void testDelete(){
        service.remove(653L);

    }

    @Test
    public void testGetListPaging(){
        BoardCriteria cri = new BoardCriteria();
        service.getListPage(cri, 1L);
    }



}
