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

import javax.print.attribute.standard.Media;
import java.lang.reflect.Member;
import java.util.ArrayList;
import java.util.List;

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

    @GetMapping(value="/list/{userId}", produces = {MediaType.APPLICATION_JSON_VALUE})
    @ResponseBody
    public ResponseEntity<List<NoticeVO>> getList(@PathVariable String userId) {
        return new ResponseEntity<>(service.getList(userId), HttpStatus.OK);
    }

    @PostMapping(value="/modify", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> modify(@RequestBody NoticeVO notice) {
        service.modify(notice.getSn());
        return new ResponseEntity<>("success", HttpStatus.OK);
    }

}