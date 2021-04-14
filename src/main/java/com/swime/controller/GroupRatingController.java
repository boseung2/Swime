package com.swime.controller;

import com.swime.service.GroupRatingService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequestMapping("/rating/")
@RestController
@Log4j
@AllArgsConstructor
public class GroupRatingController {

    private GroupRatingService service;
}
