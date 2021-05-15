package com.swime.controller;

import com.swime.domain.*;
import com.swime.mapper.GroupTagMapper;
import com.swime.service.AuthService;
import com.swime.service.MemberService;
import com.swime.service.ProfileService;
import com.swime.util.GmailSend;
import com.swime.util.HttpRequest;
import com.swime.util.MakeRandomValue;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.kohsuke.github.GHPerson;
import org.springframework.http.*;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.util.*;

@Controller
@RequestMapping("/user")
@Log4j
@AllArgsConstructor
//@CrossOrigin("*")
public class UserController {

    MemberService service;
    PasswordEncoder passwordEncoder;
    AuthService authService;
    GmailSend gmailSend;
    MakeRandomValue makeRandomValue;
    ProfileService profileService;
    GroupTagMapper groupTagMapper;


    @GetMapping("/already")
    public ResponseEntity<Boolean> isAlready(String id){
        return service.get(id) != null ?
                new ResponseEntity<>(true, HttpStatus.OK) :
                new ResponseEntity<>(false, HttpStatus.OK);
    }

    @GetMapping("/login")
    public void login(){
    }

    @GetMapping("/login/github")
    public void github(String code, Model model) throws Exception{
        if(code == null) return;

        log.info("code = " + code);
        HttpRequest httpRequest = new HttpRequest();
        String ac = httpRequest.getGithubAccessCode(code);
        log.info(ac);
        GHPerson ghPerson = httpRequest.connectGithub(ac);
        log.info(ghPerson);
        model.addAttribute("ghPerson", ghPerson);
    }

    @GetMapping("/register")
    public void register(){
    }

    @Transactional
    @PostMapping("/registerSocial")
    public ResponseEntity<String> registerSocial(MemberVO vo, RedirectAttributes rttr){
        log.info(vo);
        boolean result = false;
        boolean result1 = false;
        boolean result3 = false;
        vo.setPassword(passwordEncoder.encode(vo.getPassword()));
        result = service.registerHistory(vo);
        result1 = service.register(vo);
        result3 = authService.register(vo.getId(),"MEMBER");
        rttr.addFlashAttribute("vo", vo);
//        return "redirect:/user/registerSuccess";
        boolean all = result && result1 && result3;
        return all ?
                new ResponseEntity<>("Register Success", HttpStatus.OK) :
                new ResponseEntity<>("Register Fail", HttpStatus.BAD_REQUEST);
    }

    @Transactional
    @PostMapping("/register")
    public ResponseEntity<String> register(MemberVO vo, RedirectAttributes rttr){
        log.info(vo);
        boolean result = false, result1 = false, result2 = false, result3 = false;
        vo.setPassword(passwordEncoder.encode(vo.getPassword()));
        result = service.registerHistory(vo);
        result1 = service.register(vo);
        String key = makeRandomValue.MakeAuthKey();
        result2 = service.registerKey(vo.getId(), key);
        result3 = authService.register(vo.getId(),"MEMBER");
        gmailSend.sendAuthMail(new MailVO(vo.getId(), key));
        rttr.addFlashAttribute("vo", vo);
//        return "redirect:/user/registerSuccess";
        boolean all = result && result1 && result2 && result3;
        return all ?
                new ResponseEntity<>("Register Success", HttpStatus.OK) :
                new ResponseEntity<>("Register Fail", HttpStatus.BAD_REQUEST);
    }



    @GetMapping("/registerSuccess")
    public void regSuccess(MemberVO vo){}

    @GetMapping("/modify")
    public void modify(){
    }

