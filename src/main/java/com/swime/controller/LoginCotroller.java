package com.swime.controller;

import com.swime.domain.MemberVO;
import com.swime.mapper.MemberMapper;
import com.swime.service.MemberService;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/user")
@Log4j
@AllArgsConstructor
public class LoginCotroller {

    @Getter(onMethod_ = @Autowired)
    MemberService service;

    @GetMapping("/login")
    public void login(){
    }

    @PostMapping("/login")
    public ResponseEntity<String> login(MemberVO vo){
        boolean isIdPw = service.checkIdPw(vo);
        return isIdPw ? new ResponseEntity<>("success", HttpStatus.OK) : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
}
