package com.swime.Service;

import com.swime.domain.ChatMessageVO;
import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyVO;
import com.swime.domain.WishStudyVO;
import com.swime.service.ChatRoomService;
import com.swime.service.WishStudyService;
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
public class ChatRoomServiceTests {
    @Setter(onMethod_ = @Autowired)
    private ChatRoomService service;

    @Test
    public void testGetRoomList() {
        service.getRoomList().forEach(room -> log.info(room));
    }

    @Test
    public void testGetRoomOfUsers() {
        service.getRoomsOfUser("wlgh52725#gmail.com").forEach(room -> log.info(room));
    }

    @Test
    public void testGetRoomListById() {
        service.getRoomListById("wlgh52725@gmail.com").forEach(room -> log.info(room));
    }

    @Test
    public void testRegisterRoom() {

        ChatMessageVO msg = new ChatMessageVO();
        msg.setChatRoomId("exuuid6");
        msg.setSenderId("wlgh52725@gmail.com");
        msg.setReceiverId("fff@naver.com");
        msg.setContents("반가워요");
        msg.setStatus("MSST02");

        try {
            service.registerRoom(msg);

        }catch (Exception e) {
            e.printStackTrace();
        }

        service.getRoomList().forEach(room -> log.info(room));
        service.getRoomListById("wlgh52725@gmail.com").forEach(room -> log.info(room));
        service.getRoomListById("fff@naver.com").forEach(room -> log.info(room));

    }

    @Test
    public void testGetYourId() {
        log.info(
                service.getYourId("f976e775-4669-4588-abd6-1167aaba17ca", "wlgh52725@gmail.com").getAttendId()
        );

    }
}