    @PostMapping("/modify")
    public ResponseEntity<String> modify(MemberVO vo, MemberHistoryVO hvo){//, MemberHistoryVO hvo
        log.info("Modify = " + vo);
        service.modify(vo, hvo);
        return service.modify(vo, hvo) ?
                new ResponseEntity<>("Modify Success", HttpStatus.OK) :
                new ResponseEntity<>("Modify Fail", HttpStatus.BAD_REQUEST);
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
    public void infoTest(){
    }

    @GetMapping("/infoDetail")
    public void infoDetail(Model model, String id){
        model.addAttribute("MemberVo", service.get(id));
    }

    @GetMapping("/details/group")
    public void group(Model model, String id){
        List<GroupVO> ownerList = profileService.getOwnerGroupList(id);
        List<GroupVO> joinList = profileService.getJoinGroupList(id);
        List<GroupVO> wishList = profileService.getWishGroupList(id);

        List<List<GroupVO>> list = new ArrayList<>();
        list.add(ownerList);
        list.add(joinList);
        list.add(wishList);

        Iterator<List<GroupVO>> it = list.iterator();

        while (it.hasNext()){
            List<GroupVO> vo = it.next();
            vo.forEach(group -> {
                List<String> tags = new ArrayList<>();
                groupTagMapper.getList(group.getSn()).forEach(tag -> tags.add(CodeTable.valueOf(tag.getName()).getValue()));
                group.setTags(tags);
            });
        }

        model.addAttribute("ownerList", ownerList);
        model.addAttribute("joinList", joinList);
        model.addAttribute("wishList", wishList);

    }

    @GetMapping("/details/groupWithPaging")
    public void groupWithPaging(Model model, String id
            ,@RequestParam(value = "pageNum1", defaultValue = "1") int pageNum1
            ,@RequestParam(value = "pageNum2", defaultValue = "1") int pageNum2
            ,@RequestParam(value = "pageNum3", defaultValue = "1") int pageNum3
            ,@RequestParam(value = "amount1", defaultValue = "6") int amount1
            ,@RequestParam(value = "amount2", defaultValue = "6") int amount2
            ,@RequestParam(value = "amount3", defaultValue = "6") int amount3){
        ProfileCriteria[] cris;
        log.info("groupWithPaging...");
        log.info(id);
        log.info(pageNum1 + pageNum2 + pageNum3);
        log.info(amount1 + amount3 + amount3);


        cris = new ProfileCriteria[]{
            new ProfileCriteria(pageNum1, amount1),
            new ProfileCriteria(pageNum2, amount2),
            new ProfileCriteria(pageNum3, amount3)
        };


        model.addAttribute("pageMaker1", new ProfileGroupPageDTO(cris[0], profileService.ownerListCount(id)));
        model.addAttribute("pageMaker2", new ProfileGroupPageDTO(cris[1], profileService.joinListCount(id)));
        model.addAttribute("pageMaker3", new ProfileGroupPageDTO(cris[2], profileService.wishListCount(id)));

        List<GroupVO> ownerList = profileService.ownerListWithPaging(id, cris[0]);
        List<GroupVO> joinList = profileService.joinListWithPaging(id, cris[1]);
        List<GroupVO> wishList = profileService.wishListWithPaging(id, cris[2]);

        List<List<GroupVO>> list = new ArrayList<>();
        list.add(ownerList);
        list.add(joinList);
        list.add(wishList);

        Iterator<List<GroupVO>> it = list.iterator();

        while (it.hasNext()){
            List<GroupVO> vo = it.next();
            vo.forEach(group -> {
                List<String> tags = new ArrayList<>();
                groupTagMapper.getList(group.getSn()).forEach(tag -> tags.add(CodeTable.valueOf(tag.getName()).getValue()));
                group.setTags(tags);
            });
        }

        model.addAttribute("ownerList", ownerList);
        model.addAttribute("joinList", joinList);
        model.addAttribute("wishList", wishList);
        model.addAttribute("id", id);
    }



    @GetMapping("/details/study")
    public void study(Model model, String id){
        model.addAttribute("id", id);
    }

    @GetMapping("/details/written")
    public void written(Model model, String id){
        model.addAttribute("id", id);
    }

    @GetMapping("/details/reply")
    public void reply(Model model, String id){
        model.addAttribute("id", id);
    }

    @GetMapping("/details/profile")
    public void profile(Model model, String id){
        model.addAttribute("MemberVo", service.get(id));
    }

    @GetMapping("chat")
    public void chat(){

    }

}
