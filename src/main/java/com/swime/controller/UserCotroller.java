package com.swime.controller;

import com.swime.domain.MemberHistoryVO;
import com.swime.domain.MemberVO;
import com.swime.mapper.MemberMapper;
import com.swime.service.MemberService;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user")
@Log4j
@AllArgsConstructor
public class UserCotroller {

    @Getter(onMethod_ = @Autowired)
    MemberService service;

    @GetMapping("/login")
    public void login(){
    }

    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody MemberVO vo){
        return service.checkIdPw(vo) ?
                new ResponseEntity<>("Login Success", HttpStatus.OK) :
                new ResponseEntity<>("Login Denied", HttpStatus.BAD_REQUEST);
    }

    @GetMapping("/register")
    public void register(){
    }

    @PostMapping("/register")
    public ResponseEntity<String> register(@RequestBody MemberVO vo){
        return service.register(vo) ?
                new ResponseEntity<>("Resister Success", HttpStatus.OK) :
                new ResponseEntity<>("Resister Fail", HttpStatus.BAD_REQUEST);
    }

    @GetMapping("/modify")
    public void modify(){
    }

    @PostMapping("/modify")
    public ResponseEntity<String> modify(@RequestBody MemberVO vo,
                                         @RequestBody MemberHistoryVO hvo){
        return service.modify(vo, hvo) ?
                new ResponseEntity<>("modify Success", HttpStatus.OK) :
                new ResponseEntity<>("modify Fail", HttpStatus.BAD_REQUEST);
    }

    @GetMapping("/remove")
    public void remove(){
    }

    @PostMapping("/remove")
    public ResponseEntity<String> remove(@RequestBody String id,
                                         @RequestBody MemberHistoryVO hvo){
        return service.remove(id, hvo) ?
                new ResponseEntity<>("Remove Success", HttpStatus.OK) :
                new ResponseEntity<>("Remove Fail", HttpStatus.BAD_REQUEST);
    }

    @GetMapping("/getlist")
    public List<MemberVO> getlist(){
        return service.getlist();
    }

}
