package com.swime.controller;

import com.swime.service.AdminDashBoardService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/adminData")
@Log4j
@AllArgsConstructor
public class AdminDataController {

    AdminDashBoardService service;

    @GetMapping("/countUser")
    public ResponseEntity<Integer> countUser(){
        return new ResponseEntity<>(service.countTodayUserRegister(), HttpStatus.OK);
    }

    @GetMapping("/countGroup")
    public ResponseEntity<Integer> countGroup(){
        return new ResponseEntity<>(service.countTodayGroupRegister(), HttpStatus.OK);
    }

    @GetMapping("/countStudy")
    public ResponseEntity<Integer> countStudy(){
        return new ResponseEntity<>(service.countTodayStudyRegister(), HttpStatus.OK);
    }

    @GetMapping("/countUserForMonth")
    public ResponseEntity<Integer[]> countUserForMonth(int year, int month){
        return new ResponseEntity<>(service.countUserRegisterByParam(year, month), HttpStatus.OK);
    }
}
