package com.swime.controller;

import com.swime.domain.*;
import com.swime.service.AdminBoardService;
import com.swime.service.AdminStudyService;
import com.swime.service.BoardService;
import com.swime.service.ReplyService;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/admin")
@Log4j
@AllArgsConstructor
public class AdminController {

    //private BoardService boardService;
    //private ReplyService replyService;
    private AdminBoardService adminBoardService;

    @Setter(onMethod_ = {@Autowired})
    private AdminStudyService adminStudyService;


    @GetMapping("/adminIndex")
    public void index(){
    }

    @GetMapping("/dashBoard")
    public void dashboard(){
    }
    //관리자 게시판
    @GetMapping("/manage-board")
    public void board(){
    }

    //, @RequestParam(value = "amount", defaultValue = "10")int amount
    @GetMapping(value ="/manageBoard/{page}",
            produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<?> adminGetListWithPaging(
            @PathVariable("page") int page,
            @RequestParam(value = "amount") int amount,
            @RequestParam(value = "bbs") String bbs,
            @RequestParam(value = "sort") String type,
            @RequestParam(value = "active") String active,
            @RequestParam(value = "keyword") String keyword,
            @RequestParam(value = "searchResult", required = false) String search){

        log.info("controller page pram :" + page);
        log.info("amount : " + amount);
        log.info("bbs : " + bbs);
        log.info("type : " + type);
        log.info("active : " + active);
        log.info("keyword : " + keyword);
        log.info("search : " + search);

        Map<String,Object> map = new HashMap<>();


        if(bbs.equals("board")){
            AdminBoardCriteria boardCri = new AdminBoardCriteria(page, amount, type, active, keyword, search);
            log.info("adminBoardCri : "+ boardCri);
            AdminBoardPageDTO boardList = adminBoardService.adminGetListWithPagingBySn(boardCri);

            map.put("board", boardList);
            map.put("boardCompare", "isBoard");

            return new ResponseEntity<>(map,HttpStatus.OK);

        }else{
            AdminReplyCriteria replyCri = new AdminReplyCriteria(page, amount, type, active, keyword, search);
            ReplyPageDTO replyList = adminBoardService.adminReplyGetListWithPagingBySn(replyCri);
            log.info("adminReplyCri : " + replyCri);

            map.put("reply", replyList);
            map.put("replyCompare", "isReply");

            return new ResponseEntity<>(map,HttpStatus.OK);

        }

    }

    //@DeleteMapping(value = "board/{list}")
    @PostMapping(value = "/board/dataArr")
    public ResponseEntity<String> adminBoardRemove(@RequestBody String[] list,
                                                   @RequestParam(value = "bbs") String bbs) {

        log.info("list : " + list);
        log.info("delete bbs : " + bbs);
        int result = 0;
        for (int i = 0; i < list.length; i++) {
            log.info(list[i]);
            if(bbs.equals("reply")){
                result = adminBoardService.adminReplyRemove(list[i]);
            }else{
                result = adminBoardService.adminBoardRemove(list[i]);
            }
        }
        return result == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

//    @PostMapping(value = "/board/toActive")
//    public ResponseEntity<String> adminBoardToActive(@RequestBody String[] list,
//                                                   @RequestParam(value = "bbs") String bbs) {
//
//        log.info("list : " + list);
//        log.info("delete bbs : " + bbs);
//        int result = 0;
//        for (int i = 0; i < list.length; i++) {
//            log.info(list[i]);
//            if(bbs.equals("reply")){
//                result = adminBoardService.adminReplyFromDeleteToActive(list[i]);
//            }else{
//                result = adminBoardService.adminBoardFromDeleteToActive(list[i]);
//            }
//        }
//        return result == 1
//                ? new ResponseEntity<>("success", HttpStatus.OK)
//                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//    }

    //end 관리자 게시판

    @GetMapping("/manage-group")
    public void group(){
    }

    @GetMapping(value = "/manage-study")
    public void study(){

    }

    @GetMapping(value = "/manage-study/totalList/{pageNum}/{amount}", produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<AdminStudyPageDTO> getTotalList(@PathVariable("pageNum") int pageNum, @PathVariable("amount") int amount){

        log.info("manage-study pageNum= " + pageNum);
        log.info("manage-study amount= " + amount);

        // 리스트 가져오기
        AdminStudyCriteria cri = new AdminStudyCriteria(pageNum, amount);
        AdminStudyPageDTO adminStudyPageDTO = adminStudyService.getTotalStudyList(cri);

        return new ResponseEntity<>(adminStudyPageDTO, HttpStatus.OK);

    }

    @GetMapping("/manage-user")
    public void user(){
    }
}
