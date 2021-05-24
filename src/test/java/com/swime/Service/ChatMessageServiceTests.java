package com.swime.Service;

import com.swime.domain.ChatMessageVO;
import com.swime.service.ChatMessageService;
import com.swime.service.ChatRoomService;
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
public class ChatMessageServiceTests {
    @Setter(onMethod_ = @Autowired)
    private ChatMessageService service;

    @Test
    public void testInsertMsg() {
        ChatMessageVO msg = new ChatMessageVO();
        msg.setChatRoomId("exuuidc");
        msg.setSenderId("wlgh52725@gmail.com");
        msg.setReceiverId("fffc@naver.com");
        msg.setContents("반가워요");
        msg.setStatus("MSST02");

        service.registerMsg(msg);

        service.getMsg("exuuidc").forEach(message -> log.info(message));
    }

    @Test
    public void testGetMsg() {

        service.getMsg("exuuidc").forEach(message -> log.info(message));
    }

    @Test
    public void testGetUnreadMsg() {
        service.getUnreadMsg("test1@naver.com", "wlgh52725@gmail.com").forEach(msg -> log.info(msg));
    }

    @Test
    public void testReadMsg() {
        String result = "";

        try {
            service.readMsg(64);
            result = "success";
        }catch (Exception e) {
            result = "fail";
        }

        assert ("success".equals(result));
    }

    @Test
    public void testGetTotalUnreadMsg() {
        log.info(service.getTotalUnreadMsg("wlgh52725@gmail.com").getUnreadMsg());
    }
}
