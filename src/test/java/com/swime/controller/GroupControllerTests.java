package com.swime.controller;

import com.google.gson.Gson;
import com.swime.domain.GroupAttendVO;
import com.swime.domain.GroupCriteria;
import com.swime.domain.GroupRatingVO;
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

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(classes = {
        com.swime.config.RootConfig.class,
        com.swime.config.ServletConfig.class })
@Log4j
public class GroupControllerTests {

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

    // update는 data를 가져온다음에 일부분만 수정해서 update실행해야한다.
    @Test
    public void testModify() throws Exception {
        GroupVO group = new GroupVO();
        group.setCategory("GRCA01");
        group.setName("수정한 모임명");
        group.setUserId("jungbs3726@naver.com");
        group.setPicture("controller ");
        group.setDescription("controller test description");
        group.setInfo("controller test 모임정보");
        group.setSido("LODO01");
        group.setSigungu("LOGU02");

        String jsonStr = new Gson().toJson(group);

        log.info(jsonStr);

        mockMvc.perform(put("/group/217")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonStr))
                .andExpect(status().is(200));
    }

    @Test
    public void testAttend() throws Exception{
        GroupAttendVO groupAttend = new GroupAttendVO();
        groupAttend.setGrpSn(176L);
        groupAttend.setUserId("jungbs3726@naver.com");
        groupAttend.setGrpRole("GRRO02");
        groupAttend.setStatus("GRUS01");

        String jsonStr = new Gson().toJson(groupAttend);

        log.info(jsonStr);

        mockMvc.perform(post("/group/attend")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonStr))
                .andExpect(status().is(200));
    }

    @Test
    public void testGetAttendList() throws Exception {
        mockMvc.perform(get("/group/userList/196"));
    }

    @Test
    public void testRegisterRating() throws Exception {
        GroupRatingVO groupRating = new GroupRatingVO();
        groupRating.setGrpSn(176L);
        groupRating.setStdSn(6L);
        groupRating.setUserId("jungbs3726@naver.com");
        groupRating.setRating(1D);
        groupRating.setReview("여기 별로예요.");

        String jsonStr = new Gson().toJson(groupRating);

        log.info(jsonStr);

        mockMvc.perform(post("/group/rating/new")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonStr))
                .andExpect(status().is(200));

    }

    @Test
    public void testDeleteRating() throws Exception {
        GroupRatingVO groupRating = new GroupRatingVO();
        groupRating.setSn(30L);

        String jsonStr = new Gson().toJson(groupRating);

        log.info(jsonStr);

        mockMvc.perform(delete("/group/rating/30")
                .contentType(MediaType.APPLICATION_JSON)
                .content(jsonStr))
                .andExpect(status().is(200));
    }

}
