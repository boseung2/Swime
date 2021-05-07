package com.swime.controller;

import com.swime.domain.AdminBoardPageDTO;
import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardVO;
import com.swime.service.BoardService;
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

import java.util.List;


@Controller
@RequestMapping("/admin")
@Log4j
@AllArgsConstructor
public class AdminController {

    private BoardService boardService;


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
    public ResponseEntity<AdminBoardPageDTO> adminGetListWithPaging(
            @PathVariable("page") int page,
            @RequestParam(value = "amount") int amount){

        BoardCriteria cri = new BoardCriteria(page,amount);
        log.info("adminBoardCri : "+ cri);
        log.info("controller page pram :" + page);

        AdminBoardPageDTO list = boardService.adminGetListWithPagingBySn(cri);

        return new ResponseEntity<>(list,HttpStatus.OK);
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
