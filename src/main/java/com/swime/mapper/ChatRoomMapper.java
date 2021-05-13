package com.swime.mapper;

import com.swime.domain.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ChatRoomMapper {

    public List<ChatRoomVO> getRoomList();

    public List<ChatRoomVO> getRoomsOfUser(String userId);

    public List<ChatMessageVO> getRoomListById(String userId);

    public void insertRoom(String id);

    public void insertAttendant(@Param("id") String id, @Param("userId") String userId);

    public ChatAttendVO getOldChatRoom(@Param("me") String me, @Param("you") String you);
}
