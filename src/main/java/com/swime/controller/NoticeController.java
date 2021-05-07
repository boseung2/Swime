package com.swime.controller;

import com.swime.domain.MemberVO;
import com.swime.domain.NoticeVO;
import com.swime.service.NoticeService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.lang.reflect.Member;

@Controller
@RequestMapping("/notice")
@Log4j
@AllArgsConstructor
public class NoticeController {

    private NoticeService service;

    @PostMapping(value= "/register", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> register(@RequestBody NoticeVO notice) {

        service.register(notice);
        return new ResponseEntity<>("success", HttpStatus.OK);
    }

}
