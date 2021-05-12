package com.swime.controller;


import com.swime.domain.ChatMessageVO;
import com.swime.service.ChatRoomService;
import com.swime.service.MemberService;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/chat")
public class ChatController {

    @Setter(onMethod_ = {@Autowired})
    MemberService memberService;

    private ChatRoomService chatRoomService;

    @GetMapping("/list")
    public void list() {
        // 회원이 속한 채팅방 리스트를 최근에 메시지를 주고받았던 순으로 뿌려준다.

        // 리스트를에 채팅방 id를 걸어놔서 클릭하면 chat/{id}로 이동
    }

    @GetMapping("/register")
    public void register(String userId, Model model) {

        model.addAttribute("member", memberService.get(userId));

    }

    @PostMapping(value = "/register", consumes = MediaType.APPLICATION_JSON_VALUE)
    public String registerChatRoom (@RequestBody ChatMessageVO msg) {

        String id = UUID.randomUUID().toString();
        chatRoomService.registerRoom(id, msg);

        return "redirect:/chat/room/" + id;
    }


    @GetMapping("/room/{id}")
    public void room(@PathVariable String id) {

        // js - 웹소켓을 연결한다.

        // 웹소켓 - 전역변수로 chatRoom map을 가진다. (id : ChatRoomVO)
        
        // 웹소켓이 연결되면 map에 존재하지않는 채팅방을 저장한다.

        // js - 웹소켓에 연결/종료/메시지전송에 따라 ENTER/LEAVE/CHAT 타입을 담고,
        // 송신자와 채팅방아이디를 담아 웹소켓으로 메시지를 보낸다.

        // 웹소켓 - 받은 메시지에서 id 통해 Map에서 가져온 ChatRoomVO의 sessionList에 해당 송신자가 없으면 등록한다.

        // js - 해당 id를 가진 채팅방의 메시지들을 가져와서 발신자를 구별하여 화면에 뿌려준다.
        
        // js - 메시지가 오면 html에 추가해준다.
    }
}