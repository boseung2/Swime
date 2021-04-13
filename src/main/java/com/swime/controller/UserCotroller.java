package com.swime.controller;

import com.swime.domain.MemberHistoryVO;
import com.swime.domain.MemberVO;
import com.swime.mapper.MemberMapper;
import com.swime.service.MemberService;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/user")
@Log4j
@AllArgsConstructor
public class UserCotroller {


//    @Setter(onMethod_ = @Autowired)
    MemberService service;
//    @Setter(onMethod_ = @Autowired)
    PasswordEncoder passwordEncoder;


    @GetMapping("/login")
    public void login(){
    }

//    @PostMapping("/login")
//    public void login(MemberVO vo){
//        service.checkIdPw(vo);
//    }

    @GetMapping("/register")
    public void register(){
    }

    @PostMapping("/register")
    public String register(@Param("vo") MemberVO vo){
        vo.setPassword(passwordEncoder.encode(vo.getPassword()));
        service.register(vo);
        return "redirect:/user/registerSuccess";
    }

    @GetMapping("/registerSuccess")
    public void regSuccess(@Param("vo") MemberVO vo){

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

    @GetMapping("/auth")
    public ResponseEntity<String> auth(){
//        return service.remove(id, hvo) ?
//                new ResponseEntity<>("Remove Success", HttpStatus.OK) :
//                new ResponseEntity<>("Remove Fail", HttpStatus.BAD_REQUEST);
        return null;
    }




}
