package com.swime.mapper;

import com.swime.domain.ChatAttendVO;
import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyVO;
import com.swime.domain.WishStudyVO;
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
public class ChatRoomMapperTests {

    @Setter(onMethod_ = @Autowired)
    private ChatRoomMapper mapper;

    @Test
    public void testGetRoomList() {
        mapper.getRoomList().forEach(room -> log.info(room));
    }

    @Test
    public void testGetRoomListById() {
        mapper.getRoomListById("wlgh52725@gmail.com").forEach(room -> log.info(room));
    }

    @Test
    public void testInsertAttendant() {
        mapper.insertAttendant("exuuid4", "aaa@naver.com");

        mapper.getRoomListById("aaa@naver.com").forEach(room -> log.info(room));
    }

}
