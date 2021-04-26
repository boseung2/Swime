package com.swime.controller;

import com.swime.domain.ProfileCriteria;
import com.swime.domain.ProfileCriteriaList;
import com.swime.domain.Sample;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/sample/*")
@Log4j
public class SampleController {

    @RequestMapping("")
    public void basic() {
        log.info("basic......");
    }

    @RequestMapping(value = "/basic", method = {RequestMethod.GET, RequestMethod.POST})
    public void basicGet() {
        log.info("basic get.......");
    }

    @GetMapping("/basicOnlyGet")
    public void basicGet2() {
        log.info("basic get only get...........");
    }

    @GetMapping("/member")
    public void test(){
    }

    @GetMapping("/testcroll")
    public void test1(){
    }

    @GetMapping("/star")
    public void test2(){
    }

    @GetMapping("/test3")
    public void test3(String id, ProfileCriteriaList list){
        log.info(id.equals("tht1234551@gmail.com"));
        log.info(list == null);
        log.info(list.getList().get(1));
        list.getList().forEach(log::info);
    }

    @GetMapping("/test4")
    public void test4(String id, @RequestParam("a") int[] a, @RequestParam("b") int[] b){
        log.info("test4...");


    }

}
