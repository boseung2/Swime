package com.swime.controller;

import com.swime.domain.MailVO;
import com.swime.domain.MemberHistoryVO;
import com.swime.domain.MemberVO;
import com.swime.mapper.MemberMapper;
import com.swime.service.AuthService;
import com.swime.service.MemberService;
import com.swime.util.GmailSend;
import com.swime.util.MakeRandomValue;
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
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Date;
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

    AuthService authService;

    GmailSend gmailSend;

    MakeRandomValue makeRandomValue;

    @GetMapping("/login")
    public void login(){
    }

    @GetMapping("/register")
    public void register(){
    }

    @Transactional
    @PostMapping("/register")
    public String register(MemberVO vo, RedirectAttributes rttr){
        vo.setPassword(passwordEncoder.encode(vo.getPassword()));
        service.registerHistory(vo);
        service.register(vo);
        String key = makeRandomValue.MakeAuthKey();
        service.registerKey(vo.getId(), key);
        authService.register(vo.getId(),"MEMBER");
        gmailSend.sendAuthMail(new MailVO(vo.getId(), key));
        rttr.addFlashAttribute("vo", vo);
        return "redirect:/user/registerSuccess";
    }

    @GetMapping("/registerSuccess")
    public void regSuccess(MemberVO vo){}

    @GetMapping("/modify")
    public void modify(){
    }

    @PostMapping("/modify")
    public ResponseEntity modify(MemberVO vo, MemberHistoryVO hvo){//, MemberHistoryVO hvo
        log.info("test_Modify = " + vo.getPassword());
        service.modify(vo, hvo);
        return service.modify(vo, hvo) ? new ResponseEntity(HttpStatus.OK) : new ResponseEntity(HttpStatus.BAD_REQUEST);
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

    @Transactional
    @GetMapping("/auth")
    public String auth(String key, String id){
        // 키를 조회하고
        if(!service.isKey(id, key)) return null;
        // 키를 삭제
        service.deleteKey(id);
        // 멤버 이력을 수정하고
//        service.registerHistory(vo);
        // 멤버 항목중 인증날짜를 수정한다
        service.updateAuthdate(id);
        return "redirect:/user/AuthSuccess";
    }

    @GetMapping("/AuthSuccess")
    public void emailAuth(){
    }

    @GetMapping("/info")
    public void infotest(){
    }

    @GetMapping("/infoDetail")
    public void infoDetail(Model model, String id){
        model.addAttribute("MemberVo", service.get(id));
    }

    @GetMapping("/details/group")
    public void group(){
    }

    @GetMapping("/details/study")
    public void study(){
    }

    @GetMapping("/details/written")
    public void written(){
    }

    @GetMapping("/details/reply")
    public void reply(){
    }

    @GetMapping("/details/profile")
    public void profile(Model model, String id){
        model.addAttribute("MemberVo", service.get(id));
    }


    String dateFormat(Date date){

        return null;
    }



}
