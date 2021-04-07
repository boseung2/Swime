package com.swime.controller;

import com.google.gson.Gson;
import com.swime.domain.GroupCriteria;
import com.swime.domain.GroupVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(classes = {
        com.swime.config.RootConfig.class,
        com.swime.config.ServletConfig.class })
@Log4j
public class SampleControllerTests {

    @Setter(onMethod_ = {@Autowired})
    private WebApplicationContext ctx;

    private MockMvc mockMvc;

    @Before
    public void setup() {
        this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
    }

    @Test
    public void testCreate() throws Exception {
        GroupVO group = new GroupVO();
        group.setCategory("GRCA01");
        group.setName("controller test 모임명");
        group.setUserId("jungbs3726@naver.com");
        group.setPicture("controller test picture");
        group.setDescription("controller test description");
        group.setInfo("controller test 모임정보");
        group.setSido("LODO01");
        group.setSigungu("LOGU02");
        group.setRegUserId("테스트 id");

        String jsonStr = new Gson().toJson(group);

        log.info(jsonStr);

        mockMvc.perform(post("/group/new")
        .contentType(MediaType.APPLICATION_JSON)
        .content(jsonStr))
                .andExpect(status().is(200));
    }

    @Test
    public void testGet() throws Exception {
        mockMvc.perform(get("/group/157"));
    }

    @Test
    public void testGetList() throws Exception {
        GroupCriteria cri = new GroupCriteria(1, 6);
        String jsonStr = new Gson().toJson(cri);
        log.info(jsonStr);

        mockMvc.perform(post("/group/list")
        .contentType(MediaType.APPLICATION_JSON)
        .content(jsonStr))
        .andExpect(status().is(200));
    }

}
