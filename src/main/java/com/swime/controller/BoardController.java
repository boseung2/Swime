package com.swime.controller;

import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardVO;
import com.swime.domain.GroupVO;
import com.swime.service.BoardService;
import com.swime.service.GroupService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

//@RestController
@Controller
//@RequestMapping("/board")
@RequestMapping("/board/*")
@Log4j
@AllArgsConstructor
public class BoardController {

    private BoardService service;


    //jsp get List Test
    @GetMapping("/list")
    public void list(Model model) {

        log.info("list");

        model.addAttribute("list", service.getList());
    }

    @GetMapping("/register")
    public void register(){

    }

    @PostMapping("register")
    public String register(BoardVO board, RedirectAttributes rttr) {

        log.info("register...." + board);

        service.register(board);

        rttr.addFlashAttribute("result : " + board.getSn());

        return "redirect:/board/list";
    }

    @GetMapping("/get")
    public void get(@RequestParam("sn") Long sn, Model model) {

        log.info("/get");
        model.addAttribute("board", service.get(sn));
    }

    @PostMapping("modify")
    public String modify(BoardVO board, RedirectAttributes rttr) {

        log.info("modify: " + board);

        if (service.modify(board)) {
            rttr.addFlashAttribute("result : " + "success");
        }
        return "redirect:/board/list";
    }

    @PostMapping("/remove")
    public String remove(@RequestParam("sn") Long sn, RedirectAttributes rttr) {

        log.info("remove: " + sn);
        if (service.remove(sn)) {
            rttr.addFlashAttribute("result", "success");
        }

        return "redirect:/board/list";

    }
}


//    @PostMapping(value = "/new")
//    public ResponseEntity<String> create(@RequestBody BoardVO vo) {
//
//        ResponseEntity<String> entity = null;
//        log.info("BoardVO: " + vo);
//
//        try {
//            int insertCount = service.register(vo);
//            log.info("Board INSERT COUNT: " + insertCount);
//            new ResponseEntity<>("success", HttpStatus.OK);
//
//        }catch(Exception e){
//            e.printStackTrace();
//            entity = new ResponseEntity<>(e.getMessage(),HttpStatus.INTERNAL_SERVER_ERROR);
//
//        }
//        return entity;
//
////        return insertCount == 1
////                ? new ResponseEntity<>("success", HttpStatus.OK)
////                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//    }
//
//    @GetMapping(value = "/list")
//    public ResponseEntity<List<BoardVO>> getList(@RequestBody BoardCriteria cri) {
//        return new ResponseEntity<>(service.getListWithPaging(cri), HttpStatus.OK);
//    }
//
//
//    @GetMapping(value = "/{sn}")
//    public ResponseEntity<BoardVO> get(
//            @PathVariable("sn") Long sn) {
//        return new ResponseEntity<>(service.get(sn), HttpStatus.OK);
//    }
//
//    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
//            value = "/{sn}")
//    public ResponseEntity<String> modify(
//            @RequestBody BoardVO vo,
//            @PathVariable("sn") Long sn) {
//
//        vo.setSn(sn);
//
//        log.info("sn: " + sn);
//        log.info("modify: " + vo);
//
//        return service.modify(vo)
//                ? new ResponseEntity<>("success", HttpStatus.OK)
//                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//    }

//}
