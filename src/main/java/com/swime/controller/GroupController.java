package com.swime.controller;

import com.swime.domain.*;
import com.swime.service.GroupAttendService;
import com.swime.service.GroupRatingService;
import com.swime.domain.GroupVO;
import com.swime.service.GroupService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

@Controller
@RequestMapping("/group/*")
@Log4j
@AllArgsConstructor
public class GroupController {

    private GroupService groupService;
    private GroupAttendService groupAttendService;
    private GroupRatingService groupRatingService;

    @GetMapping(value = "/list")
    public void list(GroupCriteria cri, Model model) {
        // 그룹 리스트 가져온다.
        log.info("list: " + cri);
        model.addAttribute("list", groupService.getListWithPaging(cri));
        int total = groupService.getTotal(cri);
        model.addAttribute("pageMaker", new GroupPageDTO(cri, total));
    }

    @GetMapping("/register")
    public void register() {

    }

    @PostMapping(value = "/register")
    public String register(GroupVO group, RedirectAttributes rttr) {
        log.info(">>>>>>>>>>>>>>>>>>>>>");
        log.info(group);

        if (group.getAttachList()  != null) {
            group.getAttachList().forEach(attach -> log.info(attach));
        }

        // 모임을 등록한다.
        groupService.register(group);
        rttr.addFlashAttribute("result", group.getSn());

        return "redirect:/group/list";
    }

    @GetMapping({"/get", "modify"})
    public void get(@RequestParam("sn") Long sn, @ModelAttribute("cri") GroupCriteria cri, Model model) {
        model.addAttribute("group", groupService.get(sn));
        model.addAttribute("attendList", groupAttendService.getList(sn));
    }

    @PostMapping("/modify")
    public String modify(GroupVO group, @ModelAttribute("cri") GroupCriteria cri, RedirectAttributes rttr) {
        log.info(">>>>>>>>>>>>>>>>>");
        log.info(group);
        if(groupService.modify(group) == 1) {
            rttr.addFlashAttribute("result", "success");
        }
        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());

        return "redirect:/group/list";
    }

    @PostMapping("/remove")
    public String remove(@RequestParam("sn") Long sn, @ModelAttribute("cri") GroupCriteria cri, RedirectAttributes rttr) {

        List<GroupAttachVO> attachList = groupService.getAttachList(sn);

        if(groupService.remove(groupService.get(sn)) == 1) {

            deleteFiles(attachList);

            rttr.addFlashAttribute("result", "success");

        }
        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());

        return "redirect:/group/list" + cri.getListLink();
    }

    @GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<List<GroupAttachVO>> getAttachList(Long grpSn) {

        log.info("getAttachList" + grpSn);

        return new ResponseEntity<>(groupService.getAttachList(grpSn), HttpStatus.OK);
    }

    private void deleteFiles(List<GroupAttachVO> attachList) {

        if(attachList == null || attachList.size() == 0) {
            return;
        }

        log.info("delete attach files..........");
        log.info(attachList);

        attachList.forEach(attach -> {
            try {
                Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());
                Files.deleteIfExists(file);
                if(Files.probeContentType(file).startsWith("image")) {
                    Path thumbNail = Paths.get("C:\\upload||"+attach.getUploadPath()+"\\s_"+attach.getUuid()+"_"+attach.getFileName());
                    Files.delete(thumbNail);
                }
            } catch(Exception e) {
                log.error("delete file error" + e.getMessage());
            }
        });
    }

    /*
    public ResponseEntity<Map<String, Object>> get(
            @PathVariable("sn") Long sn) {

        Map<String, Object> map = new HashMap<>();
        // 기본그룹정보
        map.put("group", groupService.get(sn));
        // 그룹 가입자리스트
        map.put("attendList", groupAttendService.getList(sn));
        // 그룹 후기리스트
        map.put("ratingList", groupRatingService.getListWithPaging(sn, new GroupRatingCriteria(1, 6)));
        return new ResponseEntity<>(map, HttpStatus.OK);
    }

    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
                    value = "/{sn}")
    public ResponseEntity<String> modify(
            @RequestBody GroupVO group,
            @PathVariable("sn") Long sn) {
        // 모임정보 수정한다.
        group.setSn(sn);
        log.info("sn: " + sn);
        log.info("modify: " + group);
        return groupService.modify(group) == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping(value = "/attend")
    public ResponseEntity<String> attend(@RequestBody GroupAttendVO groupAttend) {
        // 모임에 참여한다.
        int count = groupAttendService.attend(groupAttend);

        return count == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value = "/userList/{sn}")
    public ResponseEntity<List<GroupAttendVO>> getAttendList(@PathVariable("sn") Long sn) {
        // 해당모임 가입유저를 가져온다.
        return new ResponseEntity<>(groupAttendService.getList(sn), HttpStatus.OK);
    }

    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
                value = "/user/{sn}")
    public ResponseEntity<String> modifyAttend(@RequestBody GroupAttendVO groupAttend, @PathVariable("sn") Long sn) {
        // 참석여부를 수정한다
        groupAttend.setSn(sn);
        return groupAttendService.ban(groupAttend) == 1 // 수정해야함!!!!!!!!!!!!!!!!!!!!!!!!!!
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping(value = "/rating/new")
    public ResponseEntity<String> registerRating(@RequestBody GroupRatingVO groupRating) {
        // 후기 등록
        int registerCount = groupRatingService.register(groupRating);

        return registerCount == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
                    value = "/rating/{sn}")
    public ResponseEntity<String> modifyRating(@RequestBody GroupRatingVO groupRating,
                                               @PathVariable("sn") Long sn) {
        // 후기 수정
        groupRating.setSn(sn);
        log.info("sn: " + sn);
        log.info("modify: " + groupRating);
        return groupRatingService.modify(groupRating) == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @DeleteMapping(value = "/rating/{sn}")
    public ResponseEntity<String> deleteRating(@PathVariable("sn") Long sn) {
        // 후기삭제
        return groupRatingService.delete(sn) == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

     */

}
