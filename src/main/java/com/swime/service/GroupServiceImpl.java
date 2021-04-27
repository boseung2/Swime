package com.swime.service;

import com.swime.domain.*;
import com.swime.mapper.GroupAttachMapper;
import com.swime.mapper.GroupAttendMapper;
import com.swime.mapper.GroupMapper;
import com.swime.mapper.GroupTagMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class GroupServiceImpl implements GroupService{

    private GroupMapper groupMapper;
    private GroupAttendMapper groupAttendMapper;
    private GroupTagMapper groupTagMapper;
    private GroupAttachMapper groupAttachMapper;

    @Transactional
    @Override
    public int register(GroupVO group) {
        //모임을 생성한다.

        // 사진 경로 불러옴
        if(group.getAttach() != null) {
            group.setPicture(URLEncoder.encode(getPath(group.getAttach())));
        }

        // 1. 기본정보 등록
        groupMapper.insertSelectKey(group);

        // 2. 모임참여리스트에 모임장등록한다.
        GroupAttendVO groupAttend = new GroupAttendVO();
        groupAttend.setGrpSn(group.getSn());
        groupAttend.setUserId(group.getUserId());
        groupAttend.setGrpRole("GRRO01"); // "GRRO01" = 모임장
        groupAttend.setStatus("GRUS01"); // "GRUS01" = 정상상태
        groupAttendMapper.insertSelectKey(groupAttend);

        // 3. 태그들을 등록한다.
        group.getTags().forEach(tag -> groupTagMapper.insert(new GroupTagVO(group.getSn(), tag)));

        if(group.getAttach() != null) {
            // 첨부파일등록
            GroupAttachVO attach = group.getAttach();
            attach.setGrpSn(group.getSn());
            groupAttachMapper.insert(attach);
        }

        return 1;
    }

    @Transactional
    @Override
    public GroupVO get(Long sn) {
        // 해당 모임 모임상세를 불러온다.
        GroupVO group = groupMapper.read(sn);
        // 해당 모임 태그들을 불러와서 group 객체에 넣는다.
        List<String> tags = new ArrayList<>();
        groupTagMapper.getList(sn).forEach(tag -> tags.add(CodeTable.valueOf(tag.getName()).getValue()));
        group.setTags(tags);
        group.setSido(CodeTable.valueOf(group.getSido()).getValue());
        group.setSigungu(CodeTable.valueOf(group.getSigungu()).getValue());
        group.setCategory(CodeTable.valueOf(group.getCategory()).getValue());
        return group;
    }

    @Transactional
    @Override
    public List<GroupVO> getListWithPaging(GroupCriteria cri) {
        // 모임 리스트를 불러온다. - o
        List<GroupVO> list = groupMapper.getListWithPaging(cri);

        // 각 모임 리스트에 태그를 불러와서 추가한다.
        list.forEach(group -> {
            List<String> tags = new ArrayList<>();
            groupTagMapper.getList(group.getSn()).forEach(tag -> tags.add(CodeTable.valueOf(tag.getName()).getValue()));
            group.setTags(tags);
            group.setSido(CodeTable.valueOf(group.getSido()).getValue());
            group.setSigungu(CodeTable.valueOf(group.getSigungu()).getValue());
            group.setCategory(CodeTable.valueOf(group.getCategory()).getValue());
        });

        return list;
    }

    @Transactional
    @Override
    public int modify(GroupVO group) {

        log.info("modify.........." +group);

        log.info(group.getSn());

        groupAttachMapper.deleteAll(group.getSn());

        // 사진 경로 불러옴
        if(group.getAttach() != null) {
            group.setPicture(URLEncoder.encode(getPath(group.getAttach())));
        }

        // 모임 정보를 수정한다.
        boolean modifyResult = groupMapper.update(group) == 1;

        // 첨부파일을 첨부한다.
        if(modifyResult && group.getAttach() != null) {
            GroupAttachVO attach = group.getAttach();
            attach.setGrpSn(group.getSn());
            groupAttachMapper.insert(attach);
        }

        // 모임 상세페이지 모임정보(info)를 수정한다.
        groupMapper.updateInfo(group);
        // 모임 태그를 수정한다.(있던거 모두 삭제하고 다시 생성)
        groupTagMapper.delete(group.getSn());
        group.getTags().forEach(tag -> groupTagMapper.insert(new GroupTagVO(group.getSn(), tag)));
        return 1;
    }

    @Transactional
    @Override
    public int remove(GroupVO group) {
        // 첨부파일을 삭제한다.
        groupAttachMapper.deleteAll(group.getSn());
        // 모임을 삭제한다.
        return groupMapper.delete(group);
    }

    @Override
    public int getTotal(GroupCriteria cri) {
        log.info("get total count");
        return groupMapper.getTotalCount(cri);
    }

    @Override
    public GroupAttachVO getAttach(Long grpSn) {
        log.info("get Attach by grpSn" + grpSn);

        return groupAttachMapper.findByGrpSn(grpSn);
    }

    private String getPath(GroupAttachVO attach) {
        return attach.getUploadPath() + "/" + attach.getUuid() + "_" + attach.getFileName();
    }

}
