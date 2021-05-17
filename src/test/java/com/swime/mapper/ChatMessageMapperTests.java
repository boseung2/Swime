package com.swime.mapper;

import com.swime.domain.ChatMessageVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class ChatMessageMapperTests {

    @Setter(onMethod_ = @Autowired)
    private ChatMessageMapper mapper;

    @Test
    public void testInsertMsg() {
        ChatMessageVO msg = new ChatMessageVO();
        msg.setChatRoomId("exuuidb");
        msg.setSenderId("wlgh52725@gmail.com");
        msg.setReceiverId("fffb@naver.com");
        msg.setContents("반가워요");
        msg.setStatus("MSST02");

        mapper.insertMsg(msg);

        mapper.getMsg("exuuidb").forEach(message -> log.info(message));
    }

    @Test
    public void testGetMsg() {

        mapper.getMsg("exuuidb").forEach(message -> log.info(message));
    }

    @Test
    public void testGetUnreadMsg() {
        mapper.getUnreadMsg("test1@naver.com", "wlgh52725@gmail.com").forEach(msg -> log.info(msg));
    }

    @Test
    public void testReadMsg() {
        assert (mapper.readMsg(62) == 1);
    }
}
