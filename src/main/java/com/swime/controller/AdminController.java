package com.swime.controller;

import com.swime.domain.*;
import com.swime.service.AdminBoardService;
import com.swime.service.BoardService;
import com.swime.service.ReplyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
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
    public ResponseEntity<String> adminBoardRemove(@RequestBody String[] list){
        //@PathVariable(value = "dataArr") List<String> list,

        log.info("list : " + list);
        int result = 0;
        for (int i = 0; i < list.length; i++){
            log.info(list[i]);
            result = adminBoardService.adminBoardRemove(list[i]);
        }


//        String[] deleteList = list;
//        int deleteResult = 0;
//        for(int i = 0; i < deleteList.length; i++){
//            deleteResult = adminBoardService.adminBoardRemove(deleteList[i]);
//        }
//        int deleteResult = 0;
//        ArrayList<Integer> deleteList = new ArrayList<>();
//        for (int i = 0; i < deleteList.size(); i++){
//            deleteResult = adminBoardService.adminBoardRemove("1");
//            log.info(deleteResult);
//        }


        return result == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//        return deleteResult == 1
//                ? new ResponseEntity<>("success", HttpStatus.OK)
//                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
    //end 관리자 게시판

    @GetMapping("/manage-group")
    public void group(){
    }

    @GetMapping("/manage-study")
    public void study(){
    }

    @GetMapping("/manage-user")
    public void user(){
    }
}
