package com.swime.controller;

import com.swime.domain.*;
import com.swime.service.BoardService;
import com.swime.service.ReplyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/admin")
@Log4j
@AllArgsConstructor
public class AdminController {

    private BoardService boardService;
    private ReplyService replyService;


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
            @RequestParam(value = "bbs") String bbs){

        log.info("controller page pram :" + page);
        log.info("amount : " + amount);
        log.info("bbs : " + bbs);

        Map<String,Object> map = new HashMap<>();


        if (bbs.equals("board")){
            BoardCriteria boardCri = new BoardCriteria(page,amount);
            log.info("adminBoardCri : "+ boardCri);
            AdminBoardPageDTO boardList = boardService.adminGetListWithPagingBySn(boardCri);
            map.put("board", boardList);
            map.put("boardCompare", "isBoard");
            //return new ResponseEntity<>(list,HttpStatus.OK);
            return new ResponseEntity<>(map,HttpStatus.OK);
        }else{
            ReplyCriteria replyCri = new ReplyCriteria(page, amount);
            ReplyPageDTO replyList = replyService.adminGetListWIthPagingBySn(replyCri);
            log.info("adminReplyCri : " + replyCri);
            map.put("reply", replyList);
            map.put("replyCompare", "isReply");
//            return new ResponseEntity<>(replyList,HttpStatus.OK);
            return new ResponseEntity<>(map,HttpStatus.OK);

        }




//        return new ResponseEntity<>(boardService
//                .adminGetListWithPagingBySn(cri), HttpStatus.OK);
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
