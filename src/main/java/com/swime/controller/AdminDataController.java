package com.swime.controller;

import com.swime.domain.*;
import com.swime.service.AdminDashBoardService;
import com.swime.service.MemberService;
import com.swime.util.CookieUtils;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@RestController
@RequestMapping("/adminData")
@Log4j
@AllArgsConstructor
public class AdminDataController {

    AdminDashBoardService service;
    MemberService memberService;
    CookieUtils cookieUtils;

    @GetMapping(value = "/countUser",
            produces = {
                MediaType.APPLICATION_XML_VALUE,
                MediaType.APPLICATION_JSON_VALUE
            })
    public ResponseEntity<Integer> countUser(){
        return new ResponseEntity<>(service.countTodayUserRegister(), HttpStatus.OK);
    }

    @GetMapping(value = "/countGroup",
            produces = {
                MediaType.APPLICATION_XML_VALUE,
                MediaType.APPLICATION_JSON_VALUE
            })
    public ResponseEntity<Integer> countGroup(){
        return new ResponseEntity<>(service.countTodayGroupRegister(), HttpStatus.OK);
    }

    @GetMapping(value = "/countStudy",
            produces = {
                MediaType.APPLICATION_XML_VALUE,
                MediaType.APPLICATION_JSON_VALUE
            })
    public ResponseEntity<Integer> countStudy(){
        return new ResponseEntity<>(service.countTodayStudyRegister(), HttpStatus.OK);
    }

    @GetMapping(value = "/countUserForMonth",
            produces = {
                MediaType.APPLICATION_XML_VALUE,
                MediaType.APPLICATION_JSON_VALUE
            })
    public ResponseEntity<Integer[]> countUserForMonth(int year, int month){
        return new ResponseEntity<>(service.countUserRegisterByParam(year, month), HttpStatus.OK);
    }

    @GetMapping(value = "/countVisitor")
    public ResponseEntity<String> countVisitor(HttpServletResponse response, HttpServletRequest request){
        boolean isVisit = cookieUtils.getCookie(request, "isVisit") != null;

        if(isVisit) return new ResponseEntity<>("not count",HttpStatus.OK);

        cookieUtils.addCookie(response, "isVisit", (cookieUtils.setLifeTime() + ""), cookieUtils.setLifeTime());
        service.visitCountUp();
        return new ResponseEntity<>("count",HttpStatus.OK);
    }

    @GetMapping(value = "/getVisitCountByTime",
            produces = {
                    MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_VALUE
            })
    public ResponseEntity<Integer[]> getVisitCountByTime(int year, int month, int day){
        return new ResponseEntity<>(service.getVisitCountByTime(year,month,day), HttpStatus.OK);
    }

    @GetMapping(value = "/getDashBoardLang",
            produces = {
                    MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_VALUE
            })
    public ResponseEntity<List<DashBoardLangVO>> getDashBoardLang(){
        List<DashBoardLangVO> list = service.getDashBoardLang();
        list.forEach(vo -> vo.setName(CodeTable.valueOf(vo.getName()).getValue()));

        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    @GetMapping(value = "/getDashBoardLocale",
            produces = {
                    MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_VALUE
            })
    public ResponseEntity<List<DashBoardLocaleVO>> getDashBoardLocale(){
        List<DashBoardLocaleVO> list = service.getDashBoardLocale();
        list.forEach(vo -> {
            String pre = CodeTable.valueOf(vo.getSido()).getValue();
            String suf = CodeTable.valueOf(vo.getSigungu()).getValue();
            vo.setName(pre + " " + suf);
        });

        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    @GetMapping(value = "/todayUserRegister",
            produces = {
                    MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_VALUE
            })
    public ResponseEntity<DashBoardModalDataDTO> todayUserRegister(){
        return new ResponseEntity<>(service.todayUserRegister(), HttpStatus.OK);
    }

    @GetMapping(value = "/todayGroupRegister",
            produces = {
                    MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_VALUE
            })
    public ResponseEntity<DashBoardModalDataDTO> todayGroupRegister(){
        return new ResponseEntity<>(service.todayGroupRegister(), HttpStatus.OK);
    }

    @GetMapping(value = "/todayStudyRegister",
            produces = {
                    MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_VALUE
            })
    public ResponseEntity<DashBoardModalDataDTO> todayStudyRegister(){
        return new ResponseEntity<>(service.todayStudyRegister(), HttpStatus.OK);
    }

    @GetMapping(value = "/readAllMember",
            produces = {
                    MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_VALUE
            })
    public ResponseEntity<MemberDTO> readAllMember(AdminUserCriteria cri){
        return new ResponseEntity<>(memberService.selectAllMember(cri), HttpStatus.OK);
    }

}
