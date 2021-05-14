package com.swime.controller;


import com.swime.domain.ChatAttendVO;
import com.swime.domain.ChatMessageVO;
import com.swime.domain.ChatRoomVO;
import com.swime.service.ChatMessageService;
import com.swime.service.ChatRoomService;
import com.swime.service.MemberService;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
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

    @Setter(onMethod_ = {@Autowired})
    private ChatMessageService chatMessageService;

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

    @GetMapping(value = "/ajaxList", produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<List<ChatMessageVO>> ajaxList(String userId) {

        log.info("ajaxList 받은 userId = " + userId);

        // 회원이 속한 채팅방 리스트를 최근에 메시지를 주고받았던 순으로 뿌려준다.
        return new ResponseEntity<>(chatRoomService.getRoomListById(userId), HttpStatus.OK);
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

            if(oldChatRoom != null) { // 이전 채팅이 있으면 그 채팅방으로 이동
                return "redirect:/chat/room/" + oldChatRoom.getChatRoomId();
            }

            // 현재 로그인중인 유저의 채팅방 리스트를 불러오기
            log.info("현재 접속중인 유저 = " + principal.getName());
            List<ChatMessageVO> roomList = chatRoomService.getRoomListById(principal.getName());

            model.addAttribute("rooms", roomList);
        }

        return "/chat/register";
    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping(value = "/register")
    public String registerChatRoom (String contents, String senderId, String receiverId) {

        log.info("register contents = " + contents);
        log.info("register senderId = " + senderId);
        log.info("register receiverId = " + receiverId);

        ChatMessageVO chat = new ChatMessageVO();
        String chatRoomId = UUID.randomUUID().toString();
        chat.setChatRoomId(chatRoomId);
        chat.setContents(contents);
        chat.setSenderId(senderId);
        chat.setReceiverId(receiverId);
        chat.setStatus("MSST02");

        chatRoomService.registerRoom(chat);

        return "redirect:/chat/room/" + chatRoomId;
    }


    @PreAuthorize("isAuthenticated()")
    @GetMapping("/room/{id}")
    public String room(@PathVariable String id, Principal principal, Model model) {

        model.addAttribute("chatRoomId", id);

        // 상대방의 정보를 보내주기
        String yourId = chatRoomService.getYourId(id, principal.getName()).getAttendId();
        model.addAttribute("you", memberService.get(yourId));

        // 내 정보도 보내주기
        model.addAttribute("me", memberService.get(principal.getName()));

        // 해당 유저의 채팅방 리스트를 보내주기
        model.addAttribute("rooms", chatRoomService.getRoomListById(principal.getName()));

        // 해당 채팅방의 메시지를 보내주기
        model.addAttribute("messages", chatMessageService.getMsg(id));

        return "/chat/room";
    }
}