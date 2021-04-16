package com.swime.controller;


import com.swime.domain.*;
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
        studyParam.setUserId("boseung@naver.com");
        studyParam.setStdSn(sn);

        model.addAttribute("studyParam", studyParam);

        // 찜 여부 : null이면 찜 아니면 찜취소
        log.info("=============================찜 여부 : " + service.getWish(studyParam));
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

        // 반복 주기 설정
        if("(선택)".equals(study.getRepeatCycle())) {
            study.setRepeatCycle(null);
        }else {
            study.setRepeatCycle(study.getRepeatCycle());
        }

        service.register(study);

        rttr.addFlashAttribute("result", "register");

        // 만들어진 스터디의 상세조회 페이지로 이동한다.
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

        // 반복 주기 설정
        log.info("====================================repeatCycle" + study.getRepeatCycle()); //STCY01
        if("(선택)".equals(study.getRepeatCycle())) {
            study.setRepeatCycle(null);
        }else {
            study.setRepeatCycle(study.getRepeatCycle());
        }

        service.modify(study);

        rttr.addFlashAttribute("result", "update");

        // 수정된 스터디의 상세조회 페이지로 이동한다.
        return "redirect:/study/get?sn=" + study.getSn();
    }

    // 스터디 삭제
    @PostMapping("/remove")
    public String remove(long sn, long grpSn, StudyCriteria cri, RedirectAttributes rttr) { // 스터디번호 들어옴

        StudyParamVO param = new StudyParamVO();
        param.setStdSn(sn);

        if(service.remove(param) == 1) {
            rttr.addFlashAttribute("result", "success");
        }

        rttr.addAttribute("grpSn", grpSn);
        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());

        return "redirect:/study/list";
    }
    
    // 스터디 멤버 관리 - 참여멤버/ 대기멤버 가져오기
    @GetMapping("/members")
    public void members(long stdSn, Model model) {
        model.addAttribute("study", service.get(stdSn));
        model.addAttribute("attendantList", service.getAttendantList(stdSn));
        model.addAttribute("waitingList", service.getWaitingList(stdSn));
    }

    // 스터디 찜하기
    @PostMapping("/wish")
    public String wish(WishStudyVO wish, RedirectAttributes rttr) {
        // 1. get.jsp에서 여기로 요청 보낼때 stdSn, userId 넘겨줘야함

        //임의로 설정
        wish.setUserId("boseung@naver.com");

        StudyParamVO studyParam = new StudyParamVO();
        studyParam.setStdSn(wish.getStdSn());
        studyParam.setUserId(wish.getUserId());
        
        // 2. 해당 wish가 존재하면 삭제
        if(service.getWish(studyParam) != null) {
            if(service.removeWish(studyParam) == 1) {
                rttr.addFlashAttribute("result", "cancel");
            }
        }else {
            // 3. 해당 wish가 없으면 등록
            if(service.registerWish(wish) == 1) {
                rttr.addFlashAttribute("result", "wish");
            };
        }

        //3. 다시 get 페이지로 가서 결과 모달창 띄우기
        return "redirect:/study/get?sn=" + wish.getStdSn();
        
        // 4. get 페이지에서 하트가 바뀌어있어야함
    }

    // 스터디 참가/탈퇴
    @GetMapping("attend")
    public String attend() {
        return "redirect:/study/get?sn = ";
    }


}
