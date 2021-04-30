package com.swime.controller;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/notice/*")
@Log4j
@AllArgsConstructor
public class NoticeController {

    @GetMapping("/list")
    public void noticeList(){

    }

}
