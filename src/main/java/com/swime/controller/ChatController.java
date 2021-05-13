package com.swime.controller;


import com.swime.domain.ChatAttendVO;
import com.swime.domain.ChatMessageVO;
import com.swime.domain.ChatRoomVO;
import com.swime.service.ChatRoomService;
import com.swime.service.MemberService;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.security.Principal;
import java.util.List;
import java.util.UUID;

@Controller
@Log4j
@AllArgsConstructor
@RequestMapping("/chat")
public class ChatController {

    @Setter(onMethod_ = {@Autowired})
    private MemberService memberService;

    @Setter(onMethod_ = {@Autowired})
    private ChatRoomService chatRoomService;

    @PreAuthorize("isAuthenticated()")
    @GetMapping("/list")
    public void list(Principal principal, Model model) {
        // 회원이 속한 채팅방 리스트를 최근에 메시지를 주고받았던 순으로 뿌려준다.
        if(principal != null) {
            List<ChatMessageVO> roomList = chatRoomService.getRoomListById(principal.getName());

            model.addAttribute("rooms", roomList);
        }

        // 리스트를에 채팅방 id를 걸어놔서 클릭하면 chat/{id}로 이동
    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping("/register")
    public String register(String userId, Principal principal, Model model) {

        // 현재 로그인 중이면
        if(principal != null && !userId.equals(principal.getName())) {
            // 채팅을 보내고자하는 멤버의 정보를 페이지로 보내준다.
            model.addAttribute("member", memberService.get(userId));

            // 이전에 나눈 채팅이 있는지 확인
            ChatAttendVO oldChatRoom = chatRoomService.getOldChatRoom(principal.getName(), userId);

            log.info("principal.getName() = " + principal.getName());
            log.info("userId = " + userId);
            log.info("이전에 나눈 채팅방 = " + oldChatRoom);

            if(oldChatRoom != null) { // 이전 채팅이 있으면
                return "redirect:/chat/room/" + oldChatRoom;
            }

            // 현재 로그인중인 유저의 이전 채팅방을 불러오기
            log.info("현재 접속중인 유저 = " + principal.getName());
            List<ChatMessageVO> roomList = chatRoomService.getRoomListById(principal.getName());

            model.addAttribute("rooms", roomList);
        }

        return "/chat/register";
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping(value = "/register", consumes = MediaType.APPLICATION_JSON_VALUE)
    public String registerChatRoom (@RequestBody ChatMessageVO msg) {

        String id = UUID.randomUUID().toString();
        chatRoomService.registerRoom(id, msg);

        return "redirect:/chat/room/" + id;
    }


    @PreAuthorize("isAuthenticated()")
    @GetMapping("/room/{id}")
    public String room(@PathVariable String id, Model model) {

        model.addAttribute("chatRoomId", id);
        return "/chat/room";
    }
}