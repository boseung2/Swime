package com.swime.service;

import com.swime.domain.GroupWishVO;
import com.swime.domain.MemberHistoryVO;
import com.swime.domain.MemberVO;
import com.swime.mapper.GroupWishMapper;
import com.swime.mapper.MemberMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Log4j
@Service
@AllArgsConstructor
public class GroupWishServiceImpl implements GroupWishService{

    private GroupWishMapper mapper;

    @Transactional
    @Override
    public boolean register(GroupWishVO vo) {
        return mapper.insert(vo) == 1;
    }

    @Override
    public GroupWishVO read(GroupWishVO vo) {
        return mapper.read(vo);
    }

    @Override
    public boolean delete(GroupWishVO vo) {
        if(mapper.read(vo) == null) {
            return false;
        }
        return mapper.delete(vo) == 1;
    }

    @Override
    public List<GroupWishVO> getByGroupSn(long grpSn) {
        return mapper.readByGroupSn(grpSn);
    }

    @Override
    public List<GroupWishVO> getByid(String id) {
        return mapper.readByid(id);
    }

    @Override
    public boolean remove(String id, long grpSn) {
        return mapper.delete(id, grpSn) == 1;
    }
}
