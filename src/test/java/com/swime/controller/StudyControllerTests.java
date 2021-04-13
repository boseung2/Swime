package com.swime.controller;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MockMvcBuilder;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(classes = {
        com.swime.config.RootConfig.class,
        com.swime.config.ServletConfig.class
})
@Log4j
public class StudyControllerTests {

    @Setter(onMethod_ = {@Autowired})
    private WebApplicationContext ctx;

    private MockMvc mockMvc;

    @Before
    public void setup() {
        this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
    }

    @Test
    public void testList() throws Exception {

        log.info(mockMvc.perform(
                MockMvcRequestBuilders.get("/study/list")
                    .param("pageNum", "1")
                    .param("amount", "3")
                ).andReturn().getModelAndView().getModelMap()
        );
    }

    @Test
    public void testGet() throws Exception{
        log.info(mockMvc.perform(MockMvcRequestBuilders
        .get("study/get")
        .param("sn", "368"))
        .andReturn()
        .getModelAndView().getModelMap());
    }

    @Test
    public void testRegister() throws Exception {
        String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/study/register")
            .param("grpSn", "196")
            .param("representation", "boseung@naver.com")
            .param("name", "람다와 스트림 스터디")
            .param("startDate", "2021-04-13")
            .param("endDate", "2021-04-13")
            .param("startTime", "12:00:00")
            .param("endTime", "15:30:00")
            .param("repeatCycle", "")
            .param("repeatDay", "")
            .param("information", "람다와 스트림 스터디입니다. 자바의 정석 지참해주세요")
            .param("onOff", "STOF01")
            .param("onUrl", "http://www.naver.com")
            .param("placeId", "")
            .param("expense", "")
            .param("capacity", "30")
        ).andReturn().getModelAndView().getViewName();

        log.info(resultPage);
    }

    @Test
    public void testModify() throws Exception {
        String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/study/register")
                .param("name", "람다와 스트림 스터디 수정")
                .param("startDate", "2021-04-13")
                .param("endDate", "2021-04-13")
                .param("startTime", "12:00:00")
                .param("endTime", "15:30:00")
                .param("repeatCycle", "")
                .param("repeatDay", "")
                .param("information", "람다와 스트림 스터디입니다. 자바의 정석 지참해주세요")
                .param("onOff", "STOF01")
                .param("onUrl", "http://www.naver.com")
                .param("placeId", "")
                .param("expense", "")
                .param("capacity", "30")
        ).andReturn().getModelAndView().getViewName();

        log.info(resultPage);
    }

    @Test
    public void testRemove() throws Exception {
        String resultPage = mockMvc.perform(MockMvcRequestBuilders.post("/study/remove")
            .param("sn", "368")
        ).andReturn().getModelAndView().getViewName();

        log.info(resultPage);
    }

    @Test
    public void testManage() throws Exception {
        log.info(mockMvc.perform(
                MockMvcRequestBuilders.get("/study/manage")
                .param("stdSn", "306")
                ).andReturn().getModelAndView().getModelMap()
        );
    }
}
