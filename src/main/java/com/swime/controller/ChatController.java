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

            for(int i = 0; i < roomList.size(); i++) {

                String senderId = "";

                if(!principal.getName().equals(roomList.get(i).getSenderId())) {
                    senderId = roomList.get(i).getSenderId();
                }else {
                    senderId = roomList.get(i).getReceiverId();
                }

                // 안읽은 메시지를 저장한다.
                roomList.get(i).setUnreadMsg(chatMessageService.getUnreadMsg(senderId, principal.getName()).size());
            }

            model.addAttribute("rooms", roomList);
        }

    }

    @GetMapping(value = "/ajaxList", produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<List<ChatMessageVO>> ajaxList(String userId) {

        log.info("ajaxList 받은 userId = " + userId);

        // 회원이 속한 채팅방 리스트를 최근에 메시지를 주고받았던 순으로 뿌려준다.

        List<ChatMessageVO> roomList = chatRoomService.getRoomListById(userId);

        for(int i = 0; i < roomList.size(); i++) {

            String senderId = "";

            if(!userId.equals(roomList.get(i).getSenderId())) {
                senderId = roomList.get(i).getSenderId();
            }else {
                senderId = roomList.get(i).getReceiverId();
            }

            // 안읽은 메시지를 저장한다.
            roomList.get(i).setUnreadMsg(chatMessageService.getUnreadMsg(senderId, userId).size());
        }


        return new ResponseEntity<>(roomList, HttpStatus.OK);
    }

    @PreAuthorize("isAuthenticated()")
    @GetMapping("/register")
    public String register(String userId, Principal principal, Model model) {

        // 현재 로그인 중이면
        if(principal != null && !userId.equals(principal.getName())) {
            // 채팅을 보내고자하는 멤버의 정보를 페이지로 보내준다.
            model.addAttribute("member", memberService.get(userId));

            // 해당 멤버가 없으면 에러페이지로 이동
            if(memberService.get(userId) == null) {
                throw new RuntimeException();
            }

            // 이전에 나눈 채팅이 있는지 확인
            ChatAttendVO oldChatRoom = chatRoomService.getOldChatRoom(principal.getName(), userId);

            if(oldChatRoom != null) { // 이전 채팅이 있으면 그 채팅방으로 이동
                return "redirect:/chat/room/" + oldChatRoom.getChatRoomId();
            }

            // 현재 로그인중인 유저의 채팅방 리스트를 불러오기
            List<ChatMessageVO> roomList = chatRoomService.getRoomListById(principal.getName());

            for(int i = 0; i < roomList.size(); i++) {

                String senderId = "";

                if(!userId.equals(roomList.get(i).getSenderId())) {
                    senderId = roomList.get(i).getSenderId();
                }else {
                    senderId = roomList.get(i).getReceiverId();
                }

                // 안읽은 메시지를 저장한다.
                roomList.get(i).setUnreadMsg(chatMessageService.getUnreadMsg(senderId, userId).size());
            }

            model.addAttribute("rooms", roomList);
        }

        return "/chat/register";
    }


    @PreAuthorize("isAuthenticated()")
    @PostMapping(value = "/register", consumes = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<String> registerChatRoom (@RequestBody ChatMessageVO msg) {

        log.info("register contents = " + msg.getContents());
        log.info("register senderId = " + msg.getSenderId());
        log.info("register receiverId = " + msg.getReceiverId());

        // 사용자가 처음으로 메시지를 보낼때 채팅방을 생성해주고 메시지를 저장한다.
        ChatMessageVO chat = new ChatMessageVO();
        String chatRoomId = UUID.randomUUID().toString();
        chat.setChatRoomId(chatRoomId);
        chat.setContents(msg.getContents());
        chat.setSenderId(msg.getSenderId());
        chat.setReceiverId(msg.getReceiverId());
        chat.setStatus("MSST02");

        chatRoomService.registerRoom(chat);

        return new ResponseEntity<>(chatRoomId, HttpStatus.OK);
    }


    @PreAuthorize("isAuthenticated()")
    @GetMapping("/room/{id}")
    public String room(@PathVariable String id, Principal principal, Model model) {

        // 상대방의 id
        ChatAttendVO you = chatRoomService.getYourId(id, principal.getName());
        String yourId = you.getAttendId();

        // 해당 채팅방의 안읽은 메시지를 가져오기
        List<ChatMessageVO> unreadMsg = chatMessageService.getUnreadMsg(yourId, principal.getName());

        // 모두 읽음처리
        for(int i = 0; i < unreadMsg.size(); i++) {
            chatMessageService.readMsg(unreadMsg.get(i).getSn());
        }

        model.addAttribute("chatRoomId", id);

        // 상대방의 정보를 보내주기
        model.addAttribute("you", memberService.get(yourId));

        // 내 정보도 보내주기
        model.addAttribute("me", memberService.get(principal.getName()));

        // 해당 유저의 채팅방 리스트를 보내주기
        List<ChatMessageVO> roomList = chatRoomService.getRoomListById(principal.getName());

        for(int i = 0; i < roomList.size(); i++) {

            String senderId = "";

            if(!principal.getName().equals(roomList.get(i).getSenderId())) {
                senderId = roomList.get(i).getSenderId();
            }else {
                senderId = roomList.get(i).getReceiverId();
            }

            // 안읽은 메시지를 저장한다.
            roomList.get(i).setUnreadMsg(chatMessageService.getUnreadMsg(senderId, principal.getName()).size());
        }
        model.addAttribute("rooms", roomList);

        // 해당 채팅방의 메시지를 보내주기
        model.addAttribute("messages", chatMessageService.getMsg(id));

        return "/chat/room";
    }

    @GetMapping(value = "/getMsg", produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<List<ChatMessageVO>> getMsg(String chatRoomId) {

        return new ResponseEntity<>(chatMessageService.getMsg(chatRoomId), HttpStatus.OK);
    }

    @GetMapping(value = "/totalUnreadMsg")
    public ResponseEntity<String> getTotalUnreadMsg(String userId) {

        return new ResponseEntity<>(String.valueOf(chatMessageService.getTotalUnreadMsg(userId).getUnreadMsg()), HttpStatus.OK);
    }
}