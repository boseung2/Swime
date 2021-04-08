package com.swime.mapper;

<<<<<<< HEAD
import com.swime.domain.GroupCriteria;
=======
>>>>>>> ff153d8c56d12ae8ae3e863b65b2482c02c0b7f5
import com.swime.domain.GroupVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

<<<<<<< HEAD
import java.util.List;

=======
>>>>>>> ff153d8c56d12ae8ae3e863b65b2482c02c0b7f5
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class GroupMapperTests {

    @Setter(onMethod_ = @Autowired)
    private GroupMapper mapper;

    @Test
<<<<<<< HEAD
=======
    public void getMapper(){
        log.info(mapper);
    }

    @Test
    public void testGetList() {
        mapper.getList().forEach(group -> log.info(group));
    }

    @Test
    public void testInsert() {
        GroupVO group = new GroupVO();

        group.setCategory("GRCA02");
        group.setName("테스트제목");
        group.setUserId("테스트 id");
        group.setUserName("테스트 name");
        group.setPicture("테스트 picture");
        group.setDescription("테스트 description");
        group.setHeadcount(5L);
        group.setRating(5.0D);
        group.setSido("LODO01");
        group.setSigungu("LOGU02");
        group.setStatus("GRST01");
        group.setRegUserId("테스트 id");

        mapper.insert(group);
        log.info(group);
    }

    @Test
>>>>>>> ff153d8c56d12ae8ae3e863b65b2482c02c0b7f5
    public void testInsertSelectKey() {
        GroupVO group = new GroupVO();

        group.setCategory("GRCA02");
<<<<<<< HEAD
        group.setName("아녕하세요");
        group.setUserId("jungbs3726@naver.com");
        group.setPicture("테스트 picture");
        group.setDescription("테스트 description");
        group.setInfo("테스트 모임정보");
        group.setSido("LODO01");
        group.setSigungu("LOGU02");
=======
        group.setName("테스트제목");
        group.setUserId("테스트 id");
        group.setUserName("테스트 name");
        group.setPicture("테스트 picture");
        group.setDescription("테스트 description");
        group.setHeadcount(5L);
        group.setRating(5.0D);
        group.setSido("LODO01");
        group.setSigungu("LOGU02");
        group.setStatus("GRST01");
>>>>>>> ff153d8c56d12ae8ae3e863b65b2482c02c0b7f5
        group.setRegUserId("테스트 id");

        mapper.insertSelectKey(group);
        log.info(group);
    }

    @Test
    public void testRead() {
<<<<<<< HEAD
        GroupVO group = mapper.read(98L);
=======
        GroupVO group = mapper.read(22L);
>>>>>>> ff153d8c56d12ae8ae3e863b65b2482c02c0b7f5
        log.info(group);
    }

    @Test
<<<<<<< HEAD
    public void testPaging() {
        GroupCriteria cri = new GroupCriteria();
        List<GroupVO> list = mapper.getListWithPaging(cri);
        list.forEach(group -> log.info(group));
    }

    @Test
    public void testPaging2() {
        GroupCriteria cri = new GroupCriteria();
        cri.setPageNum(1);
        cri.setAmount(6);
        List<GroupVO> list = mapper.getListWithPaging(cri);
        list.forEach(group -> log.info(group.getSn()));
=======
    public void testDelete() {
        GroupVO group = new GroupVO();
        group.setSn(23L);
        group.setUpdUserId("삭제 id");

        int count = mapper.delete(group);
        log.info("DELETE COUNT: " + count);
>>>>>>> ff153d8c56d12ae8ae3e863b65b2482c02c0b7f5
    }

    @Test
    public void testUpdate() {
        GroupVO group = new GroupVO();
<<<<<<< HEAD
        group.setSn(96L);
        group.setCategory("GRCA02");
        group.setName("수정된 이름");
        group.setUserId("boseung@naver.com");
        group.setPicture("수정된 picture");
        group.setDescription("수정된 description");
        group.setAttendCount(10L);
        group.setRating(4.5D);
        group.setRatingCount(5L);
        group.setSido("LODO01");
        group.setSigungu("LOGU02");
        group.setStatus("GRST01");
=======
        group.setSn(24L);
        group.setCategory("GRCA02");
        group.setName("수정된 이름");
        group.setUserId("수정된 id");
        group.setUserName("수정된 name");
        group.setPicture("수정된 picture");
        group.setDescription("수정된 description");
        group.setHeadcount(10L);
        group.setRating(4.5D);
        group.setSido("LODO01");
        group.setSigungu("LOGU02");
        group.setStatus("GRST01");
        group.setUpdUserId("수정 user id");
>>>>>>> ff153d8c56d12ae8ae3e863b65b2482c02c0b7f5

        int count = mapper.update(group);
        log.info("UPDATE COUNT: " + count);
    }
<<<<<<< HEAD

    @Test
    public void testUpdateInfo() {
        GroupVO group = new GroupVO();
        group.setSn(96L);
        group.setInfo("update test info info info info info fino");

        int count = mapper.updateInfo(group);
        log.info("UPDATE COUNT: " + count);
    }

    @Test
    public void testDelete() {
        GroupVO group = new GroupVO();
        group.setSn(102L);
        group.setUserId("boseung@naver.com");

        int count = mapper.delete(group);
        log.info("DELETE COUNT: " + count);
    }


=======
>>>>>>> ff153d8c56d12ae8ae3e863b65b2482c02c0b7f5
}
