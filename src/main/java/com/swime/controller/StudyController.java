package com.swime.controller;


import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyPageDTO;
import com.swime.domain.StudyParamVO;
import com.swime.domain.StudyVO;
import com.swime.service.StudyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import oracle.ucp.proxy.annotation.Post;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/study")
@Log4j
@AllArgsConstructor
public class StudyController {

    private StudyService service;

    // 스터디 리스트 페이징처리
    @GetMapping("/list")
    public void getList(long grpSn, StudyCriteria cri, Model model) {
        model.addAttribute("grpSn", grpSn);
        model.addAttribute("list", service.getList(cri, grpSn));
        model.addAttribute("pageMaker", new StudyPageDTO(cri, service.countStudy(grpSn)));
    }

    // 스터디 상세조회
    @GetMapping("/get")
    public void get(long sn, StudyCriteria cri, Model model) {
        model.addAttribute("cri", cri);
        model.addAttribute("study", service.get(sn));
        model.addAttribute("members", service.getAttendantList(sn));

        // 로그인한 경우
        // 찜 여부 가져오기
        StudyParamVO studyParam = new StudyParamVO();

//        qwer8203@naver.com // 스터디장
//        boseung@naver.com // 일반 회원
//        aaa@service.com // 로그인 안한 회원
        studyParam.setUserId("qwer8203@naver.com");
        studyParam.setStdSn(sn);

        model.addAttribute("studyParam", studyParam);

        // null이면 찜 아니면 찜취소
        model.addAttribute("wish", service.getWish(studyParam));

        // 참석 여부 가져오기
        model.addAttribute("attend", service.getAttendant(studyParam));
    }

    // 스터디 생성 페이지
    @GetMapping("/register")
    public void register() {
        
    }

    // 스터디 생성
    @PostMapping("/register")
    public String register(StudyVO study, RedirectAttributes rttr) {
        // 임의로 설정
        study.setRepresentation("qwer8203@naver.com");
        study.setGrpSn(222);

        // 함수로 빼기
        if(study.getOnUrl() != null) {
            study.setOnOff("STOF01");
        }else {
            study.setOnOff("STOF02");
        }
        
        //초기값 써서 else문 없앰
        study.setRepeatCycle("STCY03");
        if("(선택)".equals(study.getRepeatCycle())) {
            study.setRepeatCycle(null);
        }else if("매주".equals(study.getRepeatCycle())) {
            study.setRepeatCycle("STCY01");
        }else if("격주".equals(study.getRepeatCycle())) {
            study.setRepeatCycle("STCY02");
        }

        service.register(study);

        rttr.addFlashAttribute("result", study.getSn());

        // 만들어진 스터디의 상세조회 페이지로 이동한다.
//        return "redirect:/study/get?sn=" + study.getSn() + "&pageNum=1&amount=3";
        return "redirect:/study/get?sn=" + study.getSn();
    }

    // 스터디 수정

    @GetMapping("/modify")
    public void modify(long sn, Model model) {
        model.addAttribute("study", service.get(sn));
    }

    @PostMapping("/modify")
    public String modify(StudyVO study, RedirectAttributes rttr) {

        if(study.getOnUrl() != null) {
            study.setOnOff("STOF01");
        }else {
            study.setOnOff("STOF02");
        }

        //초기값 써서 else문 없앰
        study.setRepeatCycle("STCY03");
        if("(선택)".equals(study.getRepeatCycle())) {
            study.setRepeatCycle(null);
        }else if("매주".equals(study.getRepeatCycle())) {
            study.setRepeatCycle("STCY01");
        }else if("격주".equals(study.getRepeatCycle())) {
            study.setRepeatCycle("STCY02");
        }

        service.modify(study);

        rttr.addFlashAttribute("result", study.getSn());

        // 수정된 스터디의 상세조회 페이지로 이동한다.
//        return "redirect:/study/get?sn=" + study.getSn() + "&pageNum=1&amount=3";
        return "redirect:/study/get?sn=" + study.getSn();
    }

    // 스터디 삭제
    @PostMapping("/remove")
    public String remove(StudyParamVO param, RedirectAttributes rttr) {
        if(service.remove(param) == 1) {
            rttr.addFlashAttribute("result", "success");
        }
        return "redirect:/group/";  //??
    }
    
    // 스터디 멤버 관리 - 참여멤버/ 대기멤버 가져오기
    @GetMapping("/members")
    public void members(long stdSn, Model model) {
        model.addAttribute("study", service.get(stdSn));
        model.addAttribute("attendantList", service.getAttendantList(stdSn));
        model.addAttribute("waitingList", service.getWaitingList(stdSn));
    }

}
