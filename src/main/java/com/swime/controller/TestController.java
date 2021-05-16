package com.swime.controller;

import com.swime.service.AdminDashBoardService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/test")
@Controller
@Log4j
@AllArgsConstructor
public class TestController {

    AdminDashBoardService service;

    @GetMapping("/test1")
    public void test() {
        log.info(service.test2());
        log.info("test ing....");
    }

    @GetMapping("/test2")
    public void test2() {
        log.info(service.test2());
        log.info("test ing....");
    }
}
