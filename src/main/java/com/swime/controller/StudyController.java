package com.swime.controller;


import com.swime.domain.*;
import com.swime.service.StudyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/study")
@Log4j
@AllArgsConstructor
@PropertySource("classpath:/map_key.properties")
public class StudyController {

    @Autowired
    ApplicationContext context;

    private StudyService service;

    // 스터디 리스트 페이징처리
    @GetMapping(value = "/list/{grpSn}/{page}", produces = {MediaType.APPLICATION_JSON_VALUE})
    @ResponseBody
    public ResponseEntity<GroupStudyListDTO> getList(@PathVariable("grpSn") long grpSn, @PathVariable("page") int page) {

        StudyCriteria cri = new StudyCriteria(page, 3);
        GroupStudyListDTO list = service.getList(cri, grpSn);

        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    // 에러페이지
    @GetMapping("/error")
    public void error() {

    }

    @GetMapping("/map")
    public void map(Model model) {
        Environment env = context.getEnvironment();
        log.info("key = " + env.getProperty("key"));

        model.addAttribute("key", env.getProperty("key"));
    }

    // 스터디 상세조회
    @GetMapping("/get")
    public String get(long sn, StudyCriteria cri, Model model) {

        // 지도 api 키
        Environment env = context.getEnvironment();
        model.addAttribute("key", env.getProperty("key"));

        // 그룹 페이징
        StudyCriteria sendCri = new StudyCriteria(cri.getPageNum(), cri.getAmount());
        model.addAttribute("cri", sendCri);

        log.info("그룹 페이징 = " + sendCri);

        try {
            StudyVO study = service.get(sn);
            model.addAttribute("study", study);

            if(study == null) {
                // 해당스터디가 존재하지 않으면 에러페이지로 이동
                return "redirect:/study/error";
            }
            model.addAttribute("members", service.getAttendantList(sn));

        }catch (Exception e) {
            // 스터디 정보를 가져오는데 실패하면 에러페이지로 이동
            return "redirect:/study/error";
        }

        return "study/get";
    }

    // 스터디 생성 페이지
    @GetMapping("/register")
    @PreAuthorize("isAuthenticated()")
    public void register(@RequestParam("grpSn") long grpSn, StudyCriteria cri, Model model) {
        model.addAttribute("grpSn", grpSn);
        model.addAttribute("cri", cri);

        Environment env = context.getEnvironment();
        log.info("key = " + env.getProperty("key"));

        model.addAttribute("key", env.getProperty("key"));
    }

    // 스터디 생성
    @PostMapping("/register")
    @PreAuthorize("isAuthenticated()")
    public String register(StudyVO study, StudyCriteria cri, RedirectAttributes rttr) {

        log.info("그룳 페이징 = " + cri);
        log.info("study onOff = " + study.getOnOff());

        // 반복 주기 설정
        if("(선택)".equals(study.getRepeatCycle())) {
            study.setRepeatCycle("");
        }else {
            study.setRepeatCycle(study.getRepeatCycle());
        }

        try {
            service.register(study);
            rttr.addFlashAttribute("result", "register");
        }catch (Exception e) {
            rttr.addFlashAttribute("result", "register error");
        }

        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());

        // 만들어진 스터디의 상세조회 페이지로 이동한다.
        return "redirect:/study/get?sn=" + study.getSn();
    }

    // 스터디 수정
    @GetMapping("/modify")
    @PreAuthorize("principal.username == #representation")
    public void modify(long sn, StudyCriteria cri, String representation, Model model) {
        model.addAttribute("study", service.get(sn));
        model.addAttribute("cri", cri);

        Environment env = context.getEnvironment();
        model.addAttribute("key", env.getProperty("key"));
    }

    @PostMapping("/modify")
    @PreAuthorize("principal.username == #study.representation")
    public String modify(StudyVO study, StudyCriteria cri, RedirectAttributes rttr) {

        log.info("modify representation " + study.getRepresentation());
        log.info("modify study onOff = " + study.getOnOff());

        // 반복 주기 설정
        log.info("====================================repeatCycle" + study.getRepeatCycle()); //STCY01
        if("(선택)".equals(study.getRepeatCycle())) {
            study.setRepeatCycle("");
        }else {
            study.setRepeatCycle(study.getRepeatCycle());
        }

        if(service.modify(study) == 1) {
            rttr.addFlashAttribute("result", "update");
        }else {
            rttr.addFlashAttribute("result", "update error");
        }

        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());

        // 수정된 스터디의 상세조회 페이지로 이동한다.
        return "redirect:/study/get?sn=" + study.getSn();
    }

    // 스터디 삭제
    @PostMapping("/remove")
    @PreAuthorize("principal.username == #representation")
    public String remove(long sn, long grpSn, StudyCriteria cri, String representation, RedirectAttributes rttr) { // 스터디번호 들어옴

        log.info("=======================================remove cri = " + cri);

        StudyParamVO param = new StudyParamVO();
        param.setStdSn(sn);

        if(service.remove(param) == 1) {
            rttr.addFlashAttribute("result", "success");
        }else {
            rttr.addFlashAttribute("result", "error");
        }

        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());

        return "redirect:/group/get?sn=" + grpSn;
    }
    
    // 스터디 멤버 관리 페이지 - 참여멤버/ 대기멤버 가져오기 - 아직 구현 x
//    @GetMapping("/members")
//    @PreAuthorize("principal.username == #study.representation")
//    public void members(long stdSn, Model model) {
//        model.addAttribute("study", service.get(stdSn));
//        model.addAttribute("attendantList", service.getAttendantList(stdSn));
//        model.addAttribute("waitingList", service.getWaitingList(stdSn));
//    }
}
