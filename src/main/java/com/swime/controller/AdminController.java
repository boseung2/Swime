package com.swime.controller;

import com.swime.domain.*;
import com.swime.service.AdminBoardService;
import com.swime.service.AdminGroupService;
import com.swime.service.BoardService;
import com.swime.service.ReplyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.xml.ws.Response;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/admin")
@Log4j
@AllArgsConstructor
public class AdminController {

    
    private AdminBoardService adminBoardService;
    private AdminGroupService adminGroupService;


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

        /*
        * 관리자에서 게시판, 댓글을 요청하는데 구별할 수 있어야함.
        * 게시판 : board, 댓글 : reply
        * 게시판이면 boardList를 뿌려주고 프론트에서 구별할 수 있게 map에 key로 boardCompare을 담아서 넘김.
        * */
        if(bbs.equals("board")){
            AdminBoardCriteria boardCri = new AdminBoardCriteria(page, amount, type, active, keyword, search);
            log.info("adminBoardCri : "+ boardCri);
            AdminBoardPageDTO boardList = adminBoardService.adminGetListWithPagingBySn(boardCri);

            map.put("board", boardList);
            map.put("boardCompare", "isBoard");

            return new ResponseEntity<>(map,HttpStatus.OK);
        //댓글
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
            log.info("list[i]--------");
            log.info(list[i]);
            if(bbs.equals("reply")){
                //reuslt =
                result = adminBoardService.adminReplyRemove(list[i]);
            }else{
                result = adminBoardService.adminBoardRemove(list[i]);
            }
        }
        return result == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
//  게시판 삭제상태 -> 정상상태로 수정
    @PostMapping(value = "/board/toActive")
    public ResponseEntity<String> adminBoardToActive(@RequestBody String[] list,
                                                   @RequestParam(value = "bbs") String bbs) {

        log.info("list : " + list);
        log.info("update bbs : " + bbs);

        int result = 0;

        for (int i = 0; i < list.length; i++) {

            log.info(list[i]);

            if(bbs.equals("reply")){
                result = adminBoardService.adminReplyFromDeleteToActive(list[i]);
            }else{
                result = adminBoardService.adminBoardFromDeleteToActive(list[i]);
            }
        }
        return result == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
// end 관리자 게시판

    //관리자 모임
    @GetMapping("/manage-group")
    public void group(){

    }

    @GetMapping(value ="/manageGroup/{page}",
            produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<AdminGroupPageDTO> groupGetList(@PathVariable("page") int page,
                                                          @RequestParam(value = "amount") int amount){

        AdminGroupCriteria cri = new AdminGroupCriteria(page, amount);
        AdminGroupPageDTO dto = adminGroupService.adminGetGroupListWithPagingBySn(cri);

        dto.getList().forEach(GroupVO->{
            GroupVO.setSido(CodeTable.valueOf(GroupVO.getSido()).getValue());
            GroupVO.setSigungu(CodeTable.valueOf(GroupVO.getSigungu()).getValue());
        });

        log.info("groupPage : " + page + "groupAmount : " + amount);

        log.info("groupCri : " + cri);

        return new ResponseEntity<>(dto, HttpStatus.OK);

    }
    @PostMapping(value = "/group/dataArr")
    public ResponseEntity<String> adminGroupRemove(@RequestBody Long[] list) {

        log.info("list : " + list);
        int result = 0;

        for (int i = 0; i < list.length; i++) {

            log.info(list[i]);

            result = adminGroupService.adminGroupRemove(list[i]);
        }
        return result == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
    // end 관리자 모임



    @GetMapping("/manage-study")
    public void study(){
    }

    @GetMapping("/manage-user")
    public void user(){
    }
}
