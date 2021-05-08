package com.swime.controller;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/*")
@Log4j
@AllArgsConstructor
public class MainController {

    @GetMapping("/mainBody")
    public void body(){

    }
}
